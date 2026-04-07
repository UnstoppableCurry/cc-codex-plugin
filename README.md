# cc-codex-plugin

Use your Codex subscription from Claude Code.

[简体中文说明](./README.zh-CN.md)

This repository is built for the real end-user path:

- first: one-command Claude Code install
- second: clear examples
- third: optional self-hosted bridge deployment

![Claude Code setup screenshot](./assets/screenshot-claude-code.png)

## In one sentence

You keep using Claude Code as usual.  
This project makes those requests go through a Codex-backed bridge.

## What This Repository Really Is

Claude Code does not currently expose a public “install third-party plugin from repo” flow like an app store.

So this repository ships the next best thing:

- a bridge runtime for Codex-compatible backends
- a one-command Claude Code installer
- ready-to-copy config examples

The goal is plugin-like user experience, even though the underlying integration point is Claude Code configuration, not a public plugin marketplace.

## Why this repository exists

- you want Claude Code
- you want to pay through a Codex-side subscription or runtime path
- you do not want to hand-edit config every time

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

## What users usually ask next

### Does this also fix multi-agent / swarm?

No. It helps with request compatibility and setup experience.

If Claude Code wants true local subagents, the local machine still needs a valid Git/worktree environment.

![Agents and worktrees screenshot](./assets/screenshot-agents.png)

### What is different between Claude Code and Codex?

They can both do multi-step coding, but they do not use exactly the same terminology or local execution model.

![Claude Code vs Codex screenshot](./assets/screenshot-claude-vs-codex.png)

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
- `docs/zh-CN/quickstart.md`
