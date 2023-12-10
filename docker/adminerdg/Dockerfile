FROM php:7.4-alpine

LABEL maintainer="Martin Antoš <mafikes@gmail.com>"

RUN	echo "upload_max_filesize = 128M" >> /usr/local/etc/php/conf.d/0-upload_large_dumps.ini \
&&	echo "post_max_size = 128M" >> /usr/local/etc/php/conf.d/0-upload_large_dumps.ini \
&&	echo "memory_limit = 1G" >> /usr/local/etc/php/conf.d/0-upload_large_dumps.ini \
&&	echo "max_execution_time = 600" >> /usr/local/etc/php/conf.d/0-upload_large_dumps.ini \
&&	echo "max_input_vars = 5000" >> /usr/local/etc/php/conf.d/0-upload_large_dumps.ini

STOPSIGNAL SIGINT

RUN	addgroup -S adminer \
&&	adduser -S -G adminer adminer \
&&	mkdir -p /var/www \
&&	chown -R adminer:adminer /var/www

WORKDIR /var/www

RUN	set -x \
    &&	apk add --no-cache --virtual .build-deps \
      postgresql-dev \
      sqlite-dev \
      unixodbc-dev \
      freetds-dev \
    &&	docker-php-ext-configure pdo_odbc --with-pdo-odbc=unixODBC,/usr \
    &&	docker-php-ext-install \
      mysqli \
      pdo_pgsql \
      pdo_sqlite \
      pdo_odbc \
      pdo_dblib

ARG ADMINER_DG_VERSION
USER	adminer
RUN curl -L https://github.com/dg/adminer-custom/archive/v$ADMINER_DG_VERSION.tar.gz > /var/www/adminer.tgz && \
    tar zxvf /var/www/adminer.tgz --strip-components=1 -C /var/www && \
    rm /var/www/adminer.tgz

USER	adminer
CMD	[ "php", "-S", "[::]:8080", "-t", "/var/www" ]

EXPOSE 8080
