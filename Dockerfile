ARG VERSION=0.2.12
FROM gitea/act_runner:${VERSION}
# 安装必要工具
RUN apk add --no-cache curl tar xz \
 && ARCH=$(uname -m | sed 's/x86_64/x64/;s/aarch64/arm64/') \
 && LATEST_URL=$(curl -s https://nodejs.org/dist/index.json \
                | awk -F'"' '/"lts"/{for(i=1;i<=NF;i++)if($i=="lts"){getline;getline;print $(i+1)}}' \
                | sort -V | tail -1) \
 && curl -fsSLo /tmp/node.tar.xz https://nodejs.org/dist/${LATEST_URL}/node-${LATEST_URL}-linux-${ARCH}.tar.xz \
 && tar -xf /tmp/node.tar.xz -C /usr/local --strip-components=1 && rm -rf /tmp/node.tar.xz
RUN node -v && npm -v
