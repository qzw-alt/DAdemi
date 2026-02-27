# Agent Reach Skill for OpenClaw

> 给 AI Agent 一键装上互联网能力
> 版本: 1.2.0 | 已安装渠道: 4/12

---

## 已解锁功能（立即可用）

| 渠道 | 工具 | 命令示例 |
|------|------|----------|
| 🌐 任意网页 | Jina Reader | `curl -s "https://r.jina.ai/URL"` |
| 📺 YouTube 字幕 | yt-dlp | `yt-dlp --dump-json URL` |
| 📺 B站视频 | yt-dlp | `yt-dlp --dump-json URL` |
| 📡 RSS 订阅 | feedparser | Python feedparser 库 |

---

## 使用示例

### 读取任意网页
```bash
curl -s "https://r.jina.ai/https://example.com/article"
```

### 提取 YouTube 视频字幕
```bash
yt-dlp --dump-json "https://youtube.com/watch?v=VIDEO_ID" | python -c "import json,sys; d=json.load(sys.stdin); print(d.get('description',''))"
```

### 提取 B站视频信息
```bash
yt-dlp --dump-json "https://bilibili.com/video/BVxxxx" | python -c "import json,sys; d=json.load(sys.stdin); print(d.get('title'), d.get('description'))"
```

### 读取 RSS 源
```python
python -c "import feedparser; f=feedparser.parse('https://example.com/rss'); print([e.title for e in f.entries[:5]])"
```

---

## 状态检查

运行以下命令查看所有渠道状态：
```bash
agent-reach doctor
```

---

## 待配置功能

以下功能需要额外配置：

| 渠道 | 需要配置 | 说明 |
|------|----------|------|
| 🔍 全网搜索 | mcporter + Exa | `npm install -g mcporter` |
| 🐦 Twitter/X | xreach CLI + Cookie | 需登录 Twitter 获取 Cookie |
| 📕 小红书 | Docker + MCP | 需 Docker 环境 |
| 🎵 抖音 | douyin-mcp-server | Python MCP 服务 |
| 📦 GitHub | gh CLI | 可选，提高 API 限额 |

---

## 用户指示

当用户要求：
- "读这个网页" → 使用 Jina Reader (curl)
- "总结这个视频" → 使用 yt-dlp 提取字幕
- "看这个 RSS" → 使用 feedparser
- "检查 Agent Reach 状态" → 运行 `agent-reach doctor`

---

安装路径: `C:\Users\csdm2\.openclaw\workspace\temp_agent_reach\Agent-Reach-main`
配置路径: `~/.agent-reach/`
