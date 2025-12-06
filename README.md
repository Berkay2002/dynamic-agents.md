# create-agent-context

> A self-evolving AGENTS.md structure for AI coding agents.

Your context files automatically stay current as agents work on your project.

## Quick Start

### Option 1: npx (Node.js)
```bash
npx create-agent-context
```

### Option 2: curl (Mac/Linux)
```bash
curl -sL https://raw.githubusercontent.com/YOUR_USERNAME/agent-template/main/setup.sh | bash
```

### Option 3: PowerShell (Windows)
```powershell
irm https://raw.githubusercontent.com/YOUR_USERNAME/agent-template/main/setup.ps1 | iex
```

### Option 4: GitHub Template
Click **"Use this template"** on GitHub to create a new repo with this structure.

---

## What Gets Created

```
your-project/
├── AGENTS.md                      # Entry point + self-update directive
└── .agent/context/
    ├── overview.md                # What this project is
    ├── architecture.md            # How it's structured
    ├── conventions.md             # Code style rules
    ├── commands.md                # Build/test/run
    └── changelog.md               # Living history
```

---

## How It Works

1. **Agent reads AGENTS.md** → Sees the self-update directive
2. **Agent completes work** → Updates relevant context files
3. **Agent logs to changelog.md** → History grows automatically
4. **Context evolves** → Always current with project state

**Compatible with:** Cursor, VS Code, GitHub Copilot, Gemini CLI, Android Studio, Aider, and any tool supporting [agents.md](https://agents.md).

---

## Migrating Existing Notes

- We scaffold a ready-to-use [MIGRATION.md](MIGRATION.md). Paste it to your agent (Claude, Gemini, Copilot, etc.) and ask it to follow the steps.
- The guide tells the agent to detect legacy docs (agents.md, claude.md, docs/, notes/, ai/, etc.), map them into `.agent/context/`, append instead of overwrite, and log the changes in `.agent/context/changelog.md`.
- If you want a dry run, ask the agent to summarize its plan before writing.
- If an `AGENTS.md` already exists, the CLI renames it to `AGENTS.old.md` (or `AGENTS.old.<n>.md` if needed) and writes a fresh `AGENTS.md` template so you can merge via MIGRATION.md.

---

## License

MIT
