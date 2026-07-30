# PRD: 고양이 사진 찍으면 고양이 종 알려주는 앱

---
project_name: 고양이 사진 찍으면 고양이 종 알려주는 앱
one_liner: "App that identifies cat breeds from photos of stray cats taken on the street."
device_target: Web (browser)
device_target_detail: "설치 없는 모바일 웹 (installable-free mobile web)"
ide_target: cubivora
locales: [ko, en]
default_locale: ko
i18n_required: true
---

## 1. Product Overview

| Key | Value |
|-----|-------|
| Product Name | 고양이 사진 찍으면 고양이 종 알려주는 앱 |
| One-liner | App that identifies cat breeds from photos of stray cats taken on the street. |
| Device | Web (browser) — installable-free mobile web (no app store download required) |
| Frontend | Next.js (App Router) |
| Backend | Next.js API Routes |
| Database | PostgreSQL |
| Deployment | Vercel |
| Locales | Korean (`ko`, default), English (`en`) — multilingual; i18n message catalogs required; runtime locale switch required |
| Auth | Google OAuth (required) |
| AI Engine | Google Gemini (cat breed identification via MCP) |
| Map | Google Maps (shooting location display via MCP) |

### Product Purpose
Users photograph stray cats they encounter on the street — either by opening the camera directly in the mobile browser or selecting from their gallery — and the app identifies the cat's breed using Gemini AI. Results include the breed name, characteristics, and personality traits. A breed encyclopedia (도감) accumulates identified breeds as a collectible album, which is the killer differentiator.

### i18n Requirements
- All UI strings must be stored in per-locale message catalogs: `messages/ko.json`, `messages/en.json`
- Runtime locale switch must be available in the UI (toggle or dropdown)
- Default locale: `ko`
- Use `next-intl` (or equivalent) for Next.js App Router i18n
- User-facing copy in this document is shown as: `"English copy" ("한국어 복사본")`

### Data Privacy Notice
This app stores user-uploaded cat photos on the server. Although photos are of cats (not people), they may incidentally contain faces, location metadata (EXIF), or other personal data. The following applies:
- Uploaded images are stored in object storage (e.g., Vercel Blob or S3-compatible)
- EXIF metadata is stripped server-side before storage
- Retention period: `[TBD: business decision on how long to keep uploaded photos]`
- Users are informed of photo storage via a privacy notice on first use

---

## 2. Out of Scope

The profile explicitly lists no out-of-scope items. The following are **not** excluded and must be implemented for MVP:

| Item | Status |
|------|--------|
| Breed encyclopedia / collectible album | **In scope** (killer differentiator) |
| Shooting location map (Google Maps) | **In scope** (MCP integration) |
| Google OAuth login | **In scope** |
| Multilingual UI (ko + en) | **In scope** |
| Camera capture + gallery upload | **In scope** |
| Gemini AI breed identification | **In scope** |

> No items are explicitly out of scope. Future phases may add: native app packaging, social sharing, push notifications, paid tiers — but these are not committed.

---

## 3. Target Users

### Primary Personas

| Persona | Description | Key Need |
|---------|-------------|----------|
| Cat Lover | People who simply like cats and encounter strays regularly | Instantly know what breed the cat is; collect breeds |
| Curious Downloader | People who download the app out of curiosity after seeing it shared | Low-friction first experience; immediate "wow" result |

### Persona Depth
- Users are mobile-first; they encounter a stray cat on the street and open the browser immediately
- They expect results within seconds — any wait longer than ~5 seconds risks abandonment
- They may travel across multiple regions and encounter different cats; the breed encyclopedia serves as a travel souvenir / collection
- No technical sophistication assumed; UI must be extremely simple (one primary action per screen)
- Both Korean and English speakers are targeted (multilingual requirement)

---

## 4. Core Features

### Feature Table

| ID | Title | Priority | Description |
|----|-------|----------|-------------|
| F1 | Cat Breed Identification | MUST | Full flow: photo input → AI analysis → breed result display |
| F1.1 | Camera / Gallery Input | MUST | User opens camera or selects from gallery in mobile browser |
| F1.2 | AI Breed Analysis | MUST | Gemini analyzes uploaded photo and returns breed classification |
| F1.3 | Result Display with Description | MUST | Show breed name + characteristics + personality traits |
| F1.4 | No-Cat / Low-Quality Error Handling | MUST | Clear message when no cat detected or image unrecognizable |
| F1.5 | Analysis Loading State | MUST | Show loading indicator during analysis; result within a few seconds |
| F2 | Breed Encyclopedia (도감) | MUST | Collectible album of all breeds the user has identified |
| F3 | Shooting Location Map | MUST | Record and display where each cat photo was taken (Google Maps) |
| F4 | Google OAuth Login | MUST | Sign in with Google; required to save history and encyclopedia |
| F5 | Gallery Grid View | MUST | Grid of all cat photos the user has uploaded, with breed labels |

