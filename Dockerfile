ARG VERSION=0.2.12
FROM gitea/act_runner:${VERSION}
# 安装必要工具
RUN apk add --no-cache bash curl tar unzip jq
# 下载并安装fnm
RUN curl -fsSL https://github.com/Schniz/fnm/releases/latest/download/fnm-linux.zip -o /tmp/fnm.zip \
 && unzip /tmp/fnm.zip -d /usr/local/bin && rm /tmp/fnm.zip && chmod +x /usr/local/bin/fnm
ENV FNM_DIR=/root/.fnm
SHELL ["/bin/bash", "-c"]
RUN source <(fnm env --shell=bash) \
 && LATEST=$(fnm ls-remote --latest) \
 && fnm install "$LATEST" && fnm use "$LATEST" \
 && ln -sf "$(fnm which)" /usr/local/bin/node \
 && ln -sf "$(dirname "$(fnm which)")"/npm /usr/local/bin/npm \
 && ln -sf "$(dirname "$(fnm which)")"/npx /usr/local/bin/npx
# 验证
RUN node -v && npm -v
