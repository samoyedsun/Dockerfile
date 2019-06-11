FROM samoyedsun/ssproxy
MAINTAINER mazhao <samoyedsun@gmail.com>

ENV SS_PORT 28911
ENV SS_PASS helloworld@28911DD!
ENV SS_MODE rc4-md5
ENV SS_PLUGIN obfs-server
ENV SS_PLUGIN_OPTS obfs=http

WORKDIR /root
RUN git clone https://github.com/shadowsocks/simple-obfs.git \
    && pushd simple-obfs \
    && git submodule update --init --recursive \
    && ./autogen.sh \
    && ./configure && make \
    && make install \
    && popd && rm -rf simple-obfs
CMD ss-server -s $SS_HOST -p $SS_PORT -k $SS_PASS -m $SS_MODE -u --fast-open --plugin $SS_PLUGIN --plugin-opts $SS_PLUGIN_OPTS
