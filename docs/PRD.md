# PRD: 혼자밥먹는 사람을 위한 밥 같이 먹기

Project Name: 혼자밥먹는 사람을 위한 밥 같이 먹기
One-liner: A system that matches people who dislike eating alone to share meals together.
Device Target: mobile_app
Device Target Detail: 모바일 앱
IDE Target: cursor

## 1. Product Overview

This document outlines the requirements for "혼자밥먹는 사람을 위한 밥 같이 먹기" (A system that matches people who dislike eating alone to share meals together), a mobile application designed to connect individuals seeking meal companions. The core value proposition is to alleviate the loneliness of eating alone by matching users based on their food preferences. Users will select their preferred foods upon signing up and be matched with others who share similar tastes, enabling them to find and share meals together. The application will be developed for mobile platforms (iOS/Android) using React Native, Firebase Functions, and Firestore, with Cursor as the primary IDE.

## 2. Out of Scope

*   Real-time location tracking for exact meetups (only general location text will be supported).
*   Complex group matching (MVP focuses on 1:1 matching).
*   Integrated payment for meals (users handle payments directly).
*   Restaurant booking integration.
*   Video/voice chat functionality.
*   Advanced moderation tools beyond basic reporting.

## 3. Target Users

*   **People eating alone:** Individuals who frequently eat alone and wish to find companionship for meals.
*   **People looking for meal companions:** Users actively seeking others to share dining experiences with.

### Target persona — depth

People who are tired of eating alone and want to find someone to share a meal with. They value shared experiences, convenience, and connecting with others who have similar interests, especially regarding food.

## 4. Core Features (Features)

| ID | Title | Description | Priority | Screens |
| :-- | :-- | :-- | :-- | :-- |
| `feat-1f6665` | **User Food Preference Matching** | To match meal companions, the app must determine if two users have similar food preferences. Users select their favorite foods upon signing up, and based on this data, the app generates a list of various foods to gather user preference data and matches users with similar tastes. The feature must include a list of food types (e.g., Chinese, Japanese) for selection and a matching function based on these choices. | `must` | User Profile Card |
| `feat-profile-mgmt` | **User Profile Management** | Users can create and edit their personal profile, including a profile picture, display name, a short bio, and their general location. This allows other users to learn more about potential meal companions. | `must` | Profile Edit Screen, User Profile Card |
| `feat-meal-request` | **Meal Request Creation** | Users can post a new request to find a meal companion. This includes specifying preferred cuisine types, desired meal time (date/time range), a general meeting location (text input), and the number of companions sought (initially 1). | `must` | Create Meal Request Screen |
| `feat-browse-filter` | **Browse & Filter Meal Requests** | Users can view a list of active meal requests posted by other users. The list should be filterable by cuisine type, meal time, and general location, helping users find relevant opportunities. | `must` | Home Screen (Meal Requests List) |
| `feat-match-accept` | **Meal Request Acceptance & Matching** | Users can accept an open meal request from another user. Upon acceptance, a "match" is created between the two users, and both are notified. This initiates the process of sharing a meal. | `must` | Meal Request Detail Screen |
| `feat-in-app-chat` | **In-App Chat for Matched Users** | Matched users can communicate with each other through a simple in-app chat interface. This allows them to coordinate details for their shared meal, such as exact meeting spot and time. | `must` | Chat Screen |

## 5. Screens & Routes

