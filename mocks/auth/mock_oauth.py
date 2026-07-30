"""Mock OAuth/social login (sandbox).

실제 OAuth 앱 등록 없이 로그인 플로우를 실행/검증하기 위한 목입니다.
callback 패턴: /api/auth/callback/{provider}
실연동 전환: authorize/callback 을 실제 provider 로 교체하고 환경변수(OAUTH_CLIENT_ID, OAUTH_CLIENT_SECRET)를 설정하세요.
"""

from __future__ import annotations

import uuid
from typing import Any

PROVIDERS = ["google"]
SANDBOX = True


def authorize_url(provider: str, state: str | None = None) -> str:
    """provider 인가 URL(목). 실연동: 실제 provider authorize URL 로 교체."""
    st = state or uuid.uuid4().hex[:8]
    return f"/mock-oauth/{provider}?state={st}"


def handle_callback(provider: str, code: str) -> dict[str, Any]:
    """콜백 처리(목). 고정 목 유저를 반환. 실연동: 토큰 교환 + 프로필 조회로 교체."""
    return {
        "provider": provider,
        "user": {
            "id": f"mock_{provider}_{uuid.uuid4().hex[:8]}",
            "email": f"tester+{provider}@example.com",
            "name": f"{provider.title()} Tester",
        },
        "access_token": f"mock_token_{uuid.uuid4().hex[:16]}",
        "sandbox": SANDBOX,
    }
