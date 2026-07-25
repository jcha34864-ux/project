## Metadata
- **Project Name**: 최저가 식당 찾기
- **One-liner**: 식비를 아끼고 싶은 사람을 위한 주위 식당의 가격을 비교하는 걸 도와주는
- **Device Target**: Web App
- **Device Target Detail**: 웹 브라우저
- **IDE Target**: Cursor

## 1. Product Overview
The "최저가 식당 찾기" project aims to help users compare prices of nearby restaurants to save on food expenses. The application will provide a budget range filter to assist users in finding dining options within their specified budget.

## 2. Out of Scope
- None specified. [TBD: No explicit out-of-scope items provided.]

## 3. Target Users
- Individuals living alone who wish to change their spending habits.
- Persona: People who want to consume cost-effectively, driven by curiosity.

## 4. Core Features
- **[MUST] Budget Range Filter**
  - Allows users to filter restaurants based on their budget.
  - **Detail**: Users can record and manage their filter preferences.

## 5. Screens & Routes
| Route           | Page                         | Purpose                                         |
|-----------------|------------------------------|-------------------------------------------------|
| `/screen-04861c`| Budget Range Filter          | Layout for the budget range filter functionality |

## 6. Data Model
### 사용자 (User)
| Field       | Type   | Required | Description                        |
|-------------|--------|----------|------------------------------------|
| id          | string | ✓        | Primary key                        |
| status      | string | ✓        | Lifecycle or workflow state        |
| description | text   |          | Human-readable summary             |
| label       | string | ✓        | Display label for UI lists         |

## 7. API Design (Backend Contract)
| Method | Path         | Request Body         | Response 200            | Error Codes | Auth Scope    |
|--------|--------------|----------------------|-------------------------|-------------|---------------|
| POST   | /auth/signup | {email, password}    | {id, created_at}        | 400, 409    | guest         |
| POST   | /auth/login  | {email, password}    | {token}                 | 401         | guest         |
| GET    | /auth/me     |                      | {id, email, created_at} | 401         | authenticated |
| POST   | /screens     | {...}                | {id, created_at}        | 400         | authenticated |
| GET    | /screens     |                      | [{...}]                 | 401         | authenticated |

## 8. Auth & Permissions
- **Login Required**: No
- **Methods**: None
- **Roles**: None

## 9. External Integrations (PG, OAuth, MCP, AI models)
- **Payment (PG)**: No integration in MVP.
- **OAuth**: Not enabled.
- **MCP**: Restaurant location API integration planned. [TBD: Specify servers]

## 10. Monetization & Analytics
- **Model**: Ad-supported
- **Implementation Notes**:
  - Integration of ad SDK and UI for ad placement.
- **Memo**: Free with ads

## 11. Acceptance Criteria
1. **Given** the user is on the app **When** they use the main feature **Then** the average session should last at least 5 minutes.
2. **Given** a user filters restaurants by budget **When** the filter is applied **Then** only restaurants within the budget range are displayed.
3. **Given** a user accesses the budget filter screen **When** they adjust the filter settings **Then** the changes are saved and reflected immediately.
4. **Given** a user logs in **When** they access their profile **Then** their session details are retrieved successfully.
5. **Given** a user signs up **When** they provide valid credentials **Then** a new user account is created.

## 12. AI Workflow (IDE-specific)
- **IDE**: Cursor
- **Workflow**:
  - Implement rules in `.cursor/rules/*.mdc`.
  - Use Composer/Agent for task automation and code generation.

## 13. Do NOT (AI forbidden rules)
- Do not add features, screens, or APIs not specified in the requirements.
- Do not present unverified figures, dates, or projections as facts.
- Do not deploy to production or connect to a live service domain without explicit request.
- Do not hardcode API keys, secrets, or PG keys; use environment variables (.env) instead.