FROM jenkinsci/blueocean
MAINTAINER mazhao <samoyedsun@gmail.com>

USER root
RUN apk -v --update add python py-pip groff less mailcap sudo && \
    pip install --upgrade pip && \
    pip install --upgrade awscli==1.16.60 s3cmd==2.0.1 python-magic && \
    apk -v --purge del py-pip && \
    rm /var/cache/apk/* && \
    curl -o /usr/bin/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/linux/amd64/aws-iam-authenticator && \
    chmod +x /usr/bin/aws-iam-authenticator && \
    curl -o /usr/bin/kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/linux/amd64/kubectl && \
    chmod +x /usr/bin/kubectl && \
    echo "%jenkins ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/jenkins
USER jenkins
