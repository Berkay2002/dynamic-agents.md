# AGENTS.md

> **Self-Evolving Context**: This file and `.agent/` grow with your project. After completing any task, update the relevant files.

---

## Index / When to Read What

- Overview (`.agent/context/overview.md`): current goals/scope; read first on any task.
- Architecture (`.agent/context/architecture.md`): structure/flows; consult before design or integration changes.
- Conventions (`.agent/context/conventions.md`): style/decisions; check before adding code/docs.
- Commands (`.agent/context/commands.md`): setup/dev/build/test scripts.
- Plans (`.agent/task/`): saved plans/PRDs; read when resuming or mirroring prior work.
- SOPs (`.agent/SOPs/`): post-fix recipes; check before repeating similar fixes.

---

## Context Update Protocol

**After completing work, agents must:**

1. **Update relevant context files** in `.agent/context/`:
   - Changed project scope? → Update `overview.md`
   - Modified architecture or structure? → Update `architecture.md`
   - Made style/convention decisions? → Update `conventions.md`
   - Added new commands or scripts? → Update `commands.md`

2. **Create new context files** if documenting something that doesn't fit existing files:
   - Place in `.agent/` with a descriptive name (e.g., `api-reference.md`, `database-schema.md`). Use existing subfolders when they fit (e.g., `.agent/context/` for core context, `.agent/task/` for plans, `.agent/SOPs/` for SOPs); otherwise put the file at the `.agent/` root.
   - Add an `@./filename.md` import below

3. **Always log to changelog** at `.agent/context/changelog.md`

---

## Lightweight Workflow Guardrails

- **Plan mode**: before implementation, save the plan/PRD to `.agent/task/<name>.md` and import it below.
- **SOPs**: after a fix, add `.agent/SOPs/<topic>.md` using an ultra-short template: Problem → Fix → Pitfalls/Commands. Import it below.
- **Compact/reset (manual)**: after each micro-task, prune conversation to decisions and links to relevant context files.
- **Context audit (quick)**: disable unused tools/MCPs, prefer doc links over long transcripts, keep only minimal history needed for the next step.

---

## Project Context

@./agent/context/overview.md
@./agent/context/architecture.md
@./agent/context/conventions.md
@./agent/context/commands.md

---

## Recent Activity
---

## Project-Specific Context

<!-- Agents: Add new @imports here as you create project-specific context files -->
