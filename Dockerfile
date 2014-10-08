FROM ubuntu:14.04
MAINTAINER Joeri Verdeyen <info@jverdeyen.be>

ENV DEBIAN_FRONTEND noninteractive

USER root

# Install nodejs
RUN apt-get update -qq
RUN apt-get -y -qq install software-properties-common git
RUN add-apt-repository ppa:chris-lea/node.js
RUN apt-get update
RUN apt-get -y -qq install nodejs

# Install php
RUN apt-get update -qq && apt-get install -y -qq git curl wget php5-common php-apc php5-gd php5-dev php5-curl php5-cli php5-mysql php5-intl php-pear php5-imap php5-mcrypt php5-ps php5-pspell php5-recode php5-sqlite php5-tidy php5-xmlrpc php5-xsl php5-json php5-xdebug

# Install composer
RUN bash -c "wget http://getcomposer.org/composer.phar && chmod +x composer.phar && mv composer.phar /usr/local/bin/composer"

# Install robo
RUN bash -c "wget http://robo.li/robo.phar && chmod +x robo.phar && mv robo.phar /usr/local/bin/robo "
