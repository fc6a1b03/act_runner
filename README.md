# act-runner

本项目提供一个 **极简 Dockerfile**，用于在 **官方 gitea/act_runner 镜像基础上，动态安装额外依赖**（如 Node.js、npm、curl、tar、unzip 等）。  
通过 **GitHub Actions 工作流**（或 Gitea Actions）手动触发构建，无需维护复杂脚本，也无需预先打包任何组件。

---

## 📌 项目特点

- **零侵入**：仅在上游镜像外叠加一层 `apk add`，保持与原镜像 100% 兼容。  
- **参数化**：  
  - `VERSION`：指定上游 gitea/act_runner 标签（默认 `v0.2.12`）。  
  - `DEPEND`：指定需要额外安装的 Alpine 包（默认 `nodejs npm curl tar unzip`）。  
- **一键构建**：通过 Actions 手动触发，自动推送至指定镜像仓库。  
- **体积最小**：仅增加实际依赖大小，无多余文件。

---

## 📦 使用构建好的镜像

```bash
docker run --rm \
  -e GITEA_INSTANCE_URL=https://gitea.example.com \
  -e GITEA_RUNNER_REGISTRATION_TOKEN=Token \
  ghcr.io/<username>/act-runner:v0.2.12
```

或在 Kubernetes / K3s 中直接替换镜像即可。

---

## 📄 许可证

与上游 gitea/act_runner 保持一致：MIT。
