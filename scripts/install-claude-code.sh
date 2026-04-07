#!/usr/bin/env bash
set -euo pipefail

CLAUDE_DIR="${HOME}/.claude"
SETTINGS_PATH="${CLAUDE_DIR}/settings.json"
TMP_FILE="$(mktemp)"

mkdir -p "${CLAUDE_DIR}"

read -r -p "Bridge base URL (example: https://your-domain/anthropic): " BRIDGE_BASE_URL
read -r -p "Gateway key: " GATEWAY_KEY
read -r -p "Default model [claude-sonnet-4-6]: " DEFAULT_MODEL

DEFAULT_MODEL="${DEFAULT_MODEL:-claude-sonnet-4-6}"

python3 - "$SETTINGS_PATH" "$TMP_FILE" "$BRIDGE_BASE_URL" "$GATEWAY_KEY" "$DEFAULT_MODEL" <<'PY'
import json
import os
import sys

settings_path, tmp_path, base_url, key, model = sys.argv[1:]

data = {}
if os.path.exists(settings_path):
    with open(settings_path, "r", encoding="utf-8") as f:
        data = json.load(f)

env = data.get("env", {})
env["ANTHROPIC_BASE_URL"] = base_url
env["ANTHROPIC_AUTH_TOKEN"] = key
env["ANTHROPIC_MODEL"] = model
data["env"] = env

with open(tmp_path, "w", encoding="utf-8") as f:
    json.dump(data, f, ensure_ascii=False, indent=2)
    f.write("\n")
PY

mv "${TMP_FILE}" "${SETTINGS_PATH}"

echo
echo "Claude Code settings updated:"
echo "  ${SETTINGS_PATH}"
echo
echo "Configured keys:"
echo "  ANTHROPIC_BASE_URL=${BRIDGE_BASE_URL}"
echo "  ANTHROPIC_MODEL=${DEFAULT_MODEL}"
echo
echo "Restart Claude Code to apply the new configuration."
