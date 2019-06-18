FROM phpearth/php:7.2

LABEL repository="https://github.com/bvelastegui/phalcon-composer-action"
LABEL homepage="https://github.com/bvelastegui/phalcon-composer-action"
LABEL maintainer="Bryan Velastegui <bryanslvr@gmail.com>"

LABEL com.github.actions.name="Phalcon Composer Action"
LABEL com.github.actions.description="Do Composer commands in your actions."
LABEL com.github.actions.icon="package"
LABEL com.github.actions.color="orange"

COPY --from=composer /usr/bin/composer /usr/bin/composer

ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so

ENV PHALCON_VERSION=3.4.2

RUN apk update && apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community \
	# compiler & tools
	make \
	g++ \
	autoconf \
	file \
	libtool \
	re2c \
	pcre-dev \
	# iconv & gd
	gnu-libiconv-dev \
    php7.2-iconv \
	php7.2-gd \
	php7.2-redis \
	php7.2-dev \
	php7.2-pear \
    php7.2-pdo_mysql \
    php7.2-soap \
	&& \
	# phalcon php
	set -xe && \
	curl -LO https://github.com/phalcon/cphalcon/archive/v${PHALCON_VERSION}.tar.gz && \
	tar xzf v${PHALCON_VERSION}.tar.gz && \
	# compile
	cd cphalcon-${PHALCON_VERSION}/build && ./install && \
	echo "extension=phalcon.so" | tee -a /etc/php/7.2/conf.d/20_phalcon.ini && \
	cd ../.. && rm -rf v${PHALCON_VERSION}.tar.gz cphalcon-${PHALCON_VERSION} \
	&& \
	# clean dev libs
	apk del \
	make \
	g++ \
	autoconf \
	file \
	libtool \
	re2c \
	pcre-dev \
	php7.2-dev \
	php7.2-pear && \
    rm -rf /var/cache/apk/* && \
    set -xe && \
        composer global require hirak/prestissimo && \
        composer clear-cache

COPY composer-entrypoint /usr/local/bin/composer-entrypoint

ENTRYPOINT ["/usr/local/bin/composer-entrypoint"]
