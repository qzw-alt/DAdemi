# Agent Backup Skill

为 OpenClaw Agent 提供完整的备份和恢复功能。

## 功能

- 📦 **创建备份**：一键备份 workspace、配置、记忆文件
- 📋 **列出备份**：查看所有历史备份
- 🔄 **恢复备份**：一键恢复到指定版本
- 🗑️ **删除备份**：清理旧备份
- ⏰ **自动备份**：支持定时自动备份

## 使用方式

### Bash 命令

```bash
# 创建备份（带时间戳）
agent-backup create [name]

# 列出所有备份
agent-backup list

# 恢复备份
agent-backup restore <backup-name>

# 删除备份
agent-backup delete <backup-name>

# 查看备份详情
agent-backup info <backup-name>
```

### 备份内容

- `workspace/` - 工作目录（SOUL.md、MEMORY.md、记忆文件等）
- `openclaw.json` - 主配置文件
- `credentials/` - 凭证文件（敏感信息脱敏）
- `channels/` - 频道配置
- `memory/` - 记忆数据库

## 备份存储位置

`~/.openclaw/backups/`

## 要求

- PowerShell (Windows) 或 Bash (Linux/macOS)
- 7zip 或 tar（用于压缩）

## 安装

```bash
npm install -g agent-backup
# 或
npx agent-backup
```