### Feature Detail: F1 — Cat Breed Identification

**Reaction:** Display results and breed information card after analysis completes.

| Requirement ID | Requirement (EN gloss) | Original (KR) | Rationale |
|---------------|------------------------|---------------|-----------|
| F1.1 | User can open camera directly or select from gallery in mobile browser | 사용자가 모바일 웹 브라우저에서 카메라를 직접 실행하거나 갤러리에서 고양이 사진을 선택할 수 있어야 한다 | Core input must work without app installation |
| F1.2 | Uploaded photo is analyzed for cat presence and breed classification | 업로드된 사진에서 고양이를 인식하고, 해당 고양이의 종(breed)을 분석하여 결과를 반환할 수 있어야 한다 | Core purpose of the app |
| F1.3 | Result shows breed name + brief description (traits, personality) | 분석 결과는 고양이 종 이름과 함께 간단한 설명(특징, 성격 등)을 포함하여 사용자에게 표시되어야 한다 | Users must get meaningful information, not just a label |
| F1.4 | If no cat detected or unrecognizable, show clear guidance message | 사진에 고양이가 없거나 인식이 불가능한 경우, 사용자에게 명확한 안내 메시지를 제공해야 한다 | Street photos are often low quality; graceful degradation required |
| F1.5 | Result appears within a few seconds; loading state shown during analysis | 분석 결과는 사진 업로드 후 수 초 이내에 표시되어야 하며, 분석 중임을 나타내는 상태가 사용자에게 보여야 한다 | Impulse users on the street will abandon if no feedback |

### Feature Detail: F2 — Breed Encyclopedia (도감)

- Each successfully identified breed is added to the user's personal encyclopedia
- Encyclopedia displays as a grid of breed cards (breed image, name, date first identified)
- Breeds the user has NOT yet identified are shown as locked/silhouette cards (discovery incentive)
- Total breed count shown (e.g., "12 / 70 breeds discovered")

### Feature Detail: F3 — Shooting Location Map

- When a photo is uploaded, the browser requests geolocation permission
- If granted, latitude/longitude is recorded and stored with the `CatPhoto` record
- A map view (Google Maps embed) shows pins for each cat photo location
- Clicking a pin shows the cat photo thumbnail and identified breed

### Feature Detail: F5 — Gallery Grid View

- Route: `/screen` (as specified in profile)
- Displays all cat photos uploaded by the authenticated user
- Each cell: thumbnail image + breed label + date
- Tapping a cell navigates to the result detail view for that photo

---

## 5. Screens & Routes

| Route | Page Name | Auth Required | Purpose |
|-------|-----------|---------------|---------|
| `/` | Home / Upload | Yes (redirect to `/login` if not authed) | Primary action: camera/gallery upload button; triggers breed analysis |
| `/login` | Login | No | Google OAuth sign-in screen |
| `/result/[id]` | Breed Result | Yes | Shows analysis result: breed name, description, photo, map pin |
| `/screen` | Gallery Grid View | Yes | Grid of all user's cat photos with breed labels |
| `/encyclopedia` | Breed Encyclopedia (도감) | Yes | Collectible grid of all breeds; locked vs. unlocked states |
| `/encyclopedia/[breed_id]` | Breed Detail | Yes | Full breed info: name, traits, personality, example images |
| `/map` | Location Map | Yes | Google Maps view with pins for all shooting locations |
| `/api/auth/callback/google` | OAuth Callback | No (system) | Google OAuth redirect handler |

### Screen Wireframe Notes

**`/` — Home / Upload**
```
┌─────────────────────────────┐
│  [Logo]  고양이 종 알아보기   │
│                             │
│  ┌─────────────────────┐    │
│  │  📷  사진 찍기       │    │  ← opens camera (capture="environment")
│  └─────────────────────┘    │
│  ┌─────────────────────┐    │
│  │  🖼️  갤러리에서 선택  │    │  ← opens file picker
│  └─────────────────────┘    │
│                             │
│  [최근 분석 결과 미리보기]    │
└─────────────────────────────┘
```

