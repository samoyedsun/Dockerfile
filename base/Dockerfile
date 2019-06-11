FROM centos
MAINTAINER mazhao <samoyedsun@gmail.com>

ENV FILEBEAT_VERSION filebeat-6.4.1-linux-x86_64
ENV FILEBEAT_URL https://artifacts.elastic.co/downloads/beats/filebeat/${FILEBEAT_VERSION}.tar.gz
ENV PHP_VERSION php-7.2.15
ENV PHP_URL http://cn2.php.net/distributions/${PHP_VERSION}.tar.bz2
ENV PHP_PREFIX /usr/local/php
ENV PHP_EXTDIR ${PHP_VERSION}/ext
ENV PHPEXT_MBSTRING ${PHP_EXTDIR}/mbstring
ENV PHPEXT_OPENSSL ${PHP_EXTDIR}/openssl
ENV PHPEXT_ZIP ${PHP_EXTDIR}/zip
ENV PHPEXT_GD ${PHP_EXTDIR}/gd
ENV PHPREDIS_VERSION phpredis-4.2.0RC3
ENV PHPREDIS_URL https://github.com/phpredis/phpredis/archive/4.2.0RC3.tar.gz
ENV PHPEXT_PHPREDIS ${PHP_EXTDIR}/${PHPREDIS_VERSION}
ENV PHPEXT_CURL ${PHP_EXTDIR}/curl
ENV PHPEXT_PCNTL ${PHP_EXTDIR}/pcntl
ENV PHPSWOOLE_VERSION swoole-src-4.1.0-beta.2
ENV PHPSWOOLE_URL https://github.com/swoole/swoole-src/archive/v4.1.0-beta.2.tar.gz
ENV PHPEXT_SWOOLE ${PHP_EXTDIR}/${PHPSWOOLE_VERSION}
ENV LUAJIT_VERSION LuaJIT-2.0.5
ENV LUAJIT_URL http://luajit.org/download/${LUAJIT_VERSION}.tar.gz
ENV NGINX_DEVEL_KIT_VERSION 0.3.0
ENV NGINX_DEVEL_KIT_URL https://github.com/simplresty/ngx_devel_kit/archive/v${NGINX_DEVEL_KIT_VERSION}.tar.gz
ENV NGINX_LUA_MODULE_VERSION 0.10.13
ENV NGINX_LUA_MODULE_URL https://github.com/openresty/lua-nginx-module/archive/v${NGINX_LUA_MODULE_VERSION}.tar.gz
ENV NGINX_VERSION nginx-1.15.3
ENV NGINX_URL http://nginx.org/download/${NGINX_VERSION}.tar.gz
ENV NGINX_PREFIX /usr/local/nginx
ENV COMPOSER_URL https://getcomposer.org/download/1.7.0-RC/composer.phar
ENV WAIT_FOR_IT_URL https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh
ENV PHP_INI_URL https://raw.githubusercontent.com/samoyedsun/Dockerfile/master/base/php.ini
ENV NODE_VERSION v10.11.0
ENV NODE_URL https://nodejs.org/download/release/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.gz
ENV LARAVEL_VERSION 5.6.*
ENV PROJECT_DIR_BID /usr/local/nginx/html/bid/src
ENV PROJECT_DIR_APP /app
ENV RELY_URL_DIR_BID https://raw.githubusercontent.com/samoyedsun/Dockerfile/master/base/rely-bid
ENV RELY_URL_DIR_APP https://raw.githubusercontent.com/samoyedsun/Dockerfile/master/base/rely-app
ENV PATH=${NGINX_PREFIX}/sbin:${PHP_PREFIX}/bin:${PHP_PREFIX}/sbin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

WORKDIR /root
RUN yum install -y epel-release
RUN yum install gcc-c++ openssl-devel gcc wget libxml2-devel unzip autoconf make libcurl-devel re2c file cronie bison which \
    vim libjpeg libjpeg-devel libpng libpng-devel bzip2 -y
RUN cp /usr/share/zoneinfo/Asia/Bangkok /etc/localtime
RUN wget -O /usr/local/bin/composer ${COMPOSER_URL} && chmod +x /usr/local/bin/composer
RUN wget -O wait-for-it.sh ${WAIT_FOR_IT_URL} && chmod +x wait-for-it.sh
RUN wget -O ${PHP_VERSION}.tar.bz2 ${PHP_URL} && tar -jxvf ${PHP_VERSION}.tar.bz2 && rm -f ${PHP_VERSION}.tar.bz2
RUN wget -O ${PHPREDIS_VERSION}.tar.gz ${PHPREDIS_URL} && tar -zxvf ${PHPREDIS_VERSION}.tar.gz && rm -f ${PHPREDIS_VERSION}.tar.gz
RUN wget -O ${PHPSWOOLE_VERSION}.tar.gz ${PHPSWOOLE_URL} && tar -zxvf ${PHPSWOOLE_VERSION}.tar.gz && rm -f ${PHPSWOOLE_VERSION}.tar.gz
    #  安装php
