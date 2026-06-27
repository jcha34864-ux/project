# CLAUDE.md — 혼밥하는 사람들을 위한 듀오밥

## Project at a glance

- **One-liner**: A platform for people who eat alone to share information and arrange meetups.
- **Device target**: Web (browser)

## Source of truth

`docs/PRD.md` is the **single source of truth**. Any edit that diverges from the PRD MUST be reflected back to `docs/PRD.md` in the same commit.

## Killer differentiator

User matching system

## Recommended workflow with Claude Code

- Use **Plan mode** for ambiguous tasks to clarify objectives.
- Employ **sub-agents** for parallel exploration of features.
- Maintain **todo discipline**: work on one task at a time, and only commit when explicitly asked.

## Folder structure

<!-- TBD: Define folder structure -->

## Stack

- **Frontend**: `next`
- **Backend**: `fastapi`
- **Database**: `postgresql`
- **Deployment**: TBD

## External integrations

- **MCP / external services**: enabled — Kakao Talk notifications, Naver Maps.

## Coding conventions

- All generated source code and documentation MUST be in English.
- User-facing strings can remain in Korean as specified in the PRD.

## Test discipline

<!-- TBD: Define testing strategy and discipline -->

## Do NOT (hard rules)

- Do not arbitrarily add features, screens, or APIs not specified in the requirements.
- Do not present unverified numbers, dates, or forecasts as facts.
- Do not implement production deployments or connect to live service domains without explicit requests.
- Do not hardcode API keys, secrets, or payment gateway keys; reference them only through environment variables (.env).