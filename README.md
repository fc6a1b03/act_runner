# act-runner

> 官方 `[gitea/act_runner](https://gitea.com/gitea/act_runner)` 镜像之上，一键补充常用 CI/CD 依赖的增强版 Runner 镜像  
> 直接推送至 GitHub Container Registry（GHCR），开箱即用，支持多架构构建。

---

## 📌 项目简介

`act-runner` 仅包含 **2 个文件**：

| 文件 | 作用 |
|------|------|
| **Dockerfile** | 基于官方 `gitea/act_runner:<VERSION>` 镜像，通过 Alpine APK 与官方二进制包并行安装：<br>• `docker-cli` `git` `jq` `curl` `wget` `bash` `nodejs` `tar` `xz` `unzip` `zip`<br>• `docker-buildx`<br>• `docker-compose` |
| **.github/workflows/build.yml** | GitHub Actions 工作流<br>• 手动触发（`workflow_dispatch`）<br>• 支持输入自定义 `VERSION`（默认 0.2.12）<br>• 自动登录 GHCR → 构建 → 推送 `latest` 与版本双标签 |

镜像已内置 **Docker Buildx / Compose CLI 插件**，可直接在 Gitea Actions、GitHub Actions 或本地 `act` 环境中使用，无需额外安装。

---

## 📦 已预装工具清单

| 类别 | 工具 |
|------|------|
| Alpine 包 | docker-cli, git, jq, curl, wget, bash, nodejs, npm, tar, xz, unzip, zip |
| Docker CLI 插件 | buildx latest, compose latest |

---

## 🔧 GitHub Actions 工作流说明

触发方式：Repository → Actions → **Build and Publish Docker Image** → Run workflow

| 输入参数 | 默认值 | 说明 |
|----------|--------|------|
| `VERSION` | `0.2.12` | 指定底层 `gitea/act_runner` 镜像版本 |

执行后将在 GHCR 生成以下标签：

```
ghcr.io/<owner>/<repo>:latest
ghcr.io/<owner>/<repo>:<VERSION>
```
