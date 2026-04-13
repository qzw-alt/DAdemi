# MEMORY.md — 长期记忆

## 身份
- **名字:** 德米
- **用户:** 伟烨
- **平台:** OpenClaw AI 助手
- **Emoji:** 🐱

## 重要配置
- 飞书 App ID: cli_a902c8c59cb99cb3
- GitHub Token: 已保存（credentials.md）

## ⭐ 记忆备份仓库
GitHub 仓库 `qzw-alt/DAdemi` 是我的专属外部记忆备份仓库。
- 备份目录: `/root/.openclaw/workspace/dedmini`
- 备份命令: `git add . && git commit -m "更新记忆" && git push origin master`
- 自动备份: 每天 23:30

## 关于伟烨
- 时区: Asia/Shanghai (GMT+8)
- 通过飞书联系我（2026-03-29）
- 配置了我的记忆管理系统

## 知识库
伟烨的个人知识库已建立：`workspace/knowledge/`
- AI/经济/哲学/心理学/学习科学/项目 六大分类
- 每个主题有"一句话总结" + 核心概念 + 缺口标注
- NotebookLM 已集成：笔记本内容已全部提炼入库（5个笔记本）
- 搜索脚本：`knowledge/knowledge_base.sh`
- notebooklm-py 虚拟环境：`~/venv/notebooklm/bin/notebooklm`
- 代理配置：`all_proxy=socks5://127.0.0.1:10808`

## 经验总结
- 国内网络无法直接访问 Google/DuckDuckGo（被 GFW 阻断），可用 Bing (cn.bing.com) 代替
- OpenClaw skill 安装从 ClawHub 下载，ClawHub 有 rate limit

## ⭐ 三层持续学习框架（Harrison Chase / LangChain）
来源：2026-04-08 伟烨分享

| 层级 | 学习内容 | 更新方式 | 成本 | 速度 | 上限 |
|---|---|---|---|---|---|
| **Model** | 模型权重（能力） | 微调/RLHF | 最高 | 最慢 | 最高 |
| **Harness** | 执行框架（工具流、提示词、流程） | traces+eval+codegen | 中 | 中 | 中 |
| **Context** | 运行时配置（记忆、技能、偏好） | 离线或运行时更新 | 最低 | 最快 | 低于Model |

**关键洞察：**
- Model 层更新后难以按权限/用户切分（企业硬约束）
- Context 层天然支持按用户/团队/租户分别维护
- Traces 是三层共同的学习原料，可观测性 = 学习基础设施
- Agent 持续变强的关键不是只换模型，而是想清楚该让哪一层学

**我的对应关系：**
- memory 系统 → Context 层
- skill 系统 → Harness 层

**SOP 位置：** `workspace/SOP/knowledge-capture.md`
