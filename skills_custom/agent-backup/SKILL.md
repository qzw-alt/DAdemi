---
name: Agent Backup
description: Complete backup and restore solution for OpenClaw Agent. Create snapshots of workspace, configs, and memories. Restore to any previous state when things go wrong.
read_when:
  - User wants to backup agent state
  - User wants to restore from backup
  - User asks about rollback or snapshot
  - Agent configuration is broken and needs recovery
metadata: {"clawdbot":{"emoji":"💾","requires":{"bins":["powershell"]}}}
allowed-tools: [Bash]
---

# Agent Backup

Complete backup and restore solution for OpenClaw Agent.

## Features

- 📦 **Create Backup** - One-click backup of workspace, configs, and memories
- 📋 **List Backups** - View all backup history
- 🔄 **Restore Backup** - Rollback to any previous state
- 🗑️ **Delete Backup** - Clean up old backups
- 🔒 **Safe Restore** - Auto-creates temporary backup before restore

## What Gets Backed Up

| Content | Path | Description |
|---------|------|-------------|
| Workspace | `~/.openclaw/workspace/` | SOUL.md, MEMORY.md, memory files, skills |
| Config | `~/.openclaw/openclaw.json` | Main configuration |
| Credentials | `~/.openclaw/credentials/` | API keys (redacted) |
| Memory DB | `~/.openclaw/memory/` | Memory database |

## Usage

### Create Backup

```bash
# Create timestamped backup
agent-backup create

# Create named backup
agent-backup create before_major_change
```

### List Backups

```bash
agent-backup list
```

Shows all backups with size and date.

### Restore Backup

```bash
agent-backup restore backup_20240226_120000
```

⚠️ **Warning**: This will overwrite current state. A temporary backup is created automatically before restore.

### Delete Backup

```bash
agent-backup delete backup_20240226_120000
```

### View Backup Info

```bash
agent-backup info backup_20240226_120000
```

## Backup Storage

Backups are stored in: `~/.openclaw/backups/`

Each backup is a zip file containing:
```
backup_YYYYMMDD_HHMMSS.zip
├── workspace/          # All workspace files
├── credentials/        # API keys (redacted)
├── openclaw.json       # Main config
└── backup-info.json    # Metadata
```

## Best Practices

1. **Create backup before major changes**
   ```bash
   agent-backup create before_kimi_switch
   ```

2. **Create backup after stable configuration**
   ```bash
   agent-backup create stable_baseline
   ```

3. **Clean up old backups periodically**
   ```bash
   agent-backup list
   agent-backup delete backup_20240201_000000
   ```

## Recovery Scenarios

### Scenario 1: Configuration Broken

```bash
# See available backups
agent-backup list

# Restore to last known good state
agent-backup restore stable_baseline

# Restart gateway
openclaw gateway restart
```

### Scenario 2: Memory Files Corrupted

```bash
# Restore from backup
agent-backup restore backup_20240226_120000
```

### Scenario 3: Want to Experiment

```bash
# Create backup first
agent-backup create before_experiment

# Make changes...
# If something goes wrong, restore:
agent-backup restore before_experiment
```

## Security

- API keys in credentials are **redacted** (replaced with `***REDACTED***`)
- You'll need to re-enter API keys after restore
- Backup files are stored locally, not uploaded anywhere
