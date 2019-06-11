FROM ruby:2.5
MAINTAINER mazhao <samoyedsun@gmail.com>

WORKDIR /root
RUN gem install jekyll bundler \
    && jekyll new app \
    && sed '/tzinfo-data/d' app/Gemfile > Gemtmp\
    && mv Gemtmp app/Gemfile \
    && echo "bundle install" > start.sh \
    && echo "bundle exec jekyll build" >> start.sh \
    && echo "exec bundle exec jekyll serve -w --host=0.0.0.0" >> start.sh

WORKDIR /root/app
CMD ["bash", "../start.sh"]
