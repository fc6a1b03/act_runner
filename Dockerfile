FROM gitea/act_runner:nightly
RUN apk add --no-cache nodejs npm curl tar unzip
