FROM ubuntu:16.04

ENV EBOT_HOME="/ebot" TIMEZONE="Europe/Berlin" PHP_VERSION="5.6.22" PTHREADS_VERSION="2.0.10"

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get clean && \
    apt-get -y install nodejs npm git wget gcc make libxml2-dev autoconf ca-certificates pkg-config && \
    apt-get clean && \
    mkdir /home/install && \
    cd /home/install && \
    wget -q http://de1.php.net/get/php-"${PHP_VERSION}".tar.bz2/from/this/mirror -O php-"${PHP_VERSION}".tar.bz2 && \
    tar -xjf php-"${PHP_VERSION}".tar.bz2 && \
    cd php-"${PHP_VERSION}" && \
    ./configure --prefix /usr/local --with-mysql --enable-maintainer-zts --enable-sockets --with-openssl --with-pdo-mysql && \
    make && \
    make install && \
    cd /home/install && \
    wget -q https://pecl.php.net/get/pthreads-"${PTHREADS_VERSION}".tgz -O pthreads.tgz && \
    tar -xzf pthreads.tgz && \
    cd pthreads-"${PTHREADS_VERSION}" && \
    /usr/local/bin/phpize && \
    ./configure && \
    make && \
    make install && \
    echo 'date.timezone = "${TIMEZONE}"' >> /usr/local/lib/php.ini && \
    echo 'extension=pthreads.so' >> /usr/local/lib/php.ini && \
    /bin/ln -s /usr/bin/nodejs /usr/bin/node && \
    cd /home/install && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php /home/install/composer-setup.php --install-dir=/usr/bin && \
    rm /home/install/composer-setup.php && \
    mkdir "$EBOT_HOME" && \
    git clone https://github.com/deStrO/eBot-CSGO.git "$EBOT_HOME" && \
    cd "$EBOT_HOME" && \
    git checkout "master" && \
    /usr/local/bin/php /usr/bin/composer.phar install && \
    npm install socket.io formidable archiver && \
    cp "$EBOT_HOME"/config/config.ini.smp "$EBOT_HOME"/config/config.ini

VOLUME ["$EBOT_HOME/demos", "$EBOT_HOME/logs"]

EXPOSE 12360 12360/udp 12361/udp

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
