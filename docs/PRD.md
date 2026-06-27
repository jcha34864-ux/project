# PRD: 혼밥하는 사람들을 위한 듀오밥

## 1. Product Overview
- **One-liner**: A platform that creates a community for people who eat alone to share information and arrange blind dates.
- **Mission**: To provide a space for communication for those who eat alone, facilitating information sharing and the creation of new connections.
- **Differentiation Points**: Strengthening connections between users through personalized food recommendations and blind date features for those who enjoy eating alone.
- **Personas**:
  1. Office workers who enjoy eating alone (30s, prefer dining alone)
  2. College students looking for casual relationships (20s, desire to meet new people)
  3. Lonely individuals wanting to try eating alone (40s, seeking new experiences)
- **Usage Scenarios**:
  1. Users find suitable foods for solo dining through the food recommendation system and share them with other users.
  2. Users arrange meetings with interested individuals through the blind date feature.

## 2. Out of Scope
- Integration with external payment systems is excluded from the MVP scope.
- Direct messaging functionality between users is not included.

## 3. Target Users
- **People who enjoy eating alone**: 
  - **Occupation/Age/Context**: Office workers, 30s, prefer dining alone.
  - **Pain**: Eating alone feels lonely, and finding good food is difficult.
  - **Gain**: Seeking new experiences through food recommendations and connections with others.
  - **Trigger**: When wanting to try new foods.
  
- **People looking for casual relationships**: 
  - **Occupation/Age/Context**: College students, 20s, desire to meet new people.
  - **Pain**: Feel there are few opportunities for blind dates and find it hard to meet people.
  - **Gain**: Want to expand social relationships through meetings with new individuals.
  - **Trigger**: When inspired by a friend's blind date experience.

- **People wanting to try eating alone**: 
  - **Occupation/Age/Context**: Lonely middle-aged individuals, 40s, seeking new experiences.
  - **Pain**: Fear of dining alone.
  - **Gain**: Desire for an environment where they can comfortably eat alone.
  - **Trigger**: When wanting to become accustomed to dining alone.

## 4. Features

| id          | Name                | Priority | One-liner Description                             | Core User Story                       | Core Acceptance                        | Screen Ref                  |
|-------------|---------------------|----------|--------------------------------------------------|---------------------------------------|----------------------------------------|-----------------------------|
| feat-72b70b | Food Recommendation System | must     | Personalized food recommendation feature          | Users receive recommendations based on their preferred foods | Accuracy of recommended foods is over 80% | /screen-72b70b             |
| feat-72b70b | Blind Date Feature   | must     | Matching feature for users to arrange blind dates | Users are matched with individuals they are interested in | Conversations with matched users are over 70% positive | /screen-72b70b-2           |
| feat-72b70b | User Profile Management | should   | Feature for editing and managing user information | Users update their profiles           | Changes are reflected immediately after profile update | /profile                    |
| feat-72b70b | Notification Feature  | should   | Notification feature for food recommendations and blind dates | Users receive notifications for new recommendations or matches | Notifications are accurately delivered to users | /notifications              |
| feat-72b70b | Feedback System      | could    | Feature for collecting and analyzing user feedback | Users provide feedback on recommended foods | Over 70% positive response after feedback collection | /feedback                   |

## 5. Screens & Routes

| route                       | Screen Name                                                   | Purpose                                   | Entry Trigger                       | Core Component          | Related Feature id      |
|-----------------------------|--------------------------------------------------------------|------------------------------------------|-------------------------------------|-------------------------|-------------------------|
| /screen-72b70b             | Food Recommendation System — List-Detail Type                | Layout for the food recommendation system | User clicks on the food recommendation feature | Food list, Detail view | feat-72b70b             |
| /screen-72b70b-2           | Food Recommendation System — Seasonal Recommendations like 막걸리 and 파전 in rainy weather, or 빙수 and 화채 in summer | Seasonal recommendation screen of the food recommendation system | User clicks on seasonal recommendations | Seasonal recommendation list | feat-72b70b             |
| /profile                    | User Profile Management                                       | Editing and managing user information    | User clicks on the profile menu    | Profile edit form      | feat-72b70b             |
| /notifications              | Notification Feature                                          | Notifications related to food recommendations and blind dates | User clicks on the notification menu | Notification list      | feat-72b70b             |
| /feedback                   | Feedback System                                              | Collecting and analyzing user feedback   | User clicks on the feedback menu    | Feedback submission form | feat-72b70b             |

## 6. Data Model

### User
| Field       | Type   | PK/FK/UNIQUE | nullable | Default | Description                       |
|-------------|--------|--------------|----------|---------|-----------------------------------|
| id          | string | PK           |          |         | Primary key                      |
| status      | string |              |          |         | Lifecycle or workflow state      |
| description | text   |              | true     |         | Human-readable summary           |
| label       | string | UNIQUE       |          |         | Display label for UI lists       |

