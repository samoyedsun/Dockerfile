FROM centos
MAINTAINER mazhao <samoyedsun@gmail.com>

RUN yum install cronie -y

RUN echo '#!/bin/bash' > /root/watch_table.sh
RUN echo 'step=2' >> /root/watch_table.sh
RUN echo 'for (( i = 0; i < 60; i=(i+step) )); do' >> /root/watch_table.sh
RUN echo '    curl http://gamedev.gxbsy.com:8201/game/watch_table' >> /root/watch_table.sh
RUN echo '    sleep $step' >> /root/watch_table.sh
RUN echo 'done' >> /root/watch_table.sh
RUN echo 'exit 0' >> /root/watch_table.sh

RUN echo 'SHELL=/bin/bash' > /etc/crontab
RUN echo 'PATH=/sbin:/bin:/usr/sbin:/usr/bin' >> /etc/crontab
RUN echo 'MAILTO=root' >> /etc/crontab
RUN echo '*/1 * * * * bash /root/watch_table.sh >> /var/log/watch_table.log 2>&1' >> /etc/crontab

RUN crontab /etc/crontab 
CMD ["crond", "-n"]