**`/result/[id]` — Breed Result**
```
┌─────────────────────────────┐
│  [Cat Photo]                │
│                             │
│  🐱 코리안 숏헤어            │  ← breed name (localized)
│  Korean Shorthair           │
│                             │
│  특징: ...                  │  ← traits
│  성격: ...                  │  ← personality
│                             │
│  📍 [Mini Map]              │  ← Google Maps embed
│                             │
│  [도감에 추가됨 ✓]           │
│  [다시 찍기]                 │
└─────────────────────────────┘
```

**`/screen` — Gallery Grid View**
```
┌─────────────────────────────┐
│  내 고양이 갤러리             │
│  ┌────┐ ┌────┐ ┌────┐      │
│  │🐱  │ │🐱  │ │🐱  │      │
│  │코숏 │ │페르 │ │믹스 │      │
│  └────┘ └────┘ └────┘      │
│  ┌────┐ ┌────┐ ┌────┐      │
│  │🐱  │ │🐱  │ │+   │      │
│  └────┘ └────┘ └────┘      │
└─────────────────────────────┘
```

---

## 6. Data Model

### Entity: `cat_photos`

| Column | Type | Required | Description |
|--------|------|----------|-------------|
| `id` | `uuid` PK | ✓ | Primary key |
| `user_id` | `uuid` FK → `users.id` | ✓ | Owner (authenticated user) |
| `label` | `varchar(255)` | ✓ | Display label for UI lists (e.g., "고양이 #3") |
| `status` | `varchar(50)` | ✓ | Lifecycle state: `pending` \| `analyzing` \| `done` \| `failed` \| `no_cat_detected` |
| `image_url` | `text` | ✓ | Object storage URL of the uploaded photo (EXIF stripped) |
| `description` | `text` | | Human-readable summary / user note |
| `shooting_location_id` | `uuid` FK → `shooting_locations.id` | | Associated location record |
| `breed_determination_id` | `uuid` FK → `breed_determinations.id` | | Associated analysis result |
| `created_at` | `timestamptz` | ✓ | Upload timestamp |
| `updated_at` | `timestamptz` | ✓ | Last update timestamp |

### Entity: `breed_determinations`

| Column | Type | Required | Description |
|--------|------|----------|-------------|
| `id` | `uuid` PK | ✓ | Primary key |
| `cat_photo_id` | `uuid` FK → `cat_photos.id` | ✓ | Source photo |
| `label` | `varchar(255)` | ✓ | Display label (breed name, e.g., "Korean Shorthair") |
| `status` | `varchar(50)` | ✓ | `pending` \| `success` \| `no_cat` \| `error` |
| `breed_encyclopedia_id` | `uuid` FK → `breed_encyclopedias.id` | | Matched breed entry (null if no_cat or error) |
| `confidence_score` | `float4` | | AI confidence 0.0–1.0 |
| `raw_ai_response` | `jsonb` | | Full Gemini response payload for debugging |
| `description` | `text` | | Human-readable summary of the determination |
| `created_at` | `timestamptz` | ✓ | Analysis timestamp |
| `updated_at` | `timestamptz` | ✓ | Last update timestamp |

### Entity: `breed_encyclopedias`

| Column | Type | Required | Description |
|--------|------|----------|-------------|
| `id` | `uuid` PK | ✓ | Primary key |
| `label` | `varchar(255)` | ✓ | Breed display name (English, e.g., "Korean Shorthair") |
| `label_ko` | `varchar(255)` | ✓ | Breed display name (Korean, e.g., "코리안 숏헤어") |
| `status` | `varchar(50)` | ✓ | `active` \| `deprecated` |
| `description` | `text` | | General breed description (English) |
| `description_ko` | `text` | | General breed description (Korean) |
| `traits` | `jsonb` | | Structured traits: `{size, coat, temperament, lifespan, ...}` |
| `example_image_url` | `text` | | Reference image URL for encyclopedia display |
| `created_at` | `timestamptz` | ✓ | Seed timestamp |
| `updated_at` | `timestamptz` | ✓ | Last update timestamp |

### Entity: `shooting_locations`

| Column | Type | Required | Description |
|--------|------|----------|-------------|
| `id` | `uuid` PK | ✓ | Primary key |
| `user_id` | `uuid` FK → `users.id` | ✓ | Owner |
| `label` | `varchar(255)` | ✓ | Display label (e.g., "Hongdae, Seoul") |
| `status` | `varchar(50)` | ✓ | `active` \| `deleted` |
| `latitude` | `float8` | ✓ | GPS latitude |
| `longitude` | `float8` | ✓ | GPS longitude |
| `description` | `text` | | Human-readable location note |
| `created_at` | `timestamptz` | ✓ | Record creation timestamp |
| `updated_at` | `timestamptz` | ✓ | Last update timestamp |

