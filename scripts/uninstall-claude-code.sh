#!/usr/bin/env bash
set -euo pipefail

CLAUDE_DIR="${HOME}/.claude"
SETTINGS_PATH="${CLAUDE_DIR}/settings.json"
TMP_FILE="$(mktemp)"

if [ ! -f "${SETTINGS_PATH}" ]; then
  echo "No Claude Code settings file found at ${SETTINGS_PATH}"
  exit 0
fi

python3 - "$SETTINGS_PATH" "$TMP_FILE" <<'PY'
import json
import sys

settings_path, tmp_path = sys.argv[1:]

with open(settings_path, "r", encoding="utf-8") as f:
    data = json.load(f)

env = data.get("env", {})
for key in ("ANTHROPIC_BASE_URL", "ANTHROPIC_AUTH_TOKEN", "ANTHROPIC_MODEL"):
    env.pop(key, None)

if env:
    data["env"] = env
else:
    data.pop("env", None)

with open(tmp_path, "w", encoding="utf-8") as f:
    json.dump(data, f, ensure_ascii=False, indent=2)
    f.write("\n")
PY

mv "${TMP_FILE}" "${SETTINGS_PATH}"

echo "Removed cc-codex-plugin Claude Code env keys from ${SETTINGS_PATH}"
