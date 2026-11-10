#!/usr/bin/env bash
# Copies a plugin's skills and agents into a project, for places that can't
# install plugins (Claude Code cloud sessions, agents without plugin support).
#
# Usage: scripts/install-into-project.sh <project-dir> [claude|copilot|both] [plugin]
#   claude  -> <project>/.claude/skills  + <project>/.claude/agents
#   copilot -> <project>/.github/skills  + <project>/.github/agents
# Re-run to update. Only this plugin's folders are replaced.
set -euo pipefail

project="${1:?Usage: $0 <project-dir> [claude|copilot|both] [plugin]}"
target="${2:-claude}"
plugin="${3:-frontend-architect}"

root="$(cd "$(dirname "$0")/.." && pwd)"
src="$root/plugins/$plugin"
[ -d "$src/skills" ] || { echo "Plugin not found: $src" >&2; exit 1; }
[ -d "$project" ] || { echo "Project dir not found: $project" >&2; exit 1; }

copy_to() {
  local base="$1"
  mkdir -p "$base/skills" "$base/agents"
  for skill in "$src"/skills/*/; do
    name="$(basename "$skill")"
    rm -rf "$base/skills/$name"
    cp -R "$skill" "$base/skills/$name"
    echo "  skill  $base/skills/$name"
  done
  if [ -d "$src/agents" ]; then
    for agent in "$src"/agents/*.md; do
      cp "$agent" "$base/agents/"
      echo "  agent  $base/agents/$(basename "$agent")"
    done
  fi
}

case "$target" in
  claude)  copy_to "$project/.claude" ;;
  copilot) copy_to "$project/.github" ;;
  both)    copy_to "$project/.claude"; copy_to "$project/.github" ;;
  *) echo "Unknown target: $target (use claude, copilot or both)" >&2; exit 1 ;;
esac

echo "Done. Commit the copied folders so cloud sessions and teammates get them."
