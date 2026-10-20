# Small-office stack (lite)

## English

### Purpose

A free slice of the office pack: Caddy and Vaultwarden only. Nextcloud, Postgres, Uptime Kuma, File Browser, the LAN Caddyfile, and the backup/restore scripts are in the full pack.

### Deliverables

- `deliverables/compose.yaml`
- `deliverables/.env.example`
- `deliverables/Caddyfile`

### Quick start

```bash
cd deliverables
cp .env.example .env
docker compose --env-file .env up -d
```

Replace `vault.example.com` and the change-me admin token before you expose port 443. Signups are closed. Invite accounts from the admin page.

### Requirements

Docker 24 or newer and Compose v2.

## 中文

### 用途

完整包的免费子集：只有 Caddy 和 Vaultwarden。Nextcloud、Postgres、Uptime Kuma、File Browser、内网 Caddyfile，以及备份和恢复脚本在完整版里。

### 交付清单

- `deliverables/compose.yaml`
- `deliverables/.env.example`
- `deliverables/Caddyfile`

### 快速开始

```bash
cd deliverables
cp .env.example .env
docker compose --env-file .env up -d
```

对外开放 443 之前，先换掉 `vault.example.com` 和 change-me 管理口令。自行注册是关的，从管理页邀请账号。

### 环境要求

Docker 24 或更高，以及 Compose v2。

Full version / 完整版: GUMROAD_URL

## Delivery time / 交付时间

- Lite (this folder): free, available now. / 精简版（本目录）：免费，立即可用。
- Full version: instant download after purchase (GUMROAD_URL). / 完整版：购买后即时下载（GUMROAD_URL）。
