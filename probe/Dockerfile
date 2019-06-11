FROM samoyedsun/base:v8
MAINTAINER mazhao "mz@ddpkcc.com"

ENV WAIT_TIME_SECOND 60

WORKDIR /root
RUN echo "ok" > /usr/local/nginx/html/index.html && \
    echo "for((i=1;i<=\${WAIT_TIME_SECOND};i++)); do sleep 1; echo \"start count down: \"\$[WAIT_TIME_SECOND-i]; done" > start.sh && \
    echo "exec nginx -g \"daemon off;\"" >> start.sh

EXPOSE 80

CMD ["bash", "start.sh"]
