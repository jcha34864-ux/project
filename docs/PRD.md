# PRD: 혼자밥먹는 사람을 위한 밥 같이 먹기

> 📌 Device: **Mobile app (iOS / Android)** · 🧠 Coding IDE: **Cursor**
> 📝 Device detail (user wording): **모바일 앱**

> Cubivora Spec-First PRD (auto-generated). Treat this document as the single source of truth during implementation.

## 1. One-liner

혼자 밥 먹기 싫은 사람들이 같이 모여서 밥을 먹는 밥먹을 사람을 매칭해주는 시스템

## 2. Out of scope

- _(none)_


## 3. Target users

- 혼밥 하는 사람
- 밥 친구를 찾는 사람


### Target persona — depth

혼밥이 지겨운 사람들이 깊게 쓸 거고 혼밥하다가 밥을 같이 먹고 싶을때 같이 먹을 사람을 찾는 용도로

## 3.5 Killer differentiator

사용자가 선호하는 음식을 선택하고 비슷한 음식을 선택한 사람들 끼리 매칭

## 4. Core features

- **[MUST]** 밥 같이 먹을 사람을 매칭하려면 두 사람의 음식 취향이 비슷한지를 알아야해서 앱 가입하면 자신이 좋아하는 음식을 고르게 하고 그 데이터를 기반으 — 밥 같이 먹을 사람을 매칭하려면 두 사람의 음식 취향이 비슷한지를 알아야해서 앱 가입하면 자신이 좋아하는 음식을 고르게 하고 그 데이터를 기반으론 매칭하도록 먼저 여러가지 음식 리스트를 뽑고 그걸로 사용자의 취향 데이터를 얻어야해 그리고 같은 음식 취향을 가진 사람들을 매칭하는 식으로
  - 🔎 Detail: 음식 취향 매칭 기능은 중식 일식 등 음식 종류 리스트뽑고 그걸 사용자가 선택하게 하고 사용자가 음식 취향을 기반으로 비슷한 취향의 사람을 찾는 매칭 기능도 있어야해
- **[MUST]** 실제 사용자 매칭 및 채팅 기능 추가 — 사용자가 실제 가입한 사용자와 매칭되도록 변경하고, 매칭된 사용자와 채팅할 수 있는 기능을 추가합니다. 채팅 기능에는 메시지 입력 및 전송, 메시지 읽음 확인, 채팅방 나가기 버튼이 포함됩니다.

## 5. Screens / URLs

| Route | Page | Purpose |
|-------|------|---------|
| `/screen-1f6665` | 밥 같이 먹을 사람을 매칭하려면 두 사람의 음식 취향이 비슷한지를 알아야해서 앱 가입하면 자신이 좋아하는 음식을 고르게 하고 그 데이터를 기반으 — 사용자 프로필 카드형 | 밥 같이 먹을 사람을 매칭하려면 두 사람의 음식 취향이 비슷한지를 알아야해서 앱 가입하면 자신이 좋아하는 음식을 고르게 하고 그 데이터를 기반으 기능의 화면 레이아웃 (사용자 프로필 카드형) |

## 5.5 Per-feature screens

### 🧩 Screens for the “밥 같이 먹을 사람을 매칭하려면 두 사람의 음식 취향이 비슷한지를 알아야해서 앱 가입하면 자신이 좋아하는 음식을 고르게 하고 그 데이터를 기반으” feature
- 사용자 프로필 카드형

### 🧩 Screens for the “실제 사용자 매칭 및 채팅 기능 추가” feature
- /screen-1f6665

## 6. Data model

### 사용자
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| id | string | ✓ | Primary key |
| status | string | ✓ | Lifecycle or workflow state |
| description | text |  | Human-readable summary |
| label | string | ✓ | Display label for UI lists |

### 사용자의 음식 취향
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| id | string | ✓ | Primary key |
| status | string | ✓ | Lifecycle or workflow state |
| description | text |  | Human-readable summary |
| label | string | ✓ | Display label for UI lists |


## 7. Authentication & permissions

- Login required: **yes**
- Methods: google
- Roles: _(none)_

## 8. Monetization & analytics (impact on code)

- **Model**: Ad-supported
- **Implementation notes**:
  - Requires ad SDK and ad placement UI.
- **Memo**: 무료 + 광고


## 9. External integrations (PG · OAuth · MCP)

### Payment (PG)
- No PG integration in MVP.

### Social login (OAuth)
- No social login (email-only or anonymous).

### MCP (optional)
- **Servers**: (to be specified)
- **Notes**: 앱 광고 (AdMob)


## 10. Tech stack

| Layer | Choice |
|-------|--------|
| Device | Mobile app (iOS / Android) |
| Frontend | react_native |
| Backend | firebase_functions |
| Database | firestore |
| Deployment | Firebase App Distribution + Firebase Functions |

## 11. Acceptance criteria

1. **Given** 사용자가 앱에 진입한 상태에서 **When** 주요 기능을 사용했을 때 **Then** 7일 재방문율 30% 이상

## 12. Do NOT (AI prohibitions)

- 요구사항에 없는 기능·화면·API를 임의로 추가하지 않는다.
- 확인되지 않은 수치·날짜·전망을 사실처럼 쓰지 않는다.
- 프로덕션 배포·실서비스 도메인 연결은 명시적 요청 없이 구현하지 않는다.
- API 키·시크릿·PG 키는 코드에 하드코딩하지 않고 환경변수(.env)로만 참조한다.


## 13. Design / references

- UI theme: Deep Navy — trustworthy navy palette
- Tone: -
- Reference apps: -
- Coding IDE: Cursor
