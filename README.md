# new-worktree

A single-command tool to spin up an isolated development session: creates a git worktree with a random branch name and launches a [zellij](https://zellij.dev/) session with [Claude Code](https://docs.anthropic.com/en/docs/claude-code) and companion panes.

## What it does

1. Generates a random branch name from `/usr/share/dict/words` (e.g. `mango-kept-trails`)
2. Fetches the latest `origin/main`
3. Creates a git worktree under `worktrees/<name>` with a new branch
4. Launches a zellij session with the following layout:

```
┌──────────┬─────────────────┬──────────┐
│          │                 │          │
│  Plans   │   Claude Code   │ Changed  │
│          │                 │  Files   │
│          │                 │          │
├──────────┴────────┬────────┴──────────┤
│                   │                   │
│     Terminal      │    PR Status      │
│                   │                   │
└───────────────────┴───────────────────┘
```

- **Plans** — Watches `plans/` directory and renders the latest markdown file (uses [glow](https://github.com/charmbracelet/glow) if available)
- **Claude Code** — Main coding pane running `claude` (or `claude-docker`)
- **Changed Files** — Interactive diff viewer against `origin/main` using [fzf](https://github.com/junegunn/fzf) and [delta](https://github.com/dandavison/delta)
- **Terminal** — Plain shell
- **PR Status** — Polls PR state, review status, and CI checks via [gh](https://cli.github.com/)

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/hiragram/new-worktree/main/install.sh | bash
```

This installs to `~/.local/bin` by default. To change the install directory:

```bash
curl -fsSL https://raw.githubusercontent.com/hiragram/new-worktree/main/install.sh | NEW_WORKTREE_INSTALL_DIR=/usr/local/bin bash
```

Make sure the install directory is in your `PATH`.

## Usage

Run from any git repository:

```bash
new-worktree
```

### Options

| Flag | Description |
|---|---|
| `--claude-local` | Use `claude` (local, this is the default) |
| `--claude-docker` | Use `claude-docker` (run Claude Code inside a Docker container) |

`--claude-local` and `--claude-docker` are mutually exclusive.

### Environment variables

| Variable | Values | Description |
|---|---|---|
| `NEW_WORKTREE_CLAUDE` | `docker` | Default to `claude-docker` instead of `claude` |

CLI flags take precedence over the environment variable. Useful for setting a default in your shell profile:

```bash
export NEW_WORKTREE_CLAUDE=docker
```

## Dependencies

**Required:**
- [zellij](https://zellij.dev/)
- [git](https://git-scm.com/)

**Recommended (for full pane functionality):**
- [fzf](https://github.com/junegunn/fzf) — Changed Files pane
- [delta](https://github.com/dandavison/delta) — Side-by-side diff rendering
- [gh](https://cli.github.com/) — PR Status pane
- [fswatch](https://github.com/emcrisostomo/fswatch) or [entr](https://eradman.com/entrproject/) — Plans pane file watching
- [glow](https://github.com/charmbracelet/glow) — Markdown rendering in Plans pane

## License

MIT
