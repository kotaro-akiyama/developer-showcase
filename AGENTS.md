# Repository Guidelines

## Project Structure & Module Organization
`app/` hosts the web experience (Next.js + TypeScript). Group domain features by route, maintain shared UI in `app/components`, and place reusable hooks under `app/lib`. Infrastructure code lives under `infra/`: `terraform/` for cloud resources, `ansible/` for configuration management, and `scripts/` for developer automation. Keep `README.md` as the high-level narrative and update it whenever directories gain new capabilities.

## Build, Test, and Development Commands
Use Node 20+ with npm. Core commands:
- `npm install` — sync dependencies before working on the app.
- `npm run dev` — start the Next.js dev server with hot reload.
- `npm run build` — generate the production bundle for deployment previews.
- `npm run lint` — apply ESLint/Prettier; required before commits.
- `npm run test` — execute Jest/Playwright suites locally.
Infrastructure:
- `terraform fmt && terraform validate` inside `infra/terraform/`.
- `./infra/scripts/bootstrap.sh` — add automation here; keep scripts executable and idempotent.

## Coding Style & Naming Conventions
Write TypeScript, use 2-space indentation, and prefer functional React components. Keep folders and files in kebab-case; components, hooks, and context objects use PascalCase/camelCase. Co-locate styles and tests with their modules. Run ESLint with the Next.js preset and format via Prettier—hook both into your editor or pre-commit workflow.

## Testing Guidelines
Favor unit tests with Jest (store alongside code as `*.test.ts[x]`) and end-to-end flows with Playwright under `tests/e2e`. Mirror route names in test filenames for traceability. Every behavioral change must add or update tests; defer only with a tracked `// @todo-test` and follow-up issue. Target >90% coverage on critical UI flows and run accessibility projects (`npm run test:e2e -- --project=a11y`) before merging.

## Commit & Pull Request Guidelines
Adopt conventional commits (`feat:`, `fix:`, `docs:`, `infra:`) with concise English summaries; add Japanese context in the body when it aids reviewers. Reference issues via `Closes #123`. Before opening a PR, confirm lint/build/test succeed, attach screenshots for UI changes, and document infra impacts (plans, migrations). Keep PRs focused (<500 LOC) and include a short changelog entry when work ships to production.

## Infrastructure Notes
Treat `infra/terraform` as the source of truth. Run `terraform plan` for every infra PR and paste the diff into the discussion. Store secrets outside the repo via environment managers or CI secrets. Document new resources and operational runbooks in `infra/README.md`.
