from ninja import Schema
from ninja_extra import ControllerBase, NinjaExtraAPI, api_controller, http_get
from ninja_jwt.controller import NinjaJWTDefaultController

api = NinjaExtraAPI(
    title="Django Ninja API",
    version="1.0.0",
    docs_url="/docs",
    openapi_url="/openapi.json",
)


class HealthSchema(Schema):
    status: str = "ok"


@api_controller("/health", tags=["Health"])
class HealthController(ControllerBase):
    @http_get("", response={200: HealthSchema})
    def health_check(self) -> HealthSchema:
        return HealthSchema(status="ok")


api.register_controllers(
    HealthController,
    NinjaJWTDefaultController,
)