RUN pushd ${PHP_VERSION} && ./configure --prefix=${PHP_PREFIX} \
                                            --with-zlib \
                                            --with-mysqli=mysqlnd \
                                            --with-pdo-mysql=mysqlnd \
                                            --enable-mysqlnd \
                                            --enable-fpm && make install && popd && \
    pushd ${PHPEXT_MBSTRING} && phpize && ./configure && make install && popd && \
    pushd ${PHPEXT_OPENSSL} && mv config0.m4 config.m4 && phpize && ./configure && make install && popd && \
    pushd ${PHPEXT_ZIP} && phpize && ./configure && make install && popd && \
    pushd ${PHPEXT_GD} && phpize && ./configure --with-png-dir --with-jpeg-dir && make install && popd && \
    pushd ${PHP_EXTDIR} && mv $HOME/${PHPREDIS_VERSION} ./ && popd && \
    pushd ${PHPEXT_PHPREDIS} && phpize && ./configure && make install && popd && \
    pushd ${PHPEXT_CURL} && phpize && ./configure && make install && popd && \
    pushd ${PHPEXT_PCNTL} && phpize && ./configure && make install && popd && \
    pushd ${PHP_EXTDIR} && mv $HOME/${PHPSWOOLE_VERSION} ./ && popd && \
    pushd ${PHPEXT_SWOOLE} && phpize && ./configure && make install && popd && \
    wget -O /usr/local/php/lib/php.ini ${PHP_INI_URL} && \
    rm -rf ${PHP_VERSION} 
    #  安装filebeat
RUN wget -O ${FILEBEAT_VERSION}.tar.gz ${FILEBEAT_URL} && tar -zxvf ${FILEBEAT_VERSION}.tar.gz && rm -f ${FILEBEAT_VERSION}.tar.gz && \
    mv ${FILEBEAT_VERSION} /opt/filebeat
    #  安装luajit
RUN wget -O ${LUAJIT_VERSION}.tar.gz ${LUAJIT_URL} && tar -zxvf ${LUAJIT_VERSION}.tar.gz && rm -f ${LUAJIT_VERSION}.tar.gz && \
    pushd ${LUAJIT_VERSION} && make install prefix=/usr/local/luajit && popd && \
    ln -s /usr/local/lib/libluajit-5.1.so.2 /lib64/libluajit-5.1.so.2 && \
    rm -rf ${LUAJIT_VERSION}
    #  安装nginx
RUN wget -O v${NGINX_LUA_MODULE_VERSION}.tar.gz ${NGINX_LUA_MODULE_URL} && tar -zxvf v${NGINX_LUA_MODULE_VERSION}.tar.gz && rm -f v${NGINX_LUA_MODULE_VERSION}.tar.gz && \
    wget -O v${NGINX_DEVEL_KIT_VERSION}.tar.gz ${NGINX_DEVEL_KIT_URL} && tar -zxvf v${NGINX_DEVEL_KIT_VERSION}.tar.gz && rm -f v${NGINX_DEVEL_KIT_VERSION}.tar.gz && \
    wget -O ${NGINX_VERSION}.tar.gz ${NGINX_URL} && tar -zxvf ${NGINX_VERSION}.tar.gz && rm -f ${NGINX_VERSION}.tar.gz && \
    pushd ${NGINX_VERSION} && ./configure --prefix=${NGINX_PREFIX} \
                                            --with-http_ssl_module \
                                            --with-http_v2_module \
                                            --add-module=../ngx_devel_kit-${NGINX_DEVEL_KIT_VERSION}/ \
                                            --add-module=../lua-nginx-module-${NGINX_LUA_MODULE_VERSION}/ && \
    make install && popd && \
    rm -rf ${NGINX_VERSION} ngx_devel_kit-${NGINX_DEVEL_KIT_VERSION} lua-nginx-module-${NGINX_LUA_MODULE_VERSION}
    #  安装nodejs
RUN wget -O node-${NODE_VERSION}-linux-x64.tar.gz ${NODE_URL} && \
    tar --strip-components 1 -xzvf node-${NODE_VERSION}-linux-x64.tar.gz -C /usr/local/ && \
    rm node-${NODE_VERSION}-linux-x64.tar.gz
    #  安装laravel项目依赖
RUN echo "begin change!"
RUN mkdir -p ${PROJECT_DIR_BID} && \
    composer create-project --prefer-dist laravel/laravel ${PROJECT_DIR_BID} ${LARAVEL_VERSION} && \
    rm -rf ${PROJECT_DIR_BID}/vendor && \
    rm -f ${PROJECT_DIR_BID}/composer.* && \
    wget -O ${PROJECT_DIR_BID}/composer.json ${RELY_URL_DIR_BID}/composer.json && \
    pushd ${PROJECT_DIR_BID} && composer install && popd && \
    rm -rf ./.composer
    #  安装nodejs项目依赖
RUN mkdir ${PROJECT_DIR_APP} && \
    wget -O ${PROJECT_DIR_APP}/package.json ${RELY_URL_DIR_APP}/package.json && \
    pushd ${PROJECT_DIR_APP} && npm install && popd
