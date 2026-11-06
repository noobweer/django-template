# Django Ninja API Template

Minimalist starter template for Django REST APIs with Django Ninja Extra, Granian, uv, and Ruff.

## Tech Stack

Django 6, Django Ninja, Django Ninja Extra, Django Ninja JWT, Granian, uv, Ruff, Lefthook, Pydantic Settings, PostgreSQL 16, Docker Compose, Pytest.

## Quick Start

```bash
make install
make migrate
make dev
```

Or with Docker:

```bash
cp .env.example .env
make up
```

## Commands

- `make dev` - Start Granian ASGI dev server with reload
- `make migrate` - Apply database migrations
- `make makemigrations` - Generate database migrations
- `make createsuperuser` - Create Django superuser
- `make test` - Run pytest
- `make lint` - Run ruff check
- `make format` - Format code and fix ruff issues
- `make check` - Run ruff check, format check, and pytest
- `make hooks` - Install Lefthook git hooks
- `make up` - Start Docker Compose services
- `make down` - Stop Docker Compose services
- `make logs` - View API container logs
- `make clean` - Remove pycache and pytest cache
