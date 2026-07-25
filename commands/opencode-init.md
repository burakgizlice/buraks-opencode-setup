---
description: Initialize opencode project config (AGENTS.md, opencode.jsonc, .ignore) for a new monorepo project
agent: build
---

# Opencode Project Initializer

Set up opencode for this project. Ask the user questions one at a time, then create the files.

## Step 1 — Gather info from user
Ask these questions, one by one, waiting for each answer:
1. Project name
2. Build command (or "none")
3. Lint command (or "none")
4. Typecheck command (or "none")
5. Test command (or "none")
6. Source directories (comma separated, e.g. `packages/core, apps/web`)
7. Entry points (e.g. `src/index.ts`)
8. Directories to ignore in watcher (default: `**/dist/**, **/.next/**, **/node_modules/**, **/coverage/**`)
9. Package manager

## Step 2 — Create `./AGENTS.md`
Structure:
- Title: `# {Project Name}`
- `## Token-efficient workflow for THIS repo` section: list the build/lint/typecheck/test commands that aren't "none"
- `## Repo map` section: list each source directory, entry points
- `## Effect analysis` section: LSP findReferences note, cross-package aliases if applicable

## Step 3 — Create `./opencode.jsonc`
```jsonc
{
  "$schema": "https://opencode.ai/config.json",
  "watcher": { "ignore": ["**/dist/**","**/.next/**","**/node_modules/**","**/coverage/**"] },
  "instructions": ["AGENTS.md"]
}
```
Adjust ignores based on user answers.

## Step 4 — Create `./.ignore`
One `!{dir}/**` line per source directory so ripgrep only searches meaningful paths.

## Step 5 — Confirm
List the created files and tell the user to validate with:
```
python3 ~/.config/opencode/scripts/validate-jsonc.py opencode.jsonc
```
Ask if they want project-specific subagents under `.opencode/agents/` (optional).