| Route | Name | Purpose | Feature ID | Theme |
| :-- | :-- | :-- | :-- | :-- |
| `/login` | Login/Signup Screen | Allows users to authenticate or create a new account. | `auth` | `deep_navy` |
| `/onboarding/food-preferences` | Food Preference Selection | Users select their favorite food types during signup/onboarding. | `feat-1f6665` | `deep_navy` |
| `/profile/edit` | Profile Edit Screen | Users can update their profile information (picture, bio, location). | `feat-profile-mgmt` | `deep_navy` |
| `/profile/:user_id` | User Profile Card | Displays a user's profile, including food preferences and bio, for potential companions. | `feat-1f6665`, `feat-profile-mgmt` | `deep_navy` |
| `/home` | Home Screen (Meal Requests List) | Displays a list of available meal requests, with filtering options. | `feat-browse-filter` | `deep_navy` |
| `/meal-requests/new` | Create Meal Request Screen | Allows users to post a new meal request. | `feat-meal-request` | `deep_navy` |
| `/meal-requests/:request_id` | Meal Request Detail Screen | Shows detailed information about a specific meal request. | `feat-browse-filter`, `feat-match-accept` | `deep_navy` |
| `/matches` | My Matches Screen | Lists all active and past matches for the current user. | `feat-match-accept` | `deep_navy` |
| `/matches/:match_id/chat` | Chat Screen | Provides a messaging interface for matched users. | `feat-in-app-chat` | `deep_navy` |

## 6. Data Model

### User
| Field | Type | Required | Description |
| :-- | :-- | :-- | :-- |
| `id` | `string` | ✓ | Primary key (Firebase Auth UID) |
| `email` | `string` | ✓ | User's email address |
| `display_name` | `string` | ✓ | User's chosen display name |
| `profile_picture_url` | `string` | | URL to user's profile image |
| `bio` | `text` | | Short user biography |
| `location_text` | `string` | | General text description of user's location (e.g., "Gangnam, Seoul") |
| `food_preference_ids` | `array<string>` | ✓ | Array of `FoodItem` IDs the user prefers |
| `created_at` | `timestamp` | ✓ | Timestamp of user creation |
| `updated_at` | `timestamp` | ✓ | Timestamp of last profile update |

### FoodItem
| Field | Type | Required | Description |
| :-- | :-- | :-- | :-- |
| `id` | `string` | ✓ | Primary key (e.g., "korean", "chinese") |
| `name_ko` | `string` | ✓ | Food item name in Korean (e.g., "한식") |
| `name_en` | `string` | ✓ | Food item name in English (e.g., "Korean") |
| `description` | `text` | | Optional description of the food type |

### MealRequest
| Field | Type | Required | Description |
| :-- | :-- | :-- | :-- |
| `id` | `string` | ✓ | Primary key |
| `requester_user_id` | `string` | ✓ | ID of the user who created the request |
| `cuisine_preference_ids` | `array<string>` | ✓ | Array of `FoodItem` IDs for this request |
| `meal_time` | `timestamp` | ✓ | Desired time for the meal |
| `location_text` | `string` | ✓ | General text description of meeting location |
| `num_companions_sought` | `integer` | ✓ | Number of companions the requester is looking for (MVP: 1) |
| `status` | `enum` | ✓ | `open`, `matched`, `closed`, `cancelled` |
| `created_at` | `timestamp` | ✓ | Timestamp of request creation |
| `updated_at` | `timestamp` | ✓ | Timestamp of last update |

### Match
| Field | Type | Required | Description |
| :-- | :-- | :-- | :-- |
| `id` | `string` | ✓ | Primary key |
| `meal_request_id` | `string` | ✓ | ID of the `MealRequest` this match is for |
| `requester_user_id` | `string` | ✓ | ID of the user who made the original request |
| `companion_user_id` | `string` | ✓ | ID of the user who accepted the request |
| `status` | `enum` | ✓ | `pending_confirmation`, `confirmed`, `completed`, `cancelled` |
| `created_at` | `timestamp` | ✓ | Timestamp of match creation |
| `updated_at` | `timestamp` | ✓ | Timestamp of last update |

### ChatMessage
| Field | Type | Required | Description |
| :-- | :-- | :-- | :-- |
| `id` | `string` | ✓ | Primary key |
| `match_id` | `string` | ✓ | ID of the `Match` this message belongs to |
| `sender_user_id` | `string` | ✓ | ID of the user who sent the message |
| `message_text` | `text` | ✓ | Content of the message |
| `sent_at` | `timestamp` | ✓ | Timestamp when the message was sent |

## 7. API Design (Backend Contract)

Base URL: `[TBD: Firebase Functions HTTP trigger URL]`

