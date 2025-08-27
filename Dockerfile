ARG VERSION=0.2.12
FROM gitea/act_runner:${VERSION}
# 安装必要工具
RUN apk add --no-cache curl tar xz
# Node.js LTS
RUN ARCH=$(uname -m | sed 's/x86_64/x64/;s/aarch64/arm64/') \
 && LATEST_VER=$(curl -s https://nodejs.org/dist/index.json \
                 | sed -n 's/.*"version":"\([^"]*\)".*"lts":"[^"]*".*/\1/p' \
                 | sort -V | tail -1) \
 && echo "Installing Node.js ${LATEST_VER}" \
 && curl -fsSLo /tmp/node.tar.xz \
    https://nodejs.org/dist/${LATEST_VER}/node-${LATEST_VER}-linux-${ARCH}.tar.xz \
 && tar -xf /tmp/node.tar.xz -C /usr/local --strip-components=1 rm -rf /tmp/node.tar.xz
RUN node -v && npm -v
