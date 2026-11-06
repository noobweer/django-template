# ==========================================
# Stage 1: Build virtual environment with uv
# ==========================================
FROM python:3.12-slim-bookworm AS builder

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

WORKDIR /app

ENV UV_COMPILE_BYTECODE=1 \
    UV_LINK_MODE=copy

COPY pyproject.toml uv.lock ./

RUN uv sync --frozen --no-dev --no-install-project

# ==========================================
# Stage 2: Minimal runtime image
# ==========================================
FROM python:3.12-slim-bookworm AS runner

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -r -g 1000 appgroup && \
    useradd -r -u 1000 -g appgroup -d /app -s /bin/bash appuser

COPY --from=builder --chown=appuser:appgroup /app/.venv /app/.venv

ENV PATH="/app/.venv/bin:$PATH" \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

COPY --chown=appuser:appgroup config ./config
COPY --chown=appuser:appgroup apps ./apps
COPY --chown=appuser:appgroup manage.py ./manage.py
COPY --chown=appuser:appgroup docker/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

USER appuser

EXPOSE 8000

ENTRYPOINT ["/entrypoint.sh"]
CMD ["granian", "--interface", "asginl", "config.asgi:application", "--host", "0.0.0.0", "--port", "8000", "--workers", "2"]
