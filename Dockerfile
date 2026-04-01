FROM alpine:3.21

RUN apk add --no-cache mame-tools

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV CHDMAN_MODE=createcd
ENV INPUT_DIR=/input

VOLUME ["/input"]

ENTRYPOINT ["/entrypoint.sh"]
