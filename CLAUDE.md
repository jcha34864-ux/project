# CLAUDE.md — 혼밥하는 사람들을 위한 듀오밥

This file is read automatically by Claude Code at every session. Treat it as the
short, always-loaded guardrail. Detailed specs live in `docs/PRD.md`.

## Project at a glance

- **One-liner**: 혼밥하는 사람들을 만의 커뮤니티를 만들어서 정보를 공유하고 소개팅도 진행하는 플랫폼
- **Device target**: Web (browser)

## Source of truth

`docs/PRD.md` is the **single source of truth**. Any edit that diverges from the
PRD MUST be reflected back to `docs/PRD.md` in the same commit.

## Killer differentiator

사용자 매칭 시스템

## Stack

- **Frontend**: `next`
- **Backend**: `fastapi`
- **Database**: `postgresql`
- **Deployment**: TBD

## External integrations

- **MCP / external services**: enabled — 카카오 알림톡, 네이버 지도.

## Do NOT

- 요구사항에 없는 기능·화면·API를 임의로 추가하지 않는다.
- 확인되지 않은 수치·날짜·전망을 사실처럼 쓰지 않는다.
- 프로덕션 배포·실서비스 도메인 연결은 명시적 요청 없이 구현하지 않는다.
- API 키·시크릿·PG 키는 코드에 하드코딩하지 않고 환경변수(.env)로만 참조한다.

## Workflow rules

- Read `docs/PRD.md` before writing code in a new area.
- When adding a feature: locate the matching section in PRD §4 (Features) and
  PRD §11 (Acceptance Criteria) and cite it in the commit message.
- When changing folder structure: update PRD §10 in the same commit.
- All generated source code and documentation MUST be in English. User-facing
  copy may stay in the language declared by PRD.