### Entity: `users` (managed by NextAuth / Google OAuth)

| Column | Type | Required | Description |
|--------|------|----------|-------------|
| `id` | `uuid` PK | ✓ | Primary key |
| `email` | `varchar(255)` | ✓ | Google account email |
| `name` | `varchar(255)` | | Display name from Google |
| `avatar_url` | `text` | | Profile picture URL from Google |
| `created_at` | `timestamptz` | ✓ | First sign-in timestamp |
| `updated_at` | `timestamptz` | ✓ | Last sign-in timestamp |

### Entity Relationships (ERD summary)

```
users ──< cat_photos ──> shooting_locations
              │
              └──> breed_determinations ──> breed_encyclopedias
```

### User Encyclopedia Junction: `user_encyclopedia_unlocks`

| Column | Type | Required | Description |
|--------|------|----------|-------------|
| `id` | `uuid` PK | ✓ | Primary key |
| `user_id` | `uuid` FK → `users.id` | ✓ | User who unlocked |
| `breed_encyclopedia_id` | `uuid` FK → `breed_encyclopedias.id` | ✓ | Unlocked breed |
| `first_identified_at` | `timestamptz` | ✓ | When first identified |
| `cat_photo_id` | `uuid` FK → `cat_photos.id` | ✓ | The photo that triggered the unlock |

---

## 7. API Design (Backend Contract)

All API routes are Next.js API Routes under `/api/`. Authenticated routes require a valid NextAuth session cookie. Responses are JSON. Errors follow `{ error: string, code: string }`.

### Auth Endpoints

| Method | Path | Auth Scope | Request Body | Response 200 | Error Codes |
|--------|------|-----------|--------------|--------------|-------------|
| `GET` | `/api/auth/session` | guest | — | `{ user: { id, email, name, avatar_url } \| null }` | — |
| `GET` | `/api/auth/signin/google` | guest | — | Redirect to Google OAuth | — |
| `GET` | `/api/auth/callback/google` | guest | — | Redirect to `/` with session set | `400`, `401` |
| `POST` | `/api/auth/signout` | authenticated | — | `{ success: true }` | `401` |

### Cat Photo Endpoints

| Method | Path | Auth Scope | Request Body | Response 200 | Error Codes |
|--------|------|-----------|--------------|--------------|-------------|
| `POST` | `/api/cat-photos` | authenticated | `multipart/form-data`: `{ image: File, latitude?: float, longitude?: float, label?: string }` | `{ id, status, label, image_url, created_at }` | `400`, `401`, `413` |
| `GET` | `/api/cat-photos` | authenticated | — | `[{ id, label, status, image_url, breed_determination_id, created_at }]` | `401` |
| `GET` | `/api/cat-photos/[id]` | authenticated | — | `{ id, label, status, image_url, description, shooting_location, breed_determination, created_at }` | `401`, `404` |
| `DELETE` | `/api/cat-photos/[id]` | authenticated | — | `{ success: true }` | `401`, `404` |

**`POST /api/cat-photos` flow:**
1. Validate file is an image (MIME type check); reject non-images with `400`
2. Strip EXIF metadata server-side
3. Upload to object storage; get `image_url`
4. If `latitude` + `longitude` provided, create `shooting_locations` record
5. Create `cat_photos` record with `status: "pending"`
6. Enqueue async Gemini analysis job (or call synchronously if within timeout budget)
7. Return `{ id, status: "pending", ... }` immediately; client polls `/api/cat-photos/[id]` for status update

### Breed Determination Endpoints

| Method | Path | Auth Scope | Request Body | Response 200 | Error Codes |
|--------|------|-----------|--------------|--------------|-------------|
| `POST` | `/api/breed-determinations` | authenticated | `{ cat_photo_id: string }` | `{ id, status, label, confidence_score, breed_encyclopedia_id, created_at }` | `400`, `401`, `404` |
| `GET` | `/api/breed-determinations/[id]` | authenticated | — | `{ id, status, label, confidence_score, description, breed_encyclopedia_id, raw_ai_response?, created_at }` | `401`, `404` |

