# Model Mapping

This repository does not force one universal mapping. Keep the mapping explicit.

Recommended style:

- expose a small number of stable public model names
- document which upstream runtime each one maps to
- avoid exposing dozens of aliases that users cannot reason about

Example:

- `claude-sonnet-4-6` -> your preferred balanced coding model
- `claude-opus-4-6` -> your preferred strongest reasoning model
- `claude-haiku-4-5` -> your preferred fast/cheap model

The important rule is not the exact mapping. The important rule is that the user-facing name stays stable and your documentation explains the behavior tradeoff.
