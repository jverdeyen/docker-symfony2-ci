FROM ubuntu:14.04
MAINTAINER Joeri Verdeyen <info@jverdeyen.be>

ENV DEBIAN_FRONTEND noninteractive

# Ensure UTF-8 locale
RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8
RUN dpkg-reconfigure locales

# Install nodejs
RUN apt-get update -qq
RUN apt-get -y -qq install software-properties-common git curl wget
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
RUN gem install sass

# Install MariaDB
RUN apt-get install -y mariadb-server mariadb-client

RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

# Install starting script
ADD ./start-database.sh /usr/local/bin/start-database.sh
RUN chmod +x /usr/local/bin/start-database.sh

EXPOSE 3306

CMD ["/usr/local/bin/start-database.sh"]