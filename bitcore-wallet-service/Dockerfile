FROM node:10
MAINTAINER JohnMa <samoyedsun@gmail.com>

RUN git clone https://github.com/bitpay/bitcore.git /bitcore && \
    mv /bitcore/packages/bitcore-wallet-service /bws && \
    rm -rf /bitcore && \
    rm /bws/package-lock.json

ADD add/config.ts /bws/src/config.ts

WORKDIR /bws

RUN npm install

EXPOSE 3232 3380

CMD npm start && tail -f logs/bws.log
