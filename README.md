# cc-codex-plugin

An open-source bridge project for users who want a Claude Code style workflow on top of a Codex-compatible runtime path.

This repository is intentionally C-end friendly:

- clear Docker entrypoint
- example client configuration
- explicit model mapping
- explicit limitations around agents, worktrees, and local environment requirements

## What It Is

`cc-codex-plugin` packages a Codex-oriented proxy/plugin entrypoint and documents how to connect clients such as Claude Code and Codex CLI to a unified gateway.

It is designed for:

- users who want one stable bridge layer
- operators who want a documented compatibility surface
- developers who want an inspectable starting point instead of a closed relay box

## What It Is Not

- not a full hosted service
- not a secret production config dump
- not a guarantee that Claude Code local subagents will work without local Git/worktree support

## Repository Layout

- `Dockerfile` runnable image for the plugin bridge
- `config.example.toml` example server/plugin config
- `examples/claude-code/` client-side Claude Code example
- `examples/codex/` client-side Codex example
- `docs/` human-readable setup, model mapping, and limitations

## Quick Start

```bash
cp config.example.toml config.toml
docker build -t cc-codex-plugin .
docker run --rm -p 8000:8000 \
  -v "$(pwd)/config.toml:/app/config.toml:ro" \
  cc-codex-plugin \
  ccproxy serve --config /app/config.toml --host 0.0.0.0 --port 8000
```

Then point your client to the bridge and use one of the example configs in `examples/`.

## Key Limitation

This project can make request/response compatibility smoother. It cannot replace Claude Code's local `git worktree` requirement for true multi-agent isolation. If a client wants subagents or swarm-style parallelism, the local machine still needs a valid Git/worktree environment.

See:

- `docs/quickstart.md`
- `docs/model-mapping.md`
- `docs/limitations.md`
