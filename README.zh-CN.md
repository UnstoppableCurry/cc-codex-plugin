# cc-codex-plugin

让 Claude Code 通过一个 Codex 风格的网关来工作，并且尽量不需要你手改配置文件。

这个仓库当前的重点不是 Docker，而是 **Claude Code 一键接入**。

## 这是什么

Claude Code 目前没有公开的“第三方插件商店安装仓库”能力。

所以这个项目采用的是最接近插件体验的方案：

- 提供一个 bridge / 兼容层运行时
- 提供一键安装脚本，直接写入 Claude Code 配置
- 提供 Claude Code 和 Codex 的配置样例

换句话说：

这不是“官方插件市场插件”，而是一个 **插件化体验的一键安装器 + bridge**。

## 适合谁

- 想继续用 Claude Code，但订阅或上游想走 Codex 风格能力的人
- 想统一客户端接入方式的人
- 想把配置和桥接逻辑做成开源项目的人

## 最快用法

直接执行：

```bash
curl -fsSL https://raw.githubusercontent.com/UnstoppableCurry/cc-codex-plugin/main/scripts/install-claude-code.sh | bash
```

脚本会：

- 询问你的 bridge base URL
- 询问你的 gateway key
- 可选设置默认模型
- 自动更新 `~/.claude/settings.json`
- 尽量保留你原本已有配置，只补需要的环境变量

然后重启 Claude Code 即可。

## 如果你不想跑脚本

手动参考：

- `examples/claude-code/settings.json`

把里面的内容合并进：

- `~/.claude/settings.json`

## 目录说明

- `scripts/install-claude-code.sh`：一键安装 Claude Code 配置
- `scripts/uninstall-claude-code.sh`：删除这套配置写入的 env 键
- `examples/claude-code/`：Claude Code 配置样例
- `examples/codex/`：Codex 配置样例
- `config.example.toml`：bridge 运行配置样例
- `docs/`：英文文档
- `docs/zh-CN/`：中文文档

## 自托管 bridge

如果你要自己运行 bridge：

```bash
cp config.example.toml config.toml
docker build -t cc-codex-plugin .
docker run --rm -p 8000:8000 \
  -v "$(pwd)/config.toml:/app/config.toml:ro" \
  cc-codex-plugin \
  ccproxy serve --config /app/config.toml --host 0.0.0.0 --port 8000
```

然后再用安装脚本或手动配置，把 Claude Code 指过去。

## 重要限制

这个项目能解决的是：

- 请求格式兼容
- 接入体验
- 配置简化

它不能替代的是：

- Claude Code 本地的 `git worktree`
- 本地 subagent / swarm 所需的工作区隔离条件

也就是说：

普通请求链路可以通过 bridge 做兼容，但如果 Claude Code 本地要起多 agent，最终还是要满足本机环境要求。

## 中文文档

- [中文快速开始](./docs/zh-CN/quickstart.md)
- [中文模型映射说明](./docs/zh-CN/model-mapping.md)
- [中文限制说明](./docs/zh-CN/limitations.md)
