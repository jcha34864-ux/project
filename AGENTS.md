# AGENTS.md — Dining Together for People Eating Alone

## Project snapshot

- **Product**: A system that matches people who dislike eating alone based on food preferences
- **Target users**: People eating alone, those looking for dining companions
- **Core feature**: User selects food preferences → Preference-based matching → Profile card UI
- **Monetization**: Free + Ads (AdMob)
- **Success metric**: 7-day return rate of 30% or more

---

## Working environment

- **Frontend**: React Native (iOS/Android)
- **Backend**: Firebase Functions (Node.js)
- **Database**: Firestore
- **Deployment**: Firebase App Distribution + Firebase Functions
- **Auth**: Google OAuth
- **Package manager**: npm (or yarn/pnpm if declared in package.json)
- **OS**: macOS/Linux/Windows (cross-platform development)

---

## Build & test commands

| Purpose | Command | When |
|---------|---------|------|
| Install dependencies | `npm install` | Initial setup, after `package.json` change |
| Start dev server (React Native) | `npm start` or `expo start` | Local development |
| Run tests | `npm test` | Before commit, CI/CD |
| Build for iOS | `npm run build:ios` | Pre-release testing |
| Build for Android | `npm run build:android` | Pre-release testing |
| Deploy Firebase Functions | `firebase deploy --only functions` | After backend changes |
| Deploy Firestore rules | `firebase deploy --only firestore:rules` | After security rule changes |
| Lint & format | `npm run lint` | Before commit |

<!-- TBD: Exact test framework (Jest, Mocha, etc.) and Firebase emulator setup commands -->

---

## Repository map

| Directory | Purpose |
|-----------|---------|
| `/src` | React Native app source (screens, components, navigation) |
| `/src/screens` | Screen components (e.g., `/screen-1f6665` — user profile card matching) |
| `/src/components` | Reusable UI components |
| `/src/services` | Firebase, auth, API client logic |
| `/functions` | Firebase Cloud Functions (backend) |
| `/firestore` | Firestore security rules & indexes |
| `/assets` | Images, fonts, icons |
| `/docs` | PRD, design specs, API docs |

---

## Coding rules

- **PRD-first**: Do not add features, screens, or APIs not listed in PRD.
- **Quote before change**: Cite PRD section when implementing or modifying requirements.
- **No hardcoded secrets**: All API keys, OAuth credentials, AdMob IDs → `.env` or Firebase config.
- **Entity alignment**: Implement only entities defined in PRD (`사용자`, `사용자의 음식 취향`).
- **API contract**: Follow exact request/response shapes in PRD §6 (auth, screens endpoints).
- **Auth scope**: Respect `guest` vs `authenticated` scopes; reject unauthorized requests.
- **Ad integration**: AdMob ads must be placed per design spec (not yet detailed — ask before implementing).
- **Error handling**: Return exact error codes from PRD (e.g., 400, 401, 409).
- **Naming**: Use Korean entity names in code comments; English keys for route/file names.

---

## Commit discipline

- **Atomic commits**: One feature/fix per commit.
- **Message format**: `[scope] brief description` (e.g., `[auth] implement Google OAuth signup`)
- **Reference PRD**: Include feature ID if applicable (e.g., `feat-1f6665`).
- **Test before push**: Run `npm test` and `npm run lint` locally.
- **No secrets**: Never commit `.env`, API keys, or credentials.

---

## Things to ask before doing

1. **AdMob placement**: Where should ads appear? (splash, between matches, settings?)
2. **Matching algorithm**: How to weight food preference similarity? (exact match, cosine similarity, other?)
3. **User profile card**: What fields display? (name, age, location, food preferences, bio?)
4. **Matching flow**: After match, how do users communicate? (in-app chat, phone, external link?)
5. **Food list source**: Is the food preference list hardcoded, fetched from Firestore, or external API?
6. **Firebase project**: Is Firebase project ID & config already set up? (needed for `.env`)
7. **Google OAuth**: Is Google OAuth app registered? (Client ID, redirect URI needed)
8. **Test data**: Should seed Firestore with sample users & preferences for testing?
9. **Offline support**: Should React Native app work offline (cache matches, sync later)?
10. **Analytics**: PRD says `analytics_tracking: false` — confirm no event tracking needed?