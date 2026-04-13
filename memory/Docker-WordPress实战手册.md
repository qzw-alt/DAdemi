# Docker + WordPress 实战手册

> 2026-03-04

---

## 核心概念

| 概念 | 解释 |
|------|------|
| **镜像 (Image)** | 模板，类似装系统的ISO文件 |
| **容器 (Container)** | 镜像的运行实例 |
| **仓库 (Registry** | 存放镜像的地方，如Docker Hub |

---

## 一键部署 WordPress

### 方式1: docker-compose（推荐）

创建 `docker-compose.yml`:
```yaml
version: '3.8'

services:
  wordpress:
    image: wordpress:latest
    ports:
      - "8080:80"
    environment:
      WORDPRESS_DB_HOST: db
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: yourpassword
      WORDPRESS_DB_NAME: wordpress
    volumes:
      - wordpress:/var/www/html
    depends_on:
      - db

  db:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: yourpassword
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: yourpassword
    volumes:
      - db:/var/lib/mysql

volumes:
  wordpress:
  db:
```

**启动**:
```bash
docker-compose up -d
```

**访问**: http://localhost:8080

---

### 方式2: 简单命令

```bash
# 启动MySQL
docker run -d --name mysql \
  -e MYSQL_ROOT_PASSWORD=password \
  -e MYSQL_DATABASE=wordpress \
  -v mysql:/var/lib/mysql \
  mysql:8.0

# 启动WordPress
docker run -d --name wordpress \
  -p 8080:80 \
  -e WORDPRESS_DB_HOST=mysql \
  -e WORDPRESS_DB_USER=root \
  -e WORDPRESS_DB_PASSWORD=password \
  --link mysql \
  wordpress
```

---

## 常用命令

### 镜像操作
```bash
docker images              # 查看镜像
docker pull wordpress      # 拉取镜像
docker rmi <image_id>     # 删除镜像
```

### 容器操作
```bash
docker ps                 # 运行中的容器
docker ps -a             # 所有容器
docker start <name>      # 启动
docker stop <name>       # 停止
docker restart <name>    # 重启
docker rm <name>         # 删除
```

### 日志和调试
```bash
docker logs -f <name>    # 查看日志
docker exec -it <name> bash  # 进入容器
```

### 一键管理
```bash
docker-compose up -d      # 启动（后台）
docker-compose down       # 停止并删除
docker-compose restart    # 重启
docker-compose logs -f   # 查看日志
```

---

## 进阶：多站点配置

```yaml
version: '3.8'

services:
  site1:
    image: wordpress
    ports:
      - "8081:80"
    volumes:
      - ./site1:/var/www/html
    environment:
      WORDPRESS_DB_HOST: db

  site2:
    image: wordpress
    ports:
      - "8082:80"
    volumes:
      - ./site2:/var/www/html
    environment:
      WORDPRESS_DB_HOST: db

  db:
    image: mysql:8.0
    volumes:
      - db:/var/lib/mysql
```

---

## 实际运用：建站服务

### 给客户建站流程

1. **创建客户目录**: `mkdir client-name`
2. **编写docker-compose.yml**
3. **启动**: `docker-compose up -d`
4. **初始化**: 访问 IP:端口 完成WordPress安装
5. **备份**: 定期 `docker-compose down` + 备份数据

### 优势

| 优势 | 说明 |
|------|------|
| 快速 | 5分钟建好一个站 |
| 隔离 | 每个客户独立容器 |
| 迁移 | 打包带走，移到新服务器 |
| 回滚 | 出问题一键还原 |

---

## 常用镜像

| 镜像 | 用途 |
|------|------|
| wordpress | WordPress主程序 |
| mysql:8.0 / mysql:5.7 | 数据库 |
| phpmyadmin | 数据库管理界面 |
| nginx | 反向代理 |
| redis | 缓存加速 |

---

## 部署到服务器

1. 安装Docker:
```bash
curl -fsSL https://get.docker.com | bash
```

2. 上传docker-compose.yml

3. 启动:
```bash
docker-compose up -d
```

4. 配置域名解析

---

**这就是我们的建站核心技术！** 🚀
