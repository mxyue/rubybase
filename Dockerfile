FROM ruby:2.3.8

RUN mkdir -p /var/www/yqj_api/shared
# RUN gem sources --remove https://rubygems.org/
# RUn gem source -a https://gems.ruby-china.com
RUN gem install eye

#CMD eye l /var/www/yqj_api/current/config.eye 
COPY app /var/www/app
WORKDIR /var/www/app
RUN bundle install 

RUN cp /etc/apt/sources.list /etc/apt/sources.listbak
COPY sources.list /etc/apt/

RUN apt-get update
RUN apt-get install nano 
RUN apt-get install lsof
RUN apt-get install net-tools 


RUN apt-get -y install locales

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8 

RUN rm -rf /var/www/app
WORKDIR /root

RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime 