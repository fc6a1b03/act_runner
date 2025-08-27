ARG DEPEND_INFO=
ARG VERSION=v0.2.12
FROM gitea/act_runner:${VERSION}
RUN echo "DEPEND_INFO=${DEPEND_INFO}" && echo "${DEPEND_INFO}" | xargs apk add --no-cache
