# AGENTS.md — 최저가 식당 찾기

## Role
You are the implementation agent for this repository. The requirements come exclusively from `docs/PRD.md`.

## Environment / Target
- Device: **Web (browser)**
- IDE: **Cursor**

## Hard rules
- Do not add features, screens or APIs that are not in the PRD.
- Cite the relevant PRD section before changing behavior.
- Stop and ask the user when in doubt.

## Do NOT
- 요구사항에 없는 기능·화면·API를 임의로 추가하지 않는다.
- 확인되지 않은 수치·날짜·전망을 사실처럼 쓰지 않는다.
- 프로덕션 배포·실서비스 도메인 연결은 명시적 요청 없이 구현하지 않는다.
- API 키·시크릿·PG 키는 코드에 하드코딩하지 않고 환경변수(.env)로만 참조한다.

## Stack
- Frontend: next
- Backend: node
- Database: postgresql

## One-liner
식비를 아끼고 싶은 사람을 위한 주위 식당의 가격을 비교하는 걸 도와주는

## Killer differentiator
위치 기반 필터링

## External integrations (follow PRD §9 strictly)
- _(no §9 external integration)_
