ARG DEPEND=""
ARG VERSION=v0.2.12
FROM gitea/act_runner:${VERSION}
RUN apk add --no-cache $DEPEND
