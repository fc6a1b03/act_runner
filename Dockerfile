ARG VERSION=0.2.12
FROM gitea/act_runner:${VERSION}
# 安装必要工具
RUN apk add --no-cache curl tar xz
# Node.js LTS
RUN ARCH=$(uname -m | sed 's/x86_64/x64/;s/aarch64/arm64/') \
 && VERSION=$(curl -s https://nodejs.org/dist/index.tab | awk -F '\t' 'NR>1 && $9 != "-" {print $1; exit}') \
 && curl -fsSLo /tmp/node.tar.xz "https://nodejs.org/dist/${VERSION}/node-${VERSION}-linux-${ARCH}.tar.xz" \
 && tar -xf /tmp/node.tar.xz -C /usr/local --strip-components=1 rm -f /tmp/node.tar.xz
RUN node -v && npm -v
