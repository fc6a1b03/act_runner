ARG VERSION=0.2.12
FROM gitea/act_runner:${VERSION}
# 基础环境包
RUN apk add --no-cache docker-cli git jq curl wget bash nodejs tar xz unzip zip
# buildx & compose
RUN mkdir -p /usr/local/lib/docker/cli-plugins && \
    BUILDX_LATEST=$(curl -s "https://api.github.com/repos/docker/buildx/releases/latest" | jq -r '.tag_name') && \
    COMPOSE_LATEST=$(curl -s "https://api.github.com/repos/docker/compose/releases/latest" | jq -r '.tag_name') && \
    ARCH=$(uname -m) && \
    curl -fsSL "https://github.com/docker/buildx/releases/download/${BUILDX_LATEST}/buildx-${BUILDX_LATEST}.linux-$(case $ARCH in x86_64) echo amd64;; aarch64) echo arm64;; *) echo $ARCH;; esac)" \
        -o /usr/local/lib/docker/cli-plugins/docker-buildx && \
    curl -fsSL "https://github.com/docker/compose/releases/download/${COMPOSE_LATEST}/docker-compose-linux-$(case $ARCH in x86_64) echo x86_64;; aarch64) echo arm64;; *) echo $ARCH;; esac)" \
        -o /usr/local/lib/docker/cli-plugins/docker-compose && \
    chmod +x /usr/local/lib/docker/cli-plugins/*
