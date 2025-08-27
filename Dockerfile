ARG VERSION=0.2.12
FROM gitea/act_runner:${VERSION}
# 安装必要工具
RUN apk add --no-cache curl tar unzip jq
# 下载并安装fnm
RUN FNM_VERSION=$(curl -s https://api.github.com/repos/Schniz/fnm/releases/latest | jq -r .tag_name | sed 's/^v//') \
 && curl -fsSL https://github.com/Schniz/fnm/releases/latest/download/fnm-linux.zip -o /tmp/fnm.zip \
 && unzip /tmp/fnm.zip -d /usr/local/bin && rm /tmp/fnm.zip && chmod +x /usr/local/bin/fnm
# 设置 fnm 环境变量并安装/使用最新稳定 Node.js
ENV FNM_DIR=/root/.fnm
RUN eval "$(fnm env --shell=sh)" && fnm install --latest && fnm use --latest
# 创建指向全局 PATH 的软链接
RUN eval "$(fnm env --shell=sh)" \
 && ln -sf "$(fnm which)" /usr/local/bin/node \
 && ln -sf "$(dirname "$(fnm which)")/npm" /usr/local/bin/npm \
 && ln -sf "$(dirname "$(fnm which)")/npx" /usr/local/bin/npx
# 验证
RUN node -v && npm -v
