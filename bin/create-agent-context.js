#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

console.log('Creating AGENTS.md structure...\n');

const templates = {
    'AGENTS.md': `# AGENTS.md

> **Self-Evolving Context**: This file and \`.agent/\` grow with your project. After completing any task, update the relevant files.

---

## Context Update Protocol

**After completing work, agents must:**

1. **Update relevant context files** in \`.agent/context/\`:
   - Changed project scope? → Update \`overview.md\`
   - Modified architecture or structure? → Update \`architecture.md\`
   - Made style/convention decisions? → Update \`conventions.md\`
   - Added new commands or scripts? → Update \`commands.md\`

2. **Create new context files** if documenting something that doesn't fit existing files:
   - Place in \`.agent/\` with a descriptive name (e.g., \`api-reference.md\`, \`database-schema.md\`)
   - Add an \`@./filename.md\` import below

3. **Always log to changelog** at \`.agent/context/changelog.md\`

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
`,

    '.agent/context/overview.md': `# Project Overview

## Description
<!-- What is this project? One paragraph. -->

## Goals
<!-- What are the primary objectives? -->

## Key Terminology
<!-- Define project-specific terms that agents should know -->

## Target Users
<!-- Who is this for? -->
`,

    '.agent/context/architecture.md': `# Architecture

## Directory Structure
<!-- Document the folder layout and what each directory contains. -->

## Key Files
<!-- List important entry points and files agents should know about. -->

## Patterns & Conventions
<!-- Document architectural patterns in use. -->

## Dependencies
<!-- Key libraries and frameworks. -->
`,

    '.agent/context/conventions.md': `# Conventions

## Language & Framework
<!-- Primary language and framework choices. -->

## Naming Conventions
<!-- How to name things. -->

## Code Style
<!-- Formatting preferences. -->

## Best Practices
<!-- Project-specific rules. -->
`,

    '.agent/context/commands.md': `# Commands

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
`,

    '.agent/context/changelog.md': `# Changelog

<!-- 
Living history of project changes.
Agents: Add an entry after completing any task.

Format:
## YYYY-MM-DD
- **Brief summary** - Details about what changed
-->
`
};

// Create directories
const dirs = ['.agent', '.agent/context'];
dirs.forEach(dir => {
    if (!fs.existsSync(dir)) {
        fs.mkdirSync(dir, { recursive: true });
    }
});

// Create files
Object.entries(templates).forEach(([filePath, content]) => {
    const fullPath = path.join(process.cwd(), filePath);

    if (fs.existsSync(fullPath)) {
        console.log(`⏭️  Skipping ${filePath} (already exists)`);
    } else {
        fs.writeFileSync(fullPath, content, 'utf8');
        console.log(`✅ Created ${filePath}`);
    }
});

console.log('\nAGENTS.md structure created!');
console.log('\nYour AI coding agents will now see the self-update directive');
console.log('and keep your context files current as they work.\n');
