# PRD: 혼밥하는 사람들을 위한 듀오밥

> 📌 Device: **Web (browser)** · 🧠 Coding IDE: **Claude Code**

> Cubivora Spec-First PRD (auto-generated). Treat this document as the single source of truth during implementation.

## 1. One-liner

혼밥하는 사람들을 만의 커뮤니티를 만들어서 정보를 공유하고 소개팅도 진행하는 플랫폼

## 2. Out of scope

- _(none)_


## 3. Target users

- 혼밥을 즐기는 사람
- 자만추를 원하는 사람
- 혼밥을 도전해보고 싶은 사람


### Target persona — depth

가벼운 만남 선호

## 3.5 Killer differentiator

사용자 매칭 시스템

## 4. Core features

- **[MUST]** 음식 추천 시스템 — 음식 추천 시스템
  - 🔎 Detail: 사용자 취향 설정
  - 🔎 Detail: 추천 알고리즘 조정
  - 🔎 Detail: 자기가 선호하는 음식 기반으로 비슷한 취향을 가진 사람과 매칭

## 5. Screens / URLs

| Route | Page | Purpose |
|-------|------|---------|
| `/screen-72b70b` | 음식 추천 시스템 — 리스트-디테일형 | 음식 추천 시스템 기능의 화면 레이아웃 (리스트-디테일형) |
| `/screen-72b70b-2` | 음식 추천 시스템 — 비 오면 막걸리에 파전 여름엔 빙수나 화채같이 시기에 따라 추천 | 음식 추천 시스템 기능의 화면 레이아웃 (비 오면 막걸리에 파전 여름엔 빙수나 화채같이 시기에 따라 추천) |

## 5.5 Per-feature screens

### 🧩 Screens for the “음식 추천 시스템” feature
- 리스트-디테일형
- 비 오면 막걸리에 파전 여름엔 빙수나 화채같이 시기에 따라 추천

## 6. Data model

### 사용자
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| id | string | ✓ | Primary key |
| status | string | ✓ | Lifecycle or workflow state |
| description | text |  | Human-readable summary |
| label | string | ✓ | Display label for UI lists |

### 음식 취향
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| id | string | ✓ | Primary key |
| status | string | ✓ | Lifecycle or workflow state |
| description | text |  | Human-readable summary |
| label | string | ✓ | Display label for UI lists |

### 추천 내역
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| id | string | ✓ | Primary key |
| status | string | ✓ | Lifecycle or workflow state |
| description | text |  | Human-readable summary |
| label | string | ✓ | Display label for UI lists |

### 알림
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| id | string | ✓ | Primary key |
| status | string | ✓ | Lifecycle or workflow state |
| description | text |  | Human-readable summary |
| label | string | ✓ | Display label for UI lists |


## 7. Authentication & permissions

- Login required: **no**
- Methods: email
- Roles: _(none)_

## 8. Monetization & analytics (impact on code)

- **Model**: Mixed (e.g. free + ads + paid tier)
- **Implementation notes**:
  - No additional monetization or analytics modules for MVP.
- **Memo**: 제휴 마케팅


## 9. External integrations (PG · OAuth · MCP)

### Payment (PG)
- No PG integration in MVP.

### Social login (OAuth)
- No social login (email-only or anonymous).

### MCP (optional)
- **Servers**: (to be specified)
- **Notes**: 카카오 알림톡, 네이버 지도


## 10. Tech stack

| Layer | Choice |
|-------|--------|
| Device | Web (browser) |
| Frontend | next |
| Backend | fastapi |
| Database | postgresql |
| Deployment | TBD |

## 11. Acceptance criteria

1. **Given** 사용자가 앱에 진입한 상태에서 **When** 주요 기능을 사용했을 때 **Then** 한 달 내 200명 이상 활성 사용자
2. **Given** 사용자가 앱에 진입한 상태에서 **When** 주요 기능을 사용했을 때 **Then** 음식 추천 정확도 80% 이상
3. **Given** 사용자가 앱에 진입한 상태에서 **When** 주요 기능을 사용했을 때 **Then** 사용자 피드백 긍정률 70% 이상

## 12. Do NOT (AI prohibitions)

- 요구사항에 없는 기능·화면·API를 임의로 추가하지 않는다.
- 확인되지 않은 수치·날짜·전망을 사실처럼 쓰지 않는다.
- 프로덕션 배포·실서비스 도메인 연결은 명시적 요청 없이 구현하지 않는다.
- API 키·시크릿·PG 키는 코드에 하드코딩하지 않고 환경변수(.env)로만 참조한다.


## 13. Design / references

- UI theme: lavender_tech
- Tone: -
- Reference apps: -
- Coding IDE: Claude Code
