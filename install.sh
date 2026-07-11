#!/bin/sh
# Install the feature-dev-governed workflow into your global Archon workflows dir.
# Symlinks it (absolute path) so edits in this repo propagate automatically.
# Does NOT touch your config — merge .archon/config.example.yaml yourself (see below).
set -eu

# Resolve this script's directory (absolute).
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)

WORKFLOW_SRC="$SCRIPT_DIR/.archon/workflows/feature-dev-governed.yaml"
ARCHON_HOME="${ARCHON_HOME:-$HOME/.archon}"
WORKFLOW_DEST_DIR="$ARCHON_HOME/workflows"
WORKFLOW_DEST="$WORKFLOW_DEST_DIR/feature-dev-governed.yaml"

if [ ! -f "$WORKFLOW_SRC" ]; then
  echo "error: workflow not found at $WORKFLOW_SRC" >&2
  exit 1
fi

mkdir -p "$WORKFLOW_DEST_DIR"
ln -sfn "$WORKFLOW_SRC" "$WORKFLOW_DEST"

echo "Linked: $WORKFLOW_DEST -> $WORKFLOW_SRC"
echo ""
echo "Next steps:"
echo "  1. Merge model config into your global config (not done automatically):"
echo "       \$EDITOR $SCRIPT_DIR/.archon/config.example.yaml $ARCHON_HOME/config.yaml"
echo "     (or, if you have no config yet:  cp $SCRIPT_DIR/.archon/config.example.yaml $ARCHON_HOME/config.yaml )"
echo "  2. Connect Claude + Codex credentials:  archon ai key set <vendor> / archon ai login <vendor>  (verify: archon ai list)"
echo "  3. Connect your GitHub identity:        archon auth github"
echo "  4. Run it in any git repo:              archon workflow run feature-dev-governed \"Investigate and implement <feature>\""
