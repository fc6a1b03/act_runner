# act-runner

> 官方 [gitea/act_runner](https://gitea.com/gitea/act_runner) 镜像之上，一键补充常用 CI/CD 依赖的增强版 Runner 镜像

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

## 🔧 Gitea Actions 工作流说明

触发方式：Repository → Actions → **Build and Publish Docker Image** → Run workflow

| 输入参数 | 默认值 | 说明 |
|----------|--------|------|
| `VERSION` | `0.2.12` | 指定底层 `gitea/act_runner` 镜像版本 |

执行后将在 GHCR 生成以下标签：

```
ghcr.io/<owner>/<repo>:latest
ghcr.io/<owner>/<repo>:<VERSION>
```

## 🔍 测查案例

- docker
```bash
docker run -it --rm --entrypoint /bin/sh -e DOCKER_HOST="tcp://127.0.0.1:2375" ghcr.io/<owner>/<repo>:0.2.12 -c "docker -H \$DOCKER_HOST -v"
Docker version 28.3.3, build 980b85681696fbd95927fd8ded8f6d91bdca95b0
```

- buildx
```bash
docker run -it --rm --entrypoint /bin/sh -e DOCKER_HOST="tcp://127.0.0.1:2375" ghcr.io/<owner>/<repo>:0.2.12 -c "docker -H \$DOCKER_HOST buildx version"
github.com/docker/buildx v0.27.0 bac71def78b077ee6a2607119f88e291861b18ac
```

- compose
```bash
docker run -it --rm --entrypoint /bin/sh -e DOCKER_HOST="tcp://127.0.0.1:2375" ghcr.io/<owner>/<repo>:0.2.12 -c "docker -H \$DOCKER_HOST compose version"
Docker Compose version v2.39.2
```

## 🚀 使用案例

```yaml
services:
  runner:
    container_name: runner
    image: ghcr.io/<owner>/<repo>:0.2.12
    environment:
      # 指向 Gitea 服务置
      GITEA_INSTANCE_URL: http://gitea
      GITEA_RUNNER_REGISTRATION_TOKEN: 123
      GITEA_RUNNER_NAME: runner
      GITEA_RUNNER_LABELS: linux
      # 指向 DinD 服务
      DOCKER_HOST: "tcp://dind:2375"
  dind:
    image: docker:dind
    container_name: dind
    environment:
      # 构建机可以关闭TLS提升速度
      DOCKER_TLS_CERTDIR: ""
    volumes:
      # 守护进程配置
      - daemon.json:/etc/docker/daemon.json
    # 必须特权模式
    privileged: true
    # 开启Api访问
    command: ["dockerd", "--host=tcp://0.0.0.0:2375 --host=unix:///var/run/docker.sock"]
```
