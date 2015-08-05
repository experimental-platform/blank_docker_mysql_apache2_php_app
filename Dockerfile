

FROM ubuntu:14.04
MAINTAINER Silvano Wegener <silvano@protonet.info>

ENV DEBIAN_FRONTEND noninteractive 

RUN apt-get update
RUN apt-get -y upgrade

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \
apache2 \
libapache2-mod-php5 \
php5-mysql \
php5-gd \
php-pear \
php-apc \
php5-curl \
curl \
lynx-cur \
mysql-server-core-5.6 \
mysql-client-5.6 \
php5 \
screen \
ssh \
vim


### APACHE CONFIG ###############################
RUN a2enmod php5
RUN a2enmod rewrite
ENV APACHE_RUN_USER root
ENV APACHE_RUN_GROUP root
ENV APACHE_LOG_DIR /data/var/log/apache2
ENV APACHE_LOCK_DIR /data/var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ADD apache/apache.conf /etc/apache2/sites-enabled/000-default.conf
ADD apache/index.php /var/www/index.php


### MYSQL CONFIG ###############################
# password of root user is "geheim"
ADD sql/my.cnf /etc/mysql/my.cnf
ADD sql/conf.d /etc/mysql/conf.d
ADD sql/mysql /data/mysql


### PHP CONFIG ###############################
ADD php/php.ini /etc/php5/apache2/php.ini


ADD startup.sh /startup.sh

VOLUME ["/data"]
EXPOSE 80
CMD /startup.sh