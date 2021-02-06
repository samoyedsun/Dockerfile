FROM node:4.3.1
MAINTAINER mazhao <samoyedsun@gmail.com>

WORKDIR /
RUN apt install libzmq3-dev -y &&
    npm install -g bitcore &&
    bitcore create blockchain-node

WORKDIR /blockchain-node
RUN bitcore install insight-api insight-ui

CMD ["bitcored"]
