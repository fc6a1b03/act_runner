ARG VERSION=0.2.12
FROM gitea/act_runner:${VERSION}
# 基础环境包
RUN apk add --no-cache docker-cli git jq curl wget bash nodejs tar xz unzip zip
RUN mkdir -p /usr/local/lib/docker/cli-plugins && \
    # 获取 docker-buildx 最新版本 
    BUILDX_LATEST=$(curl -s "https://api.github.com/repos/docker/buildx/releases/latest" | grep -Po '"tag_name": "\K[^"]*') && \
    # 获取 docker-compose 最新版本 
    COMPOSE_LATEST=$(curl -s "https://api.github.com/repos/docker/compose/releases/latest" | grep -Po '"tag_name": "\K[^"]*') && \
    # 动态检测架构 (适配 AMD64/ARM64) 
    ARCH=$(uname -m | sed 's/x86_64/amd64/;s/aarch64/arm64/') && \
    # 下载并安装 buildx 
    curl -fsSL "https://github.com/docker/buildx/releases/download/${BUILDX_LATEST}/buildx-${BUILDX_LATEST}.linux-${ARCH}" \
        -o /usr/local/lib/docker/cli-plugins/docker-buildx && \
    # 下载并安装 compose 
    curl -fsSL "https://github.com/docker/compose/releases/download/${COMPOSE_LATEST}/docker-compose-linux-${ARCH}" \
        -o /usr/local/lib/docker/cli-plugins/docker-compose && \
    # 赋予执行权限
    chmod +x /usr/local/lib/docker/cli-plugins/*
