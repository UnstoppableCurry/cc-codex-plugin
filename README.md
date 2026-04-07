# cc-codex-plugin

Use Claude Code with a Codex-backed gateway, without manually editing config files.

This project is optimized for the actual Claude Code user path:

- first: one-command Claude Code install
- second: example configuration
- third: self-hosted bridge deployment
- always: explicit limitations around agents, worktrees, and local environment requirements

## What This Repository Really Is

Claude Code does not currently expose a public “install third-party plugin from repo” flow like an app store.

So this repository ships the next best thing:

- a bridge runtime for Codex-compatible backends
- a one-command Claude Code installer
- ready-to-copy config examples

The goal is plugin-like user experience, even though the underlying integration point is Claude Code configuration, not a public plugin marketplace.

It is designed for:

- Claude Code users who want to route through a Codex-backed subscription
- operators who want a documented compatibility surface
- developers who want an inspectable starting point instead of a closed relay box

## What It Is Not

- not a full hosted service
- not a secret production config dump
- not a guarantee that Claude Code local subagents will work without local Git/worktree support

## Fastest Path: Install Into Claude Code

```bash
curl -fsSL https://raw.githubusercontent.com/UnstoppableCurry/cc-codex-plugin/main/scripts/install-claude-code.sh | bash
```

The installer will:

- ask for your bridge base URL
- ask for your gateway key
- optionally set a default model
- update `~/.claude/settings.json`
- keep your existing Claude Code settings and only merge the required env keys

After that, restart Claude Code and start using it normally.

## Manual Install

If you do not want the installer, copy the example from:

- `examples/claude-code/settings.json`

and merge it into:

- `~/.claude/settings.json`

## Repository Layout

- `scripts/install-claude-code.sh` one-command Claude Code installer
- `scripts/uninstall-claude-code.sh` removes the injected Claude Code env keys
- `Dockerfile` runnable image for the bridge
- `config.example.toml` example server/plugin config
- `examples/claude-code/` client-side Claude Code example
- `examples/codex/` client-side Codex example
- `docs/` human-readable setup, model mapping, and limitations

## Self-Hosted Bridge

If you want to run the bridge yourself:

```bash
cp config.example.toml config.toml
docker build -t cc-codex-plugin .
docker run --rm -p 8000:8000 \
  -v "$(pwd)/config.toml:/app/config.toml:ro" \
  cc-codex-plugin \
  ccproxy serve --config /app/config.toml --host 0.0.0.0 --port 8000
```

Then point Claude Code to that bridge with the installer or the manual settings example.

## Key Limitation

This project can make request/response compatibility smoother. It cannot replace Claude Code's local `git worktree` requirement for true multi-agent isolation. If a client wants subagents or swarm-style parallelism, the local machine still needs a valid Git/worktree environment.

See:

- `docs/quickstart.md`
- `docs/model-mapping.md`
- `docs/limitations.md`