**`POST /api/breed-determinations` flow:**
1. Fetch `cat_photo` by `cat_photo_id`; verify ownership
2. Call Gemini MCP with image URL
3. Parse response: extract breed name, confidence, traits
4. Match breed name to `breed_encyclopedias` table (fuzzy match or exact)
5. Create `breed_determinations` record
6. Update `cat_photos.status` → `"done"` or `"no_cat_detected"`
7. If breed matched and `status: "success"`, upsert `user_encyclopedia_unlocks`
8. Return determination record

### Breed Encyclopedia Endpoints

| Method | Path | Auth Scope | Request Body | Response 200 | Error Codes |
|--------|------|-----------|--------------|--------------|-------------|
| `GET` | `/api/breed-encyclopedias` | authenticated | Query: `?locale=ko\|en` | `[{ id, label, label_ko, status, description, example_image_url, unlocked: bool }]` | `401` |
| `GET` | `/api/breed-encyclopedias/[id]` | authenticated | Query: `?locale=ko\|en` | `{ id, label, label_ko, description, description_ko, traits, example_image_url, unlocked: bool, first_identified_at? }` | `401`, `404` |

### Shooting Location Endpoints

| Method | Path | Auth Scope | Request Body | Response 200 | Error Codes |
|--------|------|-----------|--------------|--------------|-------------|
| `GET` | `/api/shooting-locations` | authenticated | — | `[{ id, label, latitude, longitude, cat_photo_id, created_at }]` | `401` |
| `GET` | `/api/shooting-locations/[id]` | authenticated | — | `{ id, label, latitude, longitude, description, cat_photo, created_at }` | `401`, `404` |

### Polling / Status Endpoint

| Method | Path | Auth Scope | Request Body | Response 200 | Error Codes |
|--------|------|-----------|--------------|--------------|-------------|
| `GET` | `/api/cat-photos/[id]/status` | authenticated | — | `{ id, status, breed_determination_id? }` | `401`, `404` |

> Client polls this endpoint every 1 second after upload until `status` is `done`, `failed`, or `no_cat_detected`. Maximum poll duration: 30 seconds.

---

## 8. Auth & Permissions

### Authentication

| Property | Value |
|----------|-------|
| Required | Yes |
| Method | Google OAuth via NextAuth.js |
| Session | NextAuth JWT session cookie |
| Callback path | `/api/auth/callback/google` |
| Redirect after login | `/` (home/upload) |
| Redirect unauthenticated | `/login` |

### Environment Variables Required

```env
NEXTAUTH_URL=https://your-domain.vercel.app
NEXTAUTH_SECRET=<random 32-byte secret>
GOOGLE_CLIENT_ID=<from Google Cloud Console>
GOOGLE_CLIENT_SECRET=<from Google Cloud Console>
```

### Role Model

No roles defined in MVP. All authenticated users have identical permissions scoped to their own data. Row-level ownership enforced: every query filters by `user_id = session.user.id`.

### Permission Matrix

| Resource | Guest | Authenticated (owner) |
|----------|-------|-----------------------|
| View login page | ✓ | ✓ |
| Upload cat photo | ✗ | ✓ |
| View own photos | ✗ | ✓ |
| View own breed results | ✗ | ✓ |
| View breed encyclopedia list | ✗ | ✓ |
| View own location map | ✗ | ✓ |
| Delete own photo | ✗ | ✓ |
| Access another user's data | ✗ | ✗ |

---

## 9. External Integrations

### Google OAuth (Authentication)

| Property | Value |
|----------|-------|
| Provider | Google |
| Library | NextAuth.js (`next-auth`) |
| Scopes | `openid`, `email`, `profile` |
| Callback path | `/api/auth/callback/google` |
| Env vars | `GOOGLE_CLIENT_ID`, `GOOGLE_CLIENT_SECRET` |

### Gemini AI (Cat Breed Identification) — MCP

| Property | Value |
|----------|-------|
| Purpose | Analyze cat photo → return breed name, confidence, traits |
| Integration method | MCP (Model Context Protocol) server |
| Model | `gemini-1.5-flash` (or latest vision-capable model) |
| MCP server | `[TBD: MCP server name/endpoint to be specified by team]` |
| Env vars | `GEMINI_API_KEY` |
| Input | Image URL or base64-encoded image |
| Output schema | `{ breed_name: string, confidence: float, traits: { size, coat, temperament, lifespan }, no_cat_detected: bool, description: string }` |
| Fallback | If Gemini returns `no_cat_detected: true` or confidence < 0.4, set `status: "no_cat_detected"` and show error message |
| Timeout | 10 seconds; if exceeded, set `status: "failed"` |

