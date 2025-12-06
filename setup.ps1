# create-agent-context.ps1
# Sets up the self-evolving AGENTS.md structure in your project

Write-Host "Creating AGENTS.md structure..." -ForegroundColor Cyan

# Create directories
New-Item -ItemType Directory -Force -Path ".agent/context" | Out-Null

# Create AGENTS.md
@'
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
'@ | Set-Content -Path "AGENTS.md" -Encoding UTF8

# Create overview.md
@'
# Project Overview

## Description
<!-- What is this project? One paragraph. -->

## Goals
<!-- What are the primary objectives? -->

## Key Terminology
<!-- Define project-specific terms that agents should know -->

## Target Users
<!-- Who is this for? -->
'@ | Set-Content -Path ".agent/context/overview.md" -Encoding UTF8

# Create architecture.md
@'
# Architecture

## Directory Structure
<!-- Document the folder layout and what each directory contains. -->

## Key Files
<!-- List important entry points and files agents should know about. -->

## Patterns & Conventions
<!-- Document architectural patterns in use. -->

## Dependencies
<!-- Key libraries and frameworks. -->
'@ | Set-Content -Path ".agent/context/architecture.md" -Encoding UTF8

# Create conventions.md
@'
# Conventions

## Language & Framework
<!-- Primary language and framework choices. -->

## Naming Conventions
<!-- How to name things. -->

## Code Style
<!-- Formatting preferences. -->

## Best Practices
<!-- Project-specific rules. -->
'@ | Set-Content -Path ".agent/context/conventions.md" -Encoding UTF8

# Create commands.md
@'
# Commands

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
'@ | Set-Content -Path ".agent/context/commands.md" -Encoding UTF8

# Create changelog.md
@'
# Changelog

<!-- 
Living history of project changes.
Agents: Add an entry after completing any task.

Format:
## YYYY-MM-DD
- **Brief summary** - Details about what changed
-->
'@ | Set-Content -Path ".agent/context/changelog.md" -Encoding UTF8

Write-Host "✅ AGENTS.md structure created!" -ForegroundColor Green
Write-Host ""
Write-Host "Files created:"
Write-Host "  - AGENTS.md"
Write-Host "  - .agent/context/overview.md"
Write-Host "  - .agent/context/architecture.md"
Write-Host "  - .agent/context/conventions.md"
Write-Host "  - .agent/context/commands.md"
Write-Host "  - .agent/context/changelog.md"
