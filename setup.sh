#!/bin/bash
# create-agent-context.sh
# Sets up the self-evolving AGENTS.md structure in your project

set -e

echo "Creating AGENTS.md structure..."

# Create directories
mkdir -p .agent/context .agent/task .agent/SOPs

# Backup existing AGENTS.md if present
if [ -f AGENTS.md ]; then
   backup_base="AGENTS.old"
   backup_path="${backup_base}.md"
   counter=1

   while [ -f "$backup_path" ]; do
      backup_path="${backup_base}.${counter}.md"
      counter=$((counter + 1))
   done

   mv AGENTS.md "$backup_path"
   echo "Renamed existing AGENTS.md to $(basename "$backup_path")"
fi

write_if_missing() {
   target="$1"
   shift
   if [ -f "$target" ]; then
      echo "Skipping $target (already exists)"
   else
      printf "%s\n" "$1" > "$target"
      echo "Created $target"
   fi
}

# AGENTS.md
cat > AGENTS.md << 'EOF'
# AGENTS.md

> **Self-Evolving Context**: This file and `.agent/` grow with your project. After completing any task, update the relevant files.

---

## Context Update Protocol

**After completing work, agents must:**

1. **Update relevant context files** in `.agent/context/`:
    - Changed project scope? → Update `overview.md`
    - Modified architecture or structure? → Update `architecture.md`
    - Made style/convention decisions? → Update `conventions.md`
    - Added new commands or scripts? → Update `commands.md`

2. **Create new context files** if documenting something that doesn't fit existing files:
    - Place in `.agent/` with a descriptive name (e.g., `api-reference.md`, `database-schema.md`)
    - Add an `@./filename.md` import below

3. **Always log to changelog** at `.agent/context/changelog.md`

---

## Project Context

@./agent/context/overview.md
@./agent/context/architecture.md
@./agent/context/conventions.md
@./agent/context/commands.md

---

## Recent Activity

@./agent/context/changelog.md

---

## Project-Specific Context

<!-- Agents: Add new @imports here as you create project-specific context files -->
EOF
echo "Created AGENTS.md"

# MIGRATION.md
write_if_missing "MIGRATION.md" "# Migration Guide for AI Agents

Use this file as the prompt you give to your AI agent (Claude, Gemini, Copilot, etc.) to migrate any existing project notes into the AGENTS.md structure. The steps are agent-friendly and non-destructive.

## How to use
- Paste this file into your agent chat and say: \"Follow MIGRATION.md to merge my existing notes into this AGENTS.md layout.\" If the agent asks for confirmation, answer accordingly.
- If you want a dry run first, tell the agent to do a read-only scan and summarize the plan before writing.

## Agent instructions (run in order)
1. **Detect existing notes**: Look for agent or doc folders/files such as agents.md, claude.md, gemini.md, docs/, notes/, ai/, .aider*, .cursor*, .claude*, or other markdown files that look like project context.
2. **Plan mapping** (do not write yet): Map each discovered file into one of these targets:
      - Project overview → .agent/context/overview.md
      - Architecture/structure → .agent/context/architecture.md
      - Conventions/style → .agent/context/conventions.md
      - Commands/scripts → .agent/context/commands.md
      - In-progress or planning docs → .agent/task/
      - Everything else → leave in place and link under Project-Specific Context in AGENTS.md.
3. **Safety first**:
      - Do not delete or overwrite existing files.
      - If a target file already has content, append under a new heading; never discard existing text.
      - If you must move or rename, copy instead and leave the original intact.