### Food Preference
| Field       | Type   | PK/FK/UNIQUE | nullable | Default | Description                       |
|-------------|--------|--------------|----------|---------|-----------------------------------|
| id          | string | PK           |          |         | Primary key                      |
| status      | string |              |          |         | Lifecycle or workflow state      |
| description | text   |              | true     |         | Human-readable summary           |
| label       | string | UNIQUE       |          |         | Display label for UI lists       |

### Recommendation History
| Field       | Type   | PK/FK/UNIQUE | nullable | Default | Description                       |
|-------------|--------|--------------|----------|---------|-----------------------------------|
| id          | string | PK           |          |         | Primary key                      |
| status      | string |              |          |         | Lifecycle or workflow state      |
| description | text   |              | true     |         | Human-readable summary           |
| label       | string | UNIQUE       |          |         | Display label for UI lists       |

### Notification
| Field       | Type   | PK/FK/UNIQUE | nullable | Default | Description                       |
|-------------|--------|--------------|----------|---------|-----------------------------------|
| id          | string | PK           |          |         | Primary key                      |
| status      | string |              |          |         | Lifecycle or workflow state      |
| description | text   |              | true     |         | Human-readable summary           |
| label       | string | UNIQUE       |          |         | Display label for UI lists       |

### Relationship Diagram
- User (User) ↔ Food Preference (FoodPreference): 1:N
- User (User) ↔ Recommendation (Recommendation): 1:N
- User (User) ↔ Notification (Notification): 1:N

## 7. Backend Contract

| method | path                     | Request Body             | Response 200                   | Error Code       | auth_scope      | Calling Screen       |
|--------|--------------------------|--------------------------|--------------------------------|------------------|------------------|----------------------|
| POST   | /auth/signup             | {email, password}        | {id, created_at}               | 400, 409         | guest            | /login               |
| POST   | /auth/login              | {email, password}        | {token}                        | 401              | guest            | /login               |
| GET    | /auth/me                |                          | {id, email, created_at}        | 401              | authenticated     | /login               |
| POST   | /screens                 | {...}                    | {id, created_at}               | 400              | authenticated     | /screens             |
| GET    | /screens                 |                          | [{...}]                        | 401              | authenticated     | /screens             |
| POST   | /food-preferences        | {...}                    | {id, created_at}               | 400              | authenticated     | /screens             |
| GET    | /food-preferences        |                          | [{...}]                        | 401              | authenticated     | /screens             |
| POST   | /recommendations         | {...}                    | {id, created_at}               | 400              | authenticated     | /screens             |
| GET    | /recommendations         |                          | [{...}]                        | 401              | authenticated     | /screens             |
| POST   | /notifications           | {...}                    | {id, created_at}               | 400              | authenticated     | /screens             |
| GET    | /notifications           |                          | [{...}]                        | 401              | authenticated     | /screens             |

## 8. Authentication & Authorization

- **Authentication Method**: Email-based authentication
- **Role Matrix**:
  - User: Access to all features
  - Admin: Access to all features (additional features may be required)
- **Session/Token Policy**: JWT-based tokens used

## 9. External Integration (PG, OAuth, MCP, AI Models)

| Integration Type | Purpose                       | Environment Variable         | Callback Path                     | Failure Fallback               |
|------------------|-------------------------------|------------------------------|-----------------------------------|--------------------------------|
| MCP              | Kakao Talk, Naver Maps        | [TBD: Required environment variables] | /service-connection/auth/callback/{provider} | Send error message to user |

## 10. Monetization & Analytics

- **Pricing**: Free (providing basic features), generating revenue through affiliate marketing
- **Payment Timing**: Consider monetization when introducing additional features
- **Refund Policy**: None (free service)
- **Key KPIs**:
  1. Over 1,000 active users per month
  2. Food recommendation accuracy over 80%
  3. User feedback positivity rate over 70%

## 11. Acceptance Criteria

| Given                                      | When                                        | Then                                   | Feature id to Validate |
|--------------------------------------------|--------------------------------------------|----------------------------------------|-------------------------|
| User is in the app                         | When using core features                    | Over 200 active users within a month   | feat-72b70b             |
| User is in the app                         | When using core features                    | Food recommendation accuracy over 80%   | feat-72b70b             |
| User is in the app                         | When using core features                    | User feedback positivity rate over 70%   | feat-72b70b             |

## 12. AI Workflow (Customized by IDE)

1. Create a `CLAUDE.md` file to summarize the project overview and goals.
2. Create a `rules.md` file to define rules for backend contract and data model.
3. Create a `commands.md` file to outline commands and usage for each feature.
4. Create an `integration.md` file to explain how to integrate external services.
5. Based on each file, allow coding AI to automatically generate necessary parts.
6. Ensure that the code generated by AI is reviewed before deployment.
7. Manage service connection keys and secret information only through environment variables.
8. Proceed with feature requests only when explicitly requested.

## 13. Do NOT (AI Prohibited Rules)
- Do not arbitrarily add features, screens, or APIs that are not in the requirements.
- Do not present unverified figures, dates, or forecasts as facts.
- Do not implement production deployment or connect to live service domains without explicit requests.
- Do not hardcode service connection keys, secrets, or PG keys in the code; reference them only through environment variables (.env).