| Method | Path | Request Body | Response 200 | Error Codes | Auth Scope | Entity Ref | Purpose |
| :-- | :-- | :-- | :-- | :-- | :-- | :-- | :-- |
| `POST` | `/auth/signup` | `{email, password, display_name}` | `{id, email, display_name, created_at}` | `400, 409` | `guest` | `User` | Register a new user account. |
| `POST` | `/auth/login` | `{email, password}` | `{token}` | `401` | `guest` | `User` | Authenticate user and return JWT. |
| `GET` | `/auth/me` | | `{id, email, display_name, profile_picture_url, bio, location_text, food_preference_ids, created_at}` | `401` | `authenticated` | `User` | Get current authenticated user's profile. |
| `GET` | `/users/{user_id}` | | `{id, display_name, profile_picture_url, bio, location_text, food_preference_ids}` | `401, 404` | `authenticated` | `User` | Get a specific user's public profile. |
| `PUT` | `/users/me` | `{display_name?, profile_picture_url?, bio?, location_text?, food_preference_ids?}` | `{id, display_name, profile_picture_url, bio, location_text, food_preference_ids, updated_at}` | `400, 401` | `authenticated` | `User` | Update current user's profile. |
| `GET` | `/food_items` | | `[{id, name_ko, name_en, description}]` | `401` | `authenticated` | `FoodItem` | Get list of all available food types. |
| `POST` | `/meal_requests` | `{cuisine_preference_ids, meal_time, location_text, num_companions_sought}` | `{id, requester_user_id, cuisine_preference_ids, meal_time, location_text, status, created_at}` | `400, 401` | `authenticated` | `MealRequest` | Create a new meal request. |
| `GET` | `/meal_requests` | `?cuisine_ids=id1,id2&time_start=ts1&time_end=ts2&location_text=text` | `[{id, requester_user_id, cuisine_preference_ids, meal_time, location_text, status, created_at}]` | `401` | `authenticated` | `MealRequest` | List open meal requests, with optional filters. |
| `GET` | `/meal_requests/{request_id}` | | `{id, requester_user_id, cuisine_preference_ids, meal_time, location_text, num_companions_sought, status, created_at}` | `401, 404` | `authenticated` | `MealRequest` | Get details of a specific meal request. |
| `POST` | `/meal_requests/{request_id}/accept` | | `{id, meal_request_id, requester_user_id, companion_user_id, status, created_at}` | `400, 401, 404, 409` | `authenticated` | `Match` | Accept a meal request, creating a match. |
| `GET` | `/matches/me` | `?status=active,completed` | `[{id, meal_request_id, requester_user_id, companion_user_id, status, created_at}]` | `401` | `authenticated` | `Match` | List current user's matches. |
| `PUT` | `/matches/{match_id}/confirm` | | `{id, status=confirmed, updated_at}` | `400, 401, 404` | `authenticated` | `Match` | Confirm a pending match. |
| `PUT` | `/matches/{match_id}/cancel` | | `{id, status=cancelled, updated_at}` | `400, 401, 404` | `authenticated` | `Match` | Cancel an active match. |
| `GET` | `/matches/{match_id}/messages` | `?limit=50&start_after=message_id` | `[{id, sender_user_id, message_text, sent_at}]` | `401, 404` | `authenticated` | `ChatMessage` | Get chat messages for a specific match. |
| `POST` | `/matches/{match_id}/messages` | `{message_text}` | `{id, match_id, sender_user_id, message_text, sent_at}` | `400, 401, 404` | `authenticated` | `ChatMessage` | Send a new chat message within a match. |

## 8. Auth & Permissions

*   **Login required:** Yes
*   **Methods:** Google OAuth (Firebase Authentication)
*   **Roles:**
    *   `authenticated`: All users who have successfully logged in. Can access all features.
    *   `guest`: Unauthenticated users. Can only access `/auth/signup` and `/auth/login`.

## 9. External Integrations (PG, OAuth, MCP, AI models)

*   **Payment Gateway (PG):**
    *   Enabled: No
    *   Notes: Not required for MVP.
