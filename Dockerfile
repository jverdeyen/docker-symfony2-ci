FROM ubuntu:14.04
MAINTAINER Joeri Verdeyen <info@jverdeyen.be>

ENV DEBIAN_FRONTEND noninteractive

RUN echo "nameserver 8.8.8.8" >> /etc/resolv.conf
RUN echo "nameserver 8.8.4.4" >> /etc/resolv.conf

# Ensure UTF-8 locale
RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8
RUN dpkg-reconfigure locales

# Install nodejs
RUN apt-get update -qq
RUN apt-get -y -qq install software-properties-common git curl wget git-core subversion mercurial bzr fossil socat

RUN add-apt-repository ppa:chris-lea/node.js
RUN apt-get update
RUN apt-get -y -qq install nodejs

# Install php
RUN apt-get update -qq && apt-get install -y -qq php5-common php-apc php5-gd php5-dev php5-curl php5-cli php5-mysql php5-intl php-pear php5-imap php5-mcrypt php5-ps php5-pspell php5-recode php5-sqlite php5-tidy php5-xmlrpc php5-xsl php5-json php5-xdebug

# Install composer
RUN bash -c "wget http://getcomposer.org/composer.phar && chmod +x composer.phar && mv composer.phar /usr/local/bin/composer"

# Install robo
RUN bash -c "wget http://robo.li/robo.phar && chmod +x robo.phar && mv robo.phar /usr/local/bin/robo"

# Install Ruby and SASS
RUN apt-get -y install ruby
RUN gem install sass --no-ri --no-rdoc

# Install MariaDB
RUN apt-get install -y mariadb-client