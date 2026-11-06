import pytest
from django.contrib.auth.models import User
from django.test import Client


@pytest.fixture
def client() -> Client:
    return Client()


def test_health_check(client: Client):
    response = client.get("/api/v1/health")
    assert response.status_code == 200
    assert response.json() == {"status": "ok"}


@pytest.mark.django_db
def test_obtain_jwt(client: Client):
    User.objects.create_user(username="testuser", password="Password123!")

    response = client.post(
        "/api/v1/token/pair",
        {"username": "testuser", "password": "Password123!"},
        content_type="application/json",
    )
    assert response.status_code == 200
    data = response.json()
    assert "access" in data
    assert "refresh" in data
