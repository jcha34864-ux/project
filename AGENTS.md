# AGENTS.md — DuoBob for Solo Diners

## Project snapshot
- Product: DuoBob for Solo Diners
- Purpose: Information sharing and dating platform for solo diners.

## Working environment
- CLI: Assumed command line interface.
- Package Manager: npm or yarn (for Next.js).
- OS: Cross-platform compatibility (Windows, macOS, Linux).

## Build & test commands

| Purpose                     | Command                                   | When                  |
|----------------------------|-------------------------------------------|-----------------------|
| Start development server    | `npm run dev`                             | During development     |
| Run tests                   | `pytest`                                  | Before commits         |
| Build for production        | `npm run build`                           | Before deployment      |
| Start backend server        | `uvicorn backend.main:app --reload`      | During development     |

## Repository map
- `/frontend`: Frontend application using Next.js.
- `/backend`: Backend application using FastAPI.
- `/database`: Database schema and migration files.
- `/docs`: Documentation files including PRD and API specs.

## Coding rules
- Follow consistent naming conventions.
- Write unit tests for all new features.
- Use ESLint and Prettier for code quality.
- Document code with comments where necessary.

## Commit discipline
- Use clear and descriptive commit messages.
- Follow the format: `type(scope): subject` (e.g., `feat(auth): add signup API`).
- Reference related issues in commit messages.

## Things to ask before doing
- Is this feature or change documented in the PRD?
- Are there any specific design guidelines to follow?
- What are the acceptance criteria for this task?