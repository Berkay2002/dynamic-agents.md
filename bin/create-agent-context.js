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

     'MIGRATION.md': `# Migration Guide for AI Agents

Use this file as the prompt you give to your AI agent (Claude, Gemini, Copilot, etc.) to migrate any existing project notes into the AGENTS.md structure. The steps are agent-friendly and non-destructive.

## How to use
- Paste this file into your agent chat and say: "Follow MIGRATION.md to merge my existing notes into this AGENTS.md layout." If the agent asks for confirmation, answer accordingly.
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
    - Append mapped content into the target files, preserving headings that clarify the source (e.g., "## Imported from claude.md").
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

    if (filePath === 'AGENTS.md' && fs.existsSync(fullPath)) {
        const backupBase = path.join(process.cwd(), 'AGENTS.old');
        let backupPath = `${backupBase}.md`;
        let counter = 1;

        while (fs.existsSync(backupPath)) {
            backupPath = `${backupBase}.${counter}.md`;
            counter += 1;
        }

        fs.renameSync(fullPath, backupPath);
        console.log(`🔁 Renamed existing AGENTS.md to ${path.basename(backupPath)}`);
        fs.writeFileSync(fullPath, content, 'utf8');
        console.log('✅ Created AGENTS.md');
        return;
    }

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
