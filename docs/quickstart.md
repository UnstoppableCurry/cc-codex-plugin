# Quickstart

## Recommended path for Claude Code users

Run:

```bash
curl -fsSL https://raw.githubusercontent.com/UnstoppableCurry/cc-codex-plugin/main/scripts/install-claude-code.sh | bash
```

This is the intended main path for end users. You do not need to manually edit `~/.claude/settings.json` unless you want full control.

## 1. Start the bridge

1. Copy `config.example.toml` to `config.toml`
2. Fill in the auth token and upstream values you actually control
3. Build and run the Docker image

## 2. Connect Claude Code

Use the example at `examples/claude-code/settings.json` and set:

- `ANTHROPIC_AUTH_TOKEN`
- `ANTHROPIC_BASE_URL`
- `ANTHROPIC_MODEL`

The installer script writes exactly these values for you.

## 3. Connect Codex

Use the example at `examples/codex/config.example.toml` and point Codex to the local bridge provider.

## 4. Validate

Start with a plain single-agent prompt first:

- ask a simple question
- ask for a small code explanation
- confirm request logs hit the bridge

Only after that should you test tools or multi-step workflows.
