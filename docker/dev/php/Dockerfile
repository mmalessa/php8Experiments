ARG BASE_IMAGE
FROM ${BASE_IMAGE}

ARG COMPOSER_VERSION=2.0.7

RUN apt-get update && \
    apt-get install -y \
    libzip-dev \
    libcurl4-openssl-dev pkg-config libssl-dev \
    libxml2-dev \
    unzip librabbitmq-dev \
    git vim

RUN curl -sS https://getcomposer.org/installer | \
    php -- --install-dir=/usr/local/bin --filename=composer --version=$COMPOSER_VERSION

RUN docker-php-ext-install sockets bcmath zip \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && rm -rf /var/lib/apt/lists/* \
    && pecl config-set php_ini /usr/local/etc/php/conf.d/over.ini

# # php-amqp for php8 workaround
# RUN docker-php-source extract && \
#     mkdir /usr/src/php/ext/amqp && \
#     curl -L https://github.com/php-amqp/php-amqp/archive/master.tar.gz | tar -xzC /usr/src/php/ext/amqp --strip-components=1 && \
#     docker-php-ext-install amqp

RUN cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini && \
    rm -rf /var/lib/apt/lists/* && \
    pecl config-set php_ini /usr/local/etc/php/conf.d/over.ini

RUN echo "su - developer" > /root/.bashrc
ARG DEVELOPER_UID
RUN useradd -m -s /bin/bash -u ${DEVELOPER_UID} developer
USER developer
WORKDIR "/application"