*   **OAuth:**
    *   Enabled: Yes
    *   Providers: Google (via Firebase Authentication)
    *   Callback Path Pattern: `/api/auth/callback/{provider}` (handled by Firebase)
    *   Environment Variables: `FIREBASE_API_KEY`, `FIREBASE_AUTH_DOMAIN`, `FIREBASE_PROJECT_ID`, etc.
    *   Flow Description: Users will be redirected to Google for authentication, then back to the app. Firebase handles token exchange and session management.
*   **Mobile Content Platform (MCP):**
    *   Enabled: Yes
    *   Servers: AdMob
    *   Notes: App advertising (AdMob) will be integrated for monetization.
    *   Environment Variables: `ADMOB_APP_ID`, `ADMOB_BANNER_AD_UNIT_ID` (for specific ad placements).
*   **AI Models:**
    *   Enabled: No
    *   Notes: Not required for MVP. Food preference matching is rule-based.

## 10. Monetization & Analytics

*   **Monetization Model:** Ad-supported (Free + advertising)
*   **Implementation Notes:**
    *   Requires integration of the Google AdMob SDK into the React Native application.
    *   Ad placements (e.g., banner ads, interstitial ads) will be strategically placed within the UI, particularly on screens with high user engagement like the meal request browsing list.
*   **Analytics Tracking:** No (as per `profile_json`)
*   **Product KPIs:**
    *   30% or higher 7-day revisit rate (primary success metric)
    *   Number of new meal requests created per day.
    *   Number of successful matches per day.
    *   Average daily active users (DAU).
    *   Ad impression count and click-through rate.

## 11. Acceptance Criteria (Given/When/Then)

1.  **User Food Preference Selection:**
    *   **Given** a new user is completing the signup process.
    *   **When** the user navigates to the food preference selection screen (`/onboarding/food-preferences`), selects "Korean" and "Japanese" from the provided list, and taps "Save".
    *   **Then** a `PUT /users/me` request is sent with `food_preference_ids` containing `["korean", "japanese"]`, the user's preferences are successfully stored, and the user is redirected to the home screen.
2.  **User Profile Update:**
    *   **Given** an authenticated user is on their profile edit screen (`/profile/edit`).
    *   **When** the user updates their `bio` to "Loves trying new restaurants" and their `display_name` to "MealMate" and taps "Save".
    *   **Then** a `PUT /users/me` request is sent with the updated fields, the profile is successfully updated in the backend, and the changes are reflected on the user's profile card (`/profile/:user_id`).
3.  **Meal Request Creation:**
    *   **Given** an authenticated user is on the "Create Meal Request" screen (`/meal-requests/new`).
    *   **When** the user selects "Chinese" cuisine, sets `meal_time` for "tomorrow 7 PM", `location_text` as "Hongdae", and taps "Post Request".
    *   **Then** a `POST /meal_requests` request is sent with the specified details, a new `MealRequest` is created with `status: 'open'`, and the user is redirected to the home screen.
4.  **Browse & Filter Meal Requests:**
    *   **Given** an authenticated user is on the Home screen (`/home`) viewing meal requests.
    *   **When** the user applies a filter for "Korean" cuisine.
    *   **Then** a `GET /meal_requests?cuisine_ids=korean` request is made, and only meal requests matching "Korean" cuisine are displayed in the list.
5.  **Meal Request Acceptance & Match Creation:**
    *   **Given** an authenticated user is viewing a specific open meal request on the Meal Request Detail screen (`/meal-requests/:request_id`).
    *   **When** the user taps the "Accept Request" button.
    *   **Then** a `POST /meal_requests/{request_id}/accept` request is sent, a new `Match` entity is created linking the requester and the companion, the `MealRequest` status is updated to `matched`, and both users receive an in-app notification about the new match.
6.  **In-App Chat Message Sending:**
    *   **Given** two users are matched and are on the Chat screen for their match (`/matches/:match_id/chat`).
    *   **When** User A types "Hi, looking forward to our meal!" and taps "Send".
    *   **Then** a `POST /matches/{match_id}/messages` request is sent, a new `ChatMessage` is stored, and the message appears in the chat history for both users.
