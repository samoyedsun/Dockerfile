FROM centos
MAINTAINER mazhao <samoyedsun@gmail.com>

RUN yum install make \
    autoconf \
    gcc \
    readline-devel \
    libcurl-devel \
    sudo \
    vim \
    git \
    net-tools -y
RUN groupadd skynet
RUN useradd -g skynet -m skynet
RUN echo "%skynet ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/skynet

USER skynet
WORKDIR /home/skynet
