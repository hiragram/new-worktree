#!/bin/bash -eu

REPO="hiragram/new-worktree"
BRANCH="main"
PREFIX="${NEW_WORKTREE_INSTALL_DIR:-$HOME/.local/bin}"

mkdir -p "$PREFIX"

echo "Downloading new-worktree..."
curl -fsSL "https://raw.githubusercontent.com/$REPO/$BRANCH/new-worktree" -o "$PREFIX/new-worktree"
chmod +x "$PREFIX/new-worktree"

echo "Installed new-worktree to $PREFIX/new-worktree"

if [[ ":$PATH:" != *":$PREFIX:"* ]]; then
    echo ""
    echo "Warning: $PREFIX is not in your PATH."
    echo "Add the following to your shell profile:"
    echo ""
    echo "  export PATH=\"$PREFIX:\$PATH\""
fi
