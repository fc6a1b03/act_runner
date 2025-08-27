ARG DEPEND=
ARG VERSION=v0.2.12
FROM gitea/act_runner:${VERSION}
RUN echo "DEPEND=${DEPEND}" && echo "${DEPEND}" | xargs apk add --no-cache
