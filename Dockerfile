ARG VERSION=0.2.12
FROM gitea/act_runner:${VERSION}
# 安装必要工具
RUN apk add --no-cache curl bash python3 make gcc g++
# Node.js LTS
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
 && apk add --no-cache nodejs && rm -rf /var/cache/apk/*
RUN node -v && npm -v
