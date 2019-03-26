#
# Dockerfile for frp
#

FROM alpine
LABEL maintainer="Ricky Li <cnrickylee@gmail.com>"

RUN set -ex \
 # Build environment setup
 && apk update \
 && apk upgrade \
 && apk add --no-cache --virtual .build-deps \
      git \
      make \
      go \
      musl-dev \
 # Build & install
 && mkdir -p /tmp/repo \
 && cd /tmp/repo \
 && git clone https://github.com/fatedier/frp.git $(go env GOPATH)/src/github.com/fatedier/frp \
 && cd $(go env GOPATH)/src/github.com/fatedier/frp \
 && make \
 && install bin/frpc /usr/local/bin \
 && install bin/frps /usr/local/bin \
 && ls -lh /usr/local/bin \
 && cd / \
 && rm -rf /tmp/repo \
 && rm -rf $(go env GOPATH) \
 && rm -rf $(go env GOCACHE) \
 && go clean \
 && apk del .build-deps \
 && rm -rf /var/cache/apk/*

USER root

