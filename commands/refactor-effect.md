---
description: AST-based effect analysis for a refactor target
agent: plan
---

Analyze the blast radius of refactoring: $ARGUMENTS

Steps:
1. LSP goToDefinition on the target.
2. LSP findReferences across the workspace.
3. LSP incomingCalls on each caller.
4. Produce a list of every file:line that will need to change.
5. Propose the minimal change set.