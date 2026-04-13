# TOOLS.md - Local Notes

## What Goes Here

Things like:

- Camera names and locations
- SSH hosts and aliases
- Preferred voices for TTS
- Speaker/room names
- Device nicknames
- Anything environment-specific

---

## 🔧 GitHub 访问解决方案

> **永久方案**：使用 jina.ai 代理访问 GitHub（绕过网络限制）

### 方法
在任意 GitHub URL 前添加前缀：
```
https://r.jina.ai/http://
```

### 示例

| 原始 URL | 代理 URL |
|----------|----------|
| `https://github.com/owner/repo` | `https://r.jina.ai/http://github.com/owner/repo` |
| `https://raw.githubusercontent.com/...` | `https://r.jina.ai/http://raw.githubusercontent.com/...` |
| `https://github.com/owner/repo/tree/main/path` | `https://r.jina.ai/http://github.com/owner/repo/tree/main/path` |

### 使用场景
- 浏览 GitHub 仓库内容
- 获取 raw 文件（SKILL.md、代码等）
- 查看目录结构
- 替代不稳定的直接访问

### 注意事项
- jina.ai 会返回 Markdown 格式的内容
- 适合文本内容，不适合二进制文件
- 如有问题，尝试 `https://r.jina.ai/http://` 或 `https://r.jina.ai/https://`

---

## API Keys

> 注意：敏感API Key已移除，请从环境变量或密钥管理服务获取

- **Kimi API**: (配置在openclaw系统里)
- **Tavily API**: (配置在openclaw系统里)
- **GitHub Token**: (需要时从伟烨获取)

---
