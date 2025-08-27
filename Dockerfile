ARG VERSION=v0.2.12
ARG DEPEND=nodejs npm curl tar unzip
FROM gitea/act_runner:${VERSION}
RUN apk add --no-cache ${DEPEND}
