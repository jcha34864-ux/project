# AGENTS.md — App That Identifies Cat Breeds from Photos

## Project snapshot

- **Product**: Mobile web app — upload a cat photo → automatic breed identification → display results
- **Core flow**: User camera/gallery → image upload → Gemini Vision API analysis → breed name + description display
- **Target**: Cat lovers, curious users (no installation required, mobile web)
- **Key constraint**: Breed identification accuracy ≥ 80% (manual testing)
- **Auth**: Google OAuth required

---

## Working environment

| Item | Value |
|------|-------|
| **OS** | macOS / Linux / Windows (WSL2) |
| **Node.js** | 18+ |
| **Package manager** | npm / pnpm / yarn |
| **Database** | PostgreSQL 14+ (local dev: Docker or managed) |
| **API keys** | Google OAuth, Gemini Vision API, Google Maps API (env vars only) |
| **Deployment target** | Vercel |

---

## Build & test commands

| Purpose | Command | When |
|---------|---------|------|
| Install dependencies | `npm install` or `pnpm install` | First setup, after `package.json` change |
| Dev server (frontend + API routes) | `npm run dev` (default: `http://localhost:3000`) | Active development |
| Build for production | `npm run build` | Before deploy to Vercel |
| Run tests | `npm test` or `jest` | After feature completion, before commit |
| Database migrations | `npx prisma migrate dev` | After schema change |
| Lint & format | `npm run lint` && `npm run format` | Before commit |
| Type check | `npm run type-check` or `tsc --noEmit` | Before commit |

---

## Repository map

| Directory | Purpose |
|-----------|---------|
| `/pages` | Next.js page routes (UI screens) |
| `/pages/api` | Next.js API routes (backend endpoints) |
| `/components` | Reusable React components |
| `/lib` | Utility functions, API clients, helpers |
| `/public` | Static assets (images, icons) |
| `/prisma` | Database schema & migrations |
| `/styles` | Global CSS / Tailwind config |
| `/.env.local` | Local environment variables (git-ignored) |
| `/README.md` | Project overview |

---

## Coding rules

- **PRD compliance**: Only implement features listed in PRD §3 (Features). Do not add screens, APIs, or entities beyond PRD scope.
- **Quote before change**: When modifying existing code, cite the relevant PRD section.
- **Secrets**: Never hardcode API keys. Use `.env.local` (dev) and Vercel env vars (prod).
- **Image upload**: Use Next.js API route + multipart form-data. Store in Vercel Blob or similar (TBD).
- **Gemini API**: Call via server-side API route only (never expose API key to client).
- **Error handling**: Return clear user messages for:
  - No cat detected in image
  - API rate limit / timeout
  - Invalid image format
- **Response time**: Aim for <5 seconds end-to-end (image upload → breed result display).
- **Mobile-first**: Responsive design for iOS/Android browsers (viewport meta tag, touch-friendly buttons).
- **Accessibility**: ARIA labels, semantic HTML, keyboard navigation.

---

## Commit discipline

- **Atomic commits**: One feature / fix per commit.
- **Message format**: `[FEATURE|FIX|DOCS|CHORE] Brief description (PRD §X.Y if applicable)`
  - Example: `[FEATURE] Add cat photo upload with camera/gallery picker (PRD §3.F1.1)`
- **Before push**: Run `npm run lint`, `npm run type-check`, `npm test`.
- **No secrets in commits**: Use `.env.local`, never commit API keys.

---

## Things to ask before doing

1. **Image storage**: Where should uploaded cat photos be stored? (Vercel Blob, AWS S3, local temp, or discard after analysis?)
2. **Breed database**: Should we pre-populate a breed encyclopedia ("품종 도감") table, or fetch breed info on-demand from Gemini?
3. **Location tracking**: The PRD mentions a "shooting location" ("촬영 위치") entity — should we capture GPS coordinates, or is this future scope?
4. **Gallery grid page**: The PRD lists `/screen` (gallery grid view) — is this a history of analyzed photos, or a breed reference gallery?
5. **Google Maps integration**: The PRD mentions Google Maps for location — is this for displaying where cats were spotted, or is it out of scope for MVP?
6. **Monetization**: The PRD says "undecided" — are there any ads, paywalls, or analytics to implement now?
7. **Database init**: Should we seed breed data (cat breed encyclopedia / "고양이 품종 도감") on first deploy, or load it dynamically?