4. **Execute merge**:
      - Create missing .agent/context/ files if they are absent.
      - Append mapped content into the target files, preserving headings that clarify the source (e.g., \"## Imported from claude.md\").
      - For unmapped docs, add @./<relative-path> entries under Project-Specific Context in AGENTS.md (do not wrap paths in code fences).
5. **Log the work**: Add a dated entry to .agent/context/changelog.md summarizing what was imported, what was linked, and any files left untouched.
6. **Report back**: Summarize actions taken, files touched, and any items that need manual review.

## Extra guidance for agents
- Prefer adding links instead of moving files when unsure of fit.
- Keep formatting intact; avoid aggressive rewrites unless asked.
- If you see other frameworks’ metadata (e.g., LangGraph, PromptFoo), link those files rather than merging their schema blindly.
- If conflicts arise, default to appending with clear headings instead of overwriting.

## What success looks like
- No data loss; original files still exist.
- .agent/context/ files contain the important migrated context with source headings.
- AGENTS.md lists any remaining legacy files under Project-Specific Context.
- .agent/context/changelog.md has a fresh entry describing the migration.
"

# overview.md
write_if_missing ".agent/context/overview.md" "# Project Overview

## Description
<!-- What is this project? One paragraph. -->

## Goals
<!-- What are the primary objectives? -->

## Key Terminology
<!-- Define project-specific terms that agents should know -->

## Target Users
<!-- Who is this for? -->
"

# architecture.md
write_if_missing ".agent/context/architecture.md" "# Architecture

## Directory Structure
<!-- Document the folder layout and what each directory contains. -->

## Key Files
<!-- List important entry points and files agents should know about. -->

## Patterns & Conventions
<!-- Document architectural patterns in use. -->

## Dependencies
<!-- Key libraries and frameworks. -->
"

# conventions.md
write_if_missing ".agent/context/conventions.md" "# Conventions

## Language & Framework
<!-- Primary language and framework choices. -->

## Naming Conventions
<!-- How to name things. -->

## Code Style
<!-- Formatting preferences. -->

## Best Practices
<!-- Project-specific rules. -->
"

# commands.md
write_if_missing ".agent/context/commands.md" "# Commands

## Setup
<!-- How to set up the project for the first time. -->

## Development
<!-- How to run in development mode. -->

## Build
<!-- How to build for production. -->

## Test
<!-- How to run tests. -->

## Other Commands
<!-- Additional useful commands. -->
"

# changelog.md
write_if_missing ".agent/context/changelog.md" "# Changelog

<!-- 
Living history of project changes.
Agents: Add an entry after completing any task.

Format:
## YYYY-MM-DD
- **Brief summary** - Details about what changed
-->
"

# codebase-scan.md
write_if_missing ".agent/context/codebase-scan.md" "# Codebase Scan Playbook

Use this when you need to pull fresh context from the repository (code + docs) and feed it into the AGENTS.md structure.

## What to gather
- High-level purpose and domain from README and top-level docs.
- Runtime entry points, major modules, and data flows.
- Build/dev/test commands found in package manifests or scripts.
- Coding conventions observed in the code (lint configs, style files).
- Any generated or vendored areas to avoid summarizing (e.g., dist/, build/, node_modules/).

## How to scan
1. Enumerate source roots (e.g., src/, app/, services/, backend/, frontend/) and list main languages/frameworks.
2. Read key entry files (index/main/app/server) to map startup flow and dependencies.
3. For each major module, skim public interfaces and note responsibilities and cross-module calls.
4. Inspect configs (package.json, pyproject.toml, tsconfig, docker files, CI) for commands and environment requirements.
5. Skip noisy directories: node_modules, dist, build, .next, .turbo, .venv, coverage, .git.

## Where to write
- Add architecture/system notes to .agent/context/architecture.md.
- Add project purpose and domain summary to .agent/context/overview.md.
- Add commands you find to .agent/context/commands.md.
- Add observed conventions (lint rules, formatting, typing strictness) to .agent/context/conventions.md.
- Log what you scanned in .agent/context/changelog.md with paths touched and summaries added.

## Safety
- Do not delete or overwrite existing context; append under a new heading (e.g., "Code scan YYYY-MM-DD").
- Keep code snippets short; prefer summaries over large excerpts.
- If uncertain about a module, add a note for follow-up instead of guessing.
"

# task/README
write_if_missing ".agent/task/README.md" "# Plans and PRDs

Use this folder to save plans/PRDs before implementation.

Template (copy into a new file named <task>.md):

## Context
- Brief description of the task and scope.

## Objectives
- Bulleted goals and non-goals.

## Plan
- Sequenced steps or milestones.

## Decisions / Risks
- Key choices, assumptions, and risks.

## Links
- Relevant context files, issues, or specs.
"

# SOPs/README
write_if_missing ".agent/SOPs/README.md" "# SOPs

Use this folder to store ultra-short post-fix recipes.

Template (copy into a new file named <topic>.md):

## Problem
- What was broken and symptoms.

## Fix
- Steps taken to resolve.

## Pitfalls / Commands
- Traps to avoid next time.
- Commands or scripts used.

## Related Docs
- Links to context files or code touched.
"

echo "AGENTS.md structure created!"
echo ""
echo "Files ensured:"
echo "  - AGENTS.md (backed up if pre-existing)"
echo "  - MIGRATION.md"
echo "    (Use MIGRATION.md to merge existing docs into the AGENTS structure.)"
echo "  - .agent/context/overview.md"
echo "  - .agent/context/architecture.md"
echo "  - .agent/context/conventions.md"
echo "  - .agent/context/commands.md"
echo "  - .agent/context/changelog.md"
echo "  - .agent/context/codebase-scan.md"
echo "    (Use codebase-scan.md to summarize the codebase into the context files.)"
echo "  - .agent/task/"
echo "    (Use .agent/task for plans/PRDs; see its README for a template.)"
echo "  - .agent/SOPs/"
echo "    (Use .agent/SOPs for short fix recipes; see its README for a template.)"
