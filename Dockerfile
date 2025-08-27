ARG VERSION=0.2.12
FROM gitea/act_runner:${VERSION}
# 安装必要工具
RUN apk add --no-cache curl tar xz unzip zip
# LTS Node.js
RUN ARCH=$(uname -m | sed 's/x86_64/x64/') \
 && NODE_VER=$(curl -s https://nodejs.org/dist/index.json | jq -r 'map(select(.lts))[0].version') \
 && echo "Installing Node.js ${NODE_VER}" \
 && curl -fsSLo /tmp/node.tar.xz https://nodejs.org/dist/${NODE_VER}/node-${NODE_VER}-linux-${ARCH}.tar.xz \
 && tar -xf /tmp/node.tar.xz -C /usr/local --strip-components=1 && rm -rf /tmp/node.tar.xz
RUN node -v && npm -v
