ARG VERSION=0.2.12
FROM gitea/act_runner:${VERSION}
RUN apk add --no-cache docker-cli git jq curl wget bash nodejs tar xz unzip zip
RUN mkdir -p /usr/local/lib/docker/cli-plugins \
    && curl -fsSL https://github.com/docker/buildx/releases/download/v0.21.0/buildx-v0.21.0.linux-$(uname -m | sed 's/x86_64/amd64/;s/aarch64/arm64/') \
        -o /usr/local/lib/docker/cli-plugins/docker-buildx \
    && curl -fsSL https://github.com/docker/compose/releases/download/v2.39.2/docker-compose-linux-$(uname -m | sed 's/x86_64/x86_64/;s/aarch64/arm64/') \
        -o /usr/local/lib/docker/cli-plugins/docker-compose \
    && chmod +x /usr/local/lib/docker/cli-plugins/*