7.  **AdMob Banner Display:**
    *   **Given** an authenticated user is on the Home screen (`/home`).
    *   **When** the screen loads and the AdMob SDK is initialized.
    *   **Then** an AdMob banner ad is displayed at the bottom of the screen, without obstructing critical UI elements.

## 12. AI Workflow (IDE-specific)

**IDE Target: Cursor**

The implementation will leverage Cursor's AI capabilities, specifically its `Composer` and `Agent` features, along with custom `.cursor/rules/*.mdc` files for enforcing project standards.

1.  **Project Setup & Initial Structure:**
    *   **Agent Command:** `cursor: create-react-native-app --template typescript`
    *   **Composer Prompt:** "Set up Firebase project configuration for React Native, including `firebase.json`, `google-services.json`, `GoogleService-Info.plist`, and `firebase.ts` initialization. Ensure Firebase Auth and Firestore are configured."
2.  **Data Model & API Client Generation:**
    *   **Agent Command:** `cursor: generate-firestore-models --schema-file data_model.json` (assuming a JSON representation of the data model is created first).
    *   **Composer Prompt:** "Generate a TypeScript API client for the backend contract defined in section 7. Use `axios` or `fetch` and include type definitions for all request/response bodies. Ensure authentication headers are handled."
3.  **Feature Implementation (Iterative):**
    *   For each core feature (e.g., User Food Preference Matching, Meal Request Creation):
        *   **Composer Prompt:** "Implement the `[Feature Name]` feature. This involves creating the `[Screen Name]` component (e.g., `FoodPreferenceSelectionScreen.tsx`), integrating with the `[API Endpoint]` (e.g., `PUT /users/me` for food preferences), and updating the `User` data model. Pay close attention to the `deep_navy` theme and user experience."
        *   **Agent Command:** `cursor: create-react-native-screen --name FoodPreferenceSelectionScreen --route /onboarding/food-preferences`
        *   **Agent Command:** `cursor: create-react-native-component --name FoodPreferencePicker --props foodItems:FoodItem[], selectedIds:string[], onSelect:(id:string)=>void`
4.  **Authentication Flow:**
    *   **Composer Prompt:** "Implement the Google OAuth login flow using Firebase Authentication. Create a `LoginScreen.tsx` and integrate with `POST /auth/signup` and `POST /auth/login`. Handle user session management and redirection after successful login."
5.  **UI/UX & Styling:**
    *   **Composer Prompt:** "Apply the `deep_navy` theme consistently across all screens. Use React Native's `StyleSheet` or a styling library. Ensure responsive design for various mobile devices."
6.  **AdMob Integration:**
    *   **Composer Prompt:** "Integrate Google AdMob SDK. Create a `BannerAdComponent.tsx` and place it on the `HomeScreen.tsx` as specified in the monetization section. Ensure ad unit IDs are loaded from environment variables."
7.  **Testing & Refinement:**
    *   **Composer Prompt:** "Write unit and integration tests for the `[Feature Name]` feature, covering the acceptance criteria in section 11. Use `jest` and `react-native-testing-library`."
    *   **Agent Command:** `cursor: refactor-code --goal "Improve readability and adherence to ESLint rules"`
8.  **Custom Cursor Rules (`.cursor/rules/*.mdc`):**
    *   A rule will be created to enforce snake_case for backend API fields and camelCase for frontend state variables.
    *   Another rule will ensure all sensitive API keys/secrets are referenced via environment variables, not hardcoded.
    *   A rule to check for consistent `deep_navy` theme usage.

## 13. Do NOT (AI forbidden rules)

*   Do not arbitrarily add features, screens, or APIs that are not explicitly defined in this PRD.
*   Do not present unverified figures, dates, or forecasts as facts.
*   Do not implement production deployment or service domain connections without explicit requests.
*   Do not hardcode API keys, secrets, or PG keys in the code; reference them only through environment variables (`.env`).
*   Do not use any third-party libraries or services not mentioned in this document without explicit approval.
*   Do not implement complex real-time features (e.g., live location