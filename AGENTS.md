# Global Agent Rules — Token-Efficient Operation

## Context discipline (PRIMARY COST CONTROL)
- NEVER read a whole file to answer a localized question. Use the LSP tool:
  goToDefinition / findReferences / incomingCalls / outgoingCalls first.
- Only Read specific line ranges (use offset/limit). Default to ~120-line windows.
- Prefer `grep`/`glob` to locate, then Read only the matching region.
- Delegate broad codebase questions to the `explore` subagent (Flash tier).
- For "what does X affect", use LSP `findReferences` + `incomingCalls`, NOT reading files.
- Cap parallel Task fan-out at 3 concurrent subagents unless user asks for more.

## Answer discipline
- No preamble, no recap, no "Based on...". Answer directly.
- Code references as `file:line`. Don't paste whole files back.
- One-word/short answers when sufficient.

## Tool-use discipline
- Batch independent reads/edits in one assistant turn (batch tool).
- Never `cat` a large file; use `grep -n` then Read with offset.
- Avoid `find`; use `glob`. Avoid `grep` (CLI); use the Grep tool.

## Self-correction via tooling, not re-tries
- If a linter/formatter modifies your output, accept it — do not re-edit to "fix".
- After edits, run the project's lint+typecheck once (see AGENTS.md in repo).
- Do NOT re-run tests repeatedly hoping they pass; read the failure first.

## Subagent spawning
- Spawn `explore` (Flash) for any read-heavy investigation.
- Spawn `general` (Pro) only for multi-step write tasks the planner scoped.
- Keep subagent prompts tight: give exact file paths / search terms.

## Custom commands
- `/opencode-init` — interactive project setup (creates AGENTS.md + opencode.jsonc + .ignore). Run this in any new project root.
- `/refactor-effect` — AST blast-radius analysis before changing a symbol.