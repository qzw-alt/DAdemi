# Cloudflare API 实战手册

> 域名/DNS/SSL 管理 2026-03-04

---

## 是什么？

Cloudflare API = 通过代码管理：
- DNS 解析记录
- SSL 证书
- CDN 缓存
- 域名设置

---

## 获取 API Token

1. 登录 Cloudflare
2. 个人资料 → API Tokens
3. 创建自定义 Token 或使用 Edit zone DNS

---

## 基础命令

### 1. DNS 记录管理

**获取域名ID**:
```bash
curl -X GET "https://api.cloudflare.com/client/v4/zones" \
  -H "Authorization: Bearer YOUR_API_TOKEN"
```

**添加A记录**:
```bash
curl -X POST "https://api.cloudflare.com/client/v4/zones/ZONE_ID/dns_records" \
  -H "Authorization: Bearer YOUR_API_TOKEN" \
  -H "Content-Type: application/json" \
  --data '{"type":"A","name":"www","content":"1.2.3.4","ttl":3600}'
```

**添加CNAME记录**:
```bash
curl -X POST "https://api.cloudflare.com/client/v4/zones/ZONE_ID/dns_records" \
  -H "Authorization: Bearer YOUR_API_TOKEN" \
  -H "Content-Type: application/json" \
  --data '{"type":"CNAME","name":"blog","content":"example.com","ttl":3600}'
```

**列出所有记录**:
```bash
curl -X GET "https://api.cloudflare.com/client/v4/zones/ZONE_ID/dns_records" \
  -H "Authorization: Bearer YOUR_API_TOKEN"
```

**删除记录**:
```bash
curl -X DELETE "https://api.cloudflare.com/client/v4/zones/ZONE_ID/dns_records/RECORD_ID" \
  -H "Authorization: Bearer YOUR_API_TOKEN"
```

---

### 2. SSL 证书

**获取SSL证书状态**:
```bash
curl -X GET "https://api.cloudflare.com/client/v4/zones/ZONE_ID/ssl" \
  -H "Authorization: Bearer YOUR_API_TOKEN"
```

**设置SSL模式**:
```bash
curl -X PATCH "https://api.cloudflare.com/client/v4/zones/ZONE_ID/ssl/universal/settings" \
  -H "Authorization: Bearer YOUR_API_TOKEN" \
  -H "Content-Type: application/json" \
  --data '{"enabled":true}'
```

SSL模式选项：
- `off` - 关闭
- `flexible` - 灵活
- `full` - 完整
- `strict` - 严格

---

### 3. 缓存管理

**清除所有缓存**:
```bash
curl -X DELETE "https://api.cloudflare.com/client/v4/zones/ZONE_ID/purge_cache" \
  -H "Authorization: Bearer YOUR_API_TOKEN" \
  -H "Content-Type: application/json" \
  --data '{"purge_everything":true}'
```

**清除特定URL**:
```bash
curl -X DELETE "https://api.cloudflare.com/client/v4/zones/ZONE_ID/purge_cache" \
  -H "Authorization: Bearer YOUR_API_TOKEN" \
  -H "Content-Type: application/json" \
  --data '{"files":["https://example.com/style.css"]}'
```

---

### 4. 域名列表

**获取所有域名**:
```bash
curl -X GET "https://api.cloudflare.com/client/v4/zones" \
  -H "Authorization: Bearer YOUR_API_TOKEN"
```

---

## 实用脚本

### 一键添加网站DNS

```bash
#!/bin/bash
# 添加网站DNS记录

ZONE_ID="YOUR_ZONE_ID"
TOKEN="YOUR_API_TOKEN"

# 添加A记录 (主域名)
curl -X POST "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  --data '{"type":"A","name":"@","content":"SERVER_IP","ttl":3600}'

# 添加A记录 (www)
curl -X POST "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  --data '{"type":"A","name":"www","content":"SERVER_IP","ttl":3600}'
```

---

### 自动刷新缓存

```bash
#!/bin/bash
# 部署后自动刷新缓存

ZONE_ID="YOUR_ZONE_ID"
TOKEN="YOUR_API_TOKEN"

curl -X DELETE "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/purge_cache" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  --data '{"purge_everything":true}'
```

---

## 常用场景

| 场景 | 操作 |
|------|------|
| 绑定新域名 | 添加A记录 |
| 配置子域名 | 添加CNAME记录 |
| 开启HTTPS | 设置SSL为flexible |
| 网站更新 | 清除缓存 |
| 迁移服务器 | 修改A记录IP |

---

## 免费版功能

| 功能 | 免费版 |
|------|--------|
| DNS管理 | ✅ |
| SSL | ✅ |
| CDN | ✅ |
| 缓存清除 | ✅ |
| 页面规则 | 3条 |

---

**配合Docker，一键建站+域名绑定+SSL！** 🚀
