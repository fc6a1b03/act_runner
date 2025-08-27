ARG VERSION=0.2.12
FROM gitea/act_runner:${VERSION}
# 安装必要工具
RUN apk add --no-cache curl tar xz
# Node.js LTS
RUN ARCH="x64" \
 && LATEST_VERSION=$(curl -s https://nodejs.org/dist/latest/SHASUMS256.txt | grep -o 'node-v[0-9]*\.[0-9]*\.[0-9]*-linux-x64.tar.xz' | head -1) \
 && curl -fsSLo /tmp/node.tar.xz "https://nodejs.org/dist/latest/${LATEST_VERSION}" \
 && tar -xf /tmp/node.tar.xz -C /usr/local --strip-components=1 && rm -f /tmp/node.tar.xz \
 && ln -s /usr/local/bin/node /usr/bin/node && ln -s /usr/local/bin/npm /usr/bin/npm
RUN node -v && npm -v
