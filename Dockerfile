ARG VERSION=0.2.12
FROM gitea/act_runner:${VERSION}
RUN apk add --no-cache docker-cli docker-buildx-plugin docker-compose-plugin git jq curl wget bash nodejs tar xz unzip zip