**Gemini Prompt Template (server-side, not exposed to client):**
```
You are a cat breed expert. Analyze the provided image.
If a cat is present, identify its breed and return a JSON object with:
- breed_name (string, English breed name)
- confidence (float 0.0-1.0)
- traits: { size, coat_type, temperament, average_lifespan_years }
- description (2-3 sentences about the breed in the requested locale)
- no_cat_detected (boolean)

If no cat is visible or the image quality is too low to identify, set no_cat_detected: true.
Locale: {locale}
```

### Google Maps (Shooting Location) — MCP

| Property | Value |
|----------|-------|
| Purpose | Display map pins for cat photo shooting locations |
| Integration method | MCP (Model Context Protocol) server |
| MCP server | `[TBD: MCP server name/endpoint to be specified by team]` |
| Env vars | `NEXT_PUBLIC_GOOGLE_MAPS_API_KEY` |
| Usage | Embed Google Maps JS API in `/map` route; render markers from `shooting_locations` data |
| Browser geolocation | `navigator.geolocation.getCurrentPosition()` called on photo upload; user prompted for permission |

### Object Storage (Photo Upload)

| Property | Value |
|----------|-------|
| Purpose | Store uploaded cat photos |
| Provider | `[TBD: Vercel Blob / AWS S3 / Cloudflare R2 — team decision]` |
| EXIF stripping | Required server-side before storage (use `sharp` or `exifr`) |
| Max file size | 10 MB |
| Accepted MIME types | `image/jpeg`, `image/png`, `image/webp`, `image/heic` |
| Env vars | `[TBD: depends on storage provider]` |

---

## 10. Monetization & Analytics

### Monetization

**Model: Undecided**

No monetization implementation is required for MVP. No ads, no payment gateway, no subscription logic. The monetization model will be decided post-MVP based on user feedback.

- `needs_ads: false` — Do not integrate any ad SDK
- `needs_payment: false` — Do not integrate any payment gateway
- Code must be structured so a monetization layer can be added later without major refactoring (e.g., keep user model extensible with a `plan` field defaulting to `"free"`)

### Analytics

`analytics_tracking: false` — No analytics SDK (Google Analytics, Mixpanel, etc.) is required for MVP.

Do not add any tracking scripts. Do not add any third-party analytics calls.

---

## 11. Acceptance Criteria (Given / When / Then)

### AC-1: Breed Identification Accuracy (from profile)

| | |
|-|-|
| **Given** | User has entered the app and is authenticated |
| **When** | User uploads a clear cat photo via `POST /api/cat-photos` and `POST /api/breed-determinations` |
| **Then** | Breed determination accuracy is **80% or higher** across a test set of 50+ labeled cat photos |

### AC-2: Camera and Gallery Input Works on Mobile Browser

| | |
|-|-|
| **Given** | User is on a mobile browser (iOS Safari or Android Chrome) and is authenticated |
| **When** | User taps "사진 찍기 ("Take Photo")" on `GET /` (home screen) |
| **Then** | The device camera opens via `<input type="file" accept="image/*" capture="environment">` within 2 seconds; OR the gallery picker opens when "갤러리에서 선택 ("Select from Gallery")" is tapped |

### AC-3: Analysis Result Displayed Within Time Limit

| | |
|-|-|
| **Given** | User has uploaded a cat photo and `POST /api/cat-photos` returns `status: "pending"` |
| **When** | Client polls `GET /api/cat-photos/[id]/status` every 1 second |
| **Then** | `status` transitions to `"done"` and `breed_determination_id` is populated within **10 seconds** of upload; a loading spinner is visible throughout; the result page `/result/[id]` renders the breed name and description |

### AC-4: No-Cat Detection Shows Clear Error Message

| | |
|-|-|
| **Given** | User uploads an image that contains no cat (e.g., a landscape photo) |
| **When** | `POST /api/breed-determinations` is called with the `cat_photo_id` |
| **Then** | Response returns `{ status: "no_cat" }` with HTTP 200; the UI displays the message `"고양이를 찾을 수 없어요. 다시 시도해 주세요." ("No cat found. Please try again.")` within 3 seconds of the determination completing; no error stack trace is shown to the user |

### AC-5: Breed Encyclopedia Unlocks After Identification

| | |
|-|-|
| **Given** | User successfully identifies a breed (e.g., "Korean Shorthair") for the first time |
| **When** | `GET /api/breed-encyclopedias` is called after the determination |
| **Then** | The response includes the identified breed with `unlocked: true` and `first_identified_at`