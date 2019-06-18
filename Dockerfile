FROM bvelastegui/phalcon:3.4.2-cli

LABEL repository="https://github.com/bvelastegui/phalcon-composer-action"
LABEL homepage="https://github.com/bvelastegui/phalcon-composer-action"
LABEL maintainer="Bryan Velastegui <bryanslvr@gmail.com>"

LABEL com.github.actions.name="Phalcon Composer Action"
LABEL com.github.actions.description="Do Composer commands in your actions."
LABEL com.github.actions.icon="package"
LABEL com.github.actions.color="orange"

RUN apk update && apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community \
    composer && \
    git && \
    rm -rf /var/cache/apk/* && \
    set -xe && \
        composer global require hirak/prestissimo && \
        composer clear-cache

COPY composer-entrypoint /usr/local/bin/composer-entrypoint

ENTRYPOINT ["/usr/local/bin/composer-entrypoint"]
