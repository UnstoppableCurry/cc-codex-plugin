# 中文快速开始

## 推荐路径：先装 Claude Code 配置

执行：

```bash
curl -fsSL https://raw.githubusercontent.com/UnstoppableCurry/cc-codex-plugin/main/scripts/install-claude-code.sh | bash
```

这是面向终端用户的主路径。一般不需要你手动编辑 `~/.claude/settings.json`。

## 第一步：准备 bridge

1. 复制 `config.example.toml` 为 `config.toml`
2. 填入你自己的认证信息和上游配置
3. 启动 bridge

## 第二步：连接 Claude Code

安装脚本会自动写入以下配置项：

- `ANTHROPIC_AUTH_TOKEN`
- `ANTHROPIC_BASE_URL`
- `ANTHROPIC_MODEL`

如果你不想用脚本，也可以手动参考：

- `examples/claude-code/settings.json`

## 第三步：连接 Codex

如果你要接 Codex，参考：

- `examples/codex/config.example.toml`

## 第四步：验证

先做最小验证：

- 让 Claude Code 回答一个简单问题
- 让它解释一小段代码
- 确认请求已经命中你的 bridge 日志

不要一上来就测多 agent 或长链路任务。
