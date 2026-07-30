# Mock Sandbox

실제 키·PG·외부 API 연동 없이 앱을 **빌드·실행·검증**하기 위한 목 스텁 모음입니다.
온보딩에서 판정된 인프라(auth/결제/외부 API)를 기반으로 자동 생성되었습니다.

## 환경변수 표 (Vercel 등록용)

Key 이름은 **대소문자까지** SETUP_GUIDE.md 와 동일해야 합니다.

| Key | 연습 모드 | 실전 전환 시 |
|---|---|---|
| `NEXT_PUBLIC_SUPABASE_URL` | Supabase Project URL | 동일 |
| `NEXT_PUBLIC_SUPABASE_ANON_KEY` | Supabase anon key | 동일 |
| `USE_MOCK_SANDBOX` | `true` | `false` 로 변경 + Redeploy |
| `OAUTH_CLIENT_ID` | (목 사용 — 불필요) | OAuth 앱에서 발급 |
| `OAUTH_CLIENT_SECRET` | (목 사용 — 불필요) | OAuth 앱에서 발급 |

## 포함된 목
- `mocks/auth/mock_oauth.py` — OAuth/소셜 로그인(google)

## 실연동 전환
1. 각 목 파일의 함수 본문을 실제 SDK/HTTP 호출로 교체합니다.
2. 파일 상단 주석에 명시된 환경변수를 `.env` 에 설정합니다.
3. `SANDBOX = True` 를 `False` 로 바꿉니다.

> 목은 항상 성공/유효를 반환하므로, 실연동 전에는 결제 실패·인증 거부 케이스를 검증할 수 없습니다.
