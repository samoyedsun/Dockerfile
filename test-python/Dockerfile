FROM python:3.7.0
MAINTAINER mazhao "mz@ddpkcc.com"

ENV REQUEST_URL http://www.baidu.com
ENV THREAD_NUM 5
ENV PROGRAM_URL https://raw.githubusercontent.com/samoyedsun/bash/master/samoyedsun/test-pressure.py

WORKDIR /root
RUN pip3.7 install requests && \
    wget -q -O - ${PROGRAM_URL} > start.py

CMD ["python3.7", "start.py"]
