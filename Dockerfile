ARG VERSION=0.2.12
FROM gitea/act_runner:${VERSION}
# 安装必要工具
RUN apk add --no-cache curl tar unzip jq
# 获取 fnm 最新版本号并安装
RUN FNM_VERSION=$(curl -s https://api.github.com/repos/Schniz/fnm/releases/latest | jq -r .tag_name | sed 's/^v//') \
 && curl -fsSL https://github.com/Schniz/fnm/releases/latest/download/fnm-linux.zip -o /tmp/fnm.zip \
 && unzip /tmp/fnm.zip -d /usr/local/bin && rm /tmp/fnm.zip && chmod +x /usr/local/bin/fnm
# 安装并使用最新稳定版
ENV FNM_DIR=/root/.fnm
RUN /usr/local/bin/fnm install --latest && /usr/local/bin/fnm use latest
# 将 node/npm 链接到系统 PATH
RUN ln -s $(/usr/local/bin/fnm which) /usr/local/bin/node && ln -s $(dirname $(/usr/local/bin/fnm which))/npm /usr/local/bin/npm
# 验证
RUN node -v && npm -v
