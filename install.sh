#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/YOUR_USER/opencode-config.git"  # ★ CHANGE THIS
INSTALL_DIR="${HOME}/.config/opencode"

echo "==> Installing opencode global config..."

# 1. Backup existing config
if [ -d "$INSTALL_DIR" ] && [ ! -d "$INSTALL_DIR/.git" ]; then
  echo "==> Backing up existing config to ${INSTALL_DIR}.bak"
  mv "$INSTALL_DIR" "${INSTALL_DIR}.bak"
fi

# 2. Clone config repo
if [ -d "$INSTALL_DIR/.git" ]; then
  echo "==> Config already installed, pulling latest..."
  cd "$INSTALL_DIR" && git pull
else
  git clone "$REPO_URL" "$INSTALL_DIR"
fi

# 3. Install dependencies
echo "==> Installing dependencies..."
npm install -g typescript-language-server pyright prettier 2>/dev/null || true
pip install --break-system-packages ruff 2>/dev/null || pip install --user ruff 2>/dev/null || true

# 4. Symlink find-skills if ~/.agents/skills/find-skills exists
if [ -d "${HOME}/.agents/skills/find-skills" ] && [ ! -L "${INSTALL_DIR}/skills/find-skills" ]; then
  ln -sf "${HOME}/.agents/skills/find-skills" "${INSTALL_DIR}/skills/find-skills"
fi

echo ""
echo "==> Done! Config installed at ~/.config/opencode/"
echo "==> Run 'opencode' to verify."
echo ""
echo "What's included:"
echo "  - 4-tier model config (plan/build/explore/build-fast)"
echo "  - Token-frugal AGENTS.md (context discipline, compaction, pruning)"
echo "  - LSP servers for TypeScript + Python"
echo "  - Formatters: Prettier + Ruff"
echo "  - Custom commands: /opencode-init, /refactor-effect"
echo ""
echo "After first run, connect OpenRouter:"
echo "  1. opencode"
echo "  2. /connect -> select OpenRouter -> paste API key"
echo "  3. opencode models -> copy IDs -> edit opencode.jsonc ★WIRE placeholders"