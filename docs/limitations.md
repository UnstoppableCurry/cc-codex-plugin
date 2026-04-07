# Limitations

## Request compatibility is not environment compatibility

This bridge can normalize request and response formats.

It cannot grant local IDE or CLI capabilities that the client expects from its own machine.

## Claude Code subagents still depend on the local machine

If Claude Code tries to create isolated subagents, the client may require:

- a valid Git repository
- at least one commit
- working `git worktree` support
- or configured `WorktreeCreate` / `WorktreeRemove` hooks

If those local prerequisites are missing, no bridge can fully fix that from the server side alone.

## Recommended operating mode

- Use the bridge to stabilize normal Claude Code / Codex requests
- Treat swarm or multi-agent workflows as a separate capability that must be validated on the client machine
