FROM centos
MAINTAINER mazhao <samoyedsun@gmail.com>

ENV LIBSODIUM_VER 1.0.16
ENV MBEDTLS_VER 2.6.0

ENV LIBSODIUM_URL https://download.libsodium.org/libsodium/releases/libsodium-$LIBSODIUM_VER.tar.gz
ENV MBEDTLS_URL https://tls.mbed.org/download/mbedtls-$MBEDTLS_VER-gpl.tgz
ENV SHADOWSOCKS_URL https://github.com/shadowsocks/shadowsocks-libev.git

ENV SS_HOST 0.0.0.0
ENV SS_PORT 13003
ENV SS_PASS 123
ENV SS_MODE aes-256-cfb

WORKDIR /root
RUN yum install epel-release -y 
RUN yum install git vim wget net-tools gcc automake make pcre-devel \
    asciidoc gettext autoconf libtool libtool-libs libtool-ltdl-devel* \
    xmlto udns-devel libev-devel cpp file mbedtls-devel openssl-devel \
    c-ares-devel privoxy -y \
    #  下载并安装依赖libsodium
    && wget $LIBSODIUM_URL -O ./libsodium-$LIBSODIUM_VER.tar.gz \
    && tar -zxvf libsodium-$LIBSODIUM_VER.tar.gz \
    && pushd libsodium-$LIBSODIUM_VER \
    && ./configure --prefix=/usr && make && make install \
    && popd && ldconfig \
    && rm -rf libsodium-$LIBSODIUM_VER libsodium-$LIBSODIUM_VER.tar.gz \
    #  下载并安装依赖mbedtls
    && wget $MBEDTLS_URL -O ./mbedtls-$MBEDTLS_VER-gpl.tgz \
    && tar -zxvf mbedtls-$MBEDTLS_VER-gpl.tgz \
    && pushd mbedtls-$MBEDTLS_VER \
    && make SHARED=1 CFLAGS=-fPIC && make install \
    && popd && ldconfig \
    && rm -rf mbedtls-$MBEDTLS_VER mbedtls-$MBEDTLS_VER-gpl.tgz \
    #  下载并安装shadowsocks
    && git clone $SHADOWSOCKS_URL "shadowsocks-libev" \
    && pushd shadowsocks-libev \
    && git submodule update --init --recursive \
    && ./autogen.sh && ./configure --prefix=/usr && make && make install \
    && popd && ldconfig \
    && ln -sf /usr/local/lib/libmbedcrypto.so.0 /usr/lib64/libmbedcrypto.so.0 \
    && rm -rf shadowsocks-libev
CMD ss-server -s $SS_HOST -p $SS_PORT -k $SS_PASS -m $SS_MODE -u --fast-open
