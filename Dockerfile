FROM alpine:edge

RUN apk add --no-cache \
    --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing \
    mame-tools

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV CHDMAN_MODE=createcd
ENV INPUT_DIR=/input

VOLUME ["/input"]

ENTRYPOINT ["/entrypoint.sh"]
