ARG VERSION=0.2.12
FROM gitea/act_runner:${VERSION}
# 安装必要工具
RUN apk add --no-cache curl tar xz
# LTS Node.js
RUN ARCH=$(uname -m | sed 's/x86_64/x64/') \
 && curl -fsSLo /tmp/node.tar.xz https://nodejs.org/dist/latest-v20.x/node-${ARCH}.tar.xz \
 && tar -xf /tmp/node.tar.xz -C /usr/local --strip-components=1 && rm -rf /tmp/node.tar.xz
RUN node -v && npm -v
