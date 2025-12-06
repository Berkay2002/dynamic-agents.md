#!/bin/bash
# create-agent-context.sh
# Sets up the self-evolving AGENTS.md structure in your project

set -e

echo "Creating AGENTS.md structure..."

# Create directories
mkdir -p .agent/context

# Create AGENTS.md
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

# Create overview.md
cat > .agent/context/overview.md << 'EOF'
# Project Overview

## Description
<!-- What is this project? One paragraph. -->

## Goals
<!-- What are the primary objectives? -->

## Key Terminology
<!-- Define project-specific terms that agents should know -->

## Target Users
<!-- Who is this for? -->
EOF

# Create architecture.md
cat > .agent/context/architecture.md << 'EOF'
# Architecture

## Directory Structure
<!-- Document the folder layout and what each directory contains. -->

## Key Files
<!-- List important entry points and files agents should know about. -->

## Patterns & Conventions
<!-- Document architectural patterns in use. -->

## Dependencies
<!-- Key libraries and frameworks. -->
EOF

# Create conventions.md
cat > .agent/context/conventions.md << 'EOF'
# Conventions

## Language & Framework
<!-- Primary language and framework choices. -->

## Naming Conventions
<!-- How to name things. -->

## Code Style
<!-- Formatting preferences. -->

## Best Practices
<!-- Project-specific rules. -->
EOF

# Create commands.md
cat > .agent/context/commands.md << 'EOF'
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
EOF

# Create changelog.md
cat > .agent/context/changelog.md << 'EOF'
# Changelog

<!-- 
Living history of project changes.
Agents: Add an entry after completing any task.

Format:
## YYYY-MM-DD
- **Brief summary** - Details about what changed
-->
EOF

echo "AGENTS.md structure created!"
echo ""
echo "Files created:"
echo "  - AGENTS.md"
echo "  - .agent/context/overview.md"
echo "  - .agent/context/architecture.md"
echo "  - .agent/context/conventions.md"
echo "  - .agent/context/commands.md"
echo "  - .agent/context/changelog.md"
