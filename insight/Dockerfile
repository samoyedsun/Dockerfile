FROM node:4
MAINTAINER mazhao <samoyedsun@gmail.com>


WORKDIR /
RUN apt update -y && \
	apt install libzmq3-dev -y && \
    	npm install -g bitcore && \
    	bitcore create blockchain-node

WORKDIR /blockchain-node
RUN bitcore install insight-api insight-ui && \
	sed -i "$(grep -n "async" node_modules/insight-api/package.json |cut -f1 -d:)c $(grep -r "async" node_modules/bitcore-node/package.json)" node_modules/insight-api/package.json && \
	cd node_modules/insight-api && \
	npm install && \
	rm -rf node_modules/bitcore-lib && \
	cd ../../

CMD ["bitcored"]
