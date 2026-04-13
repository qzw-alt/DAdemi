# WP-CLI 实战手册

> WordPress 命令行管理工具 2026-03-04

---

## 是什么？

WP-CLI = WordPress Command Line Interface
- 不登录后台管理WordPress
- 用命令行操作一切

---

## 安装

```bash
# 下载
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# 改为可执行
chmod +x wp-cli.phar

# 移到全局
sudo mv wp-cli.phar /usr/local/bin/wp

# 测试
wp --info
```

---

## 常用命令

### 1. 站点管理
```bash
wp core download          # 下载WordPress
wp core install          # 安装WordPress
wp core update           # 更新核心
wp core version          # 查看版本
```

### 2. 插件管理
```bash
wp plugin list           # 列出插件
wp plugin install <name> # 安装插件
wp plugin activate <name> # 激活插件
wp plugin deactivate <name> # 停用插件
wp plugin update <name> # 更新插件
wp plugin delete <name> # 删除插件
```

### 3. 主题管理
```bash
wp theme list            # 列出主题
wp theme install <name> # 安装主题
wp theme activate <name> # 启用主题
```

### 4. 文章管理
```bash
wp post list            # 列出文章
wp post create          # 创建文章
wp post update <id>     # 更新文章
wp post delete <id>     # 删除文章
```

### 5. 用户管理
```bash
wp user list            # 列出用户
wp user create          # 创建用户
wp user update <id>     # 更新用户
```

### 6. 数据库
```bash
wp db export            # 导出数据库
wp db import            # 导入数据库
wp db optimize          # 优化数据库
```

---

## 实战例子

### 安装WordPress（无人值守）
```bash
wp core download --locale=zh_CN
wp config create --dbname=wordpress --dbuser=root --dbpass=password
wp core install --url="example.com" --title="My Site" --admin_user=admin --admin_password=pass --admin_email="email@example.com"
```

### 一键安装WooCommerce
```bash
wp plugin install woocommerce --activate
wp theme install storefront --activate
```

### 批量替换内容
```bash
wp search-replace 'old-domain.com' 'new-domain.com'
```

### 导出所有文章
```bash
wp post list --post_type=post --format=ids | xargs wp post get --format=table > posts.txt
```

### 定时任务
```bash
wp cron event list      # 列出定时任务
wp cron event run <hook> # 执行定时任务
```

---

## Docker 中使用

在Docker容器里使用WP-CLI:

```yaml
# docker-compose.yml
services:
  wordpress:
    image: wordpress
    # WP-CLI已经内置

  wp:
    image: wordpress:cli
    depends_on:
      - wordpress
    volumes:
      - ./:/var/www/html
    command: wp --allowroot post list
```

---

## 实际运用

| 场景 | 命令 |
|------|------|
| 给客户建站 | wp core install + wp plugin install |
| 批量更新插件 | wp plugin update --all |
| 网站迁移 | wp db export + wp db import |
| 内容批量处理 | wp post create + wp post update |
| 紧急修复 | wp core update + wp plugin deactivate |

---

**配合Docker，一键建站不是梦！** 🚀
