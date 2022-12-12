FROM blacky/base
MAINTAINER Stefano Alberto Russo <stefano.russo@gmail.com>

# Install Apache
RUN apt-get update
RUN apt-get install -y apache2

# Copy conf
COPY supervisord_apache.conf /etc/supervisor/conf.d/
COPY run_Apache.sh /etc/supervisor/conf.d/
RUN chmod 755 /etc/supervisor/conf.d/run_Apache.sh

# Enable required modules
RUN a2enmod rewrite
RUN a2enmod headers
RUN a2enmod env
RUN a2enmod dir
RUN a2enmod mime

# Download OwnCloud
RUN cd /var/www && wget https://download.owncloud.com/server/stable/owncloud-10.11.0.zip
RUN cd /var/www && unzip owncloud-10.11.0.zip && rm owncloud-10.11.0.zip

# Give right permissions
RUN chown -R www-data:www-data /var/www/owncloud

# Install requirements for OwnCloud
#RUN apt-get install -y libapache2-mod-php7.4 php7.4-gd php7.4-json php7.4-mysql php7.4-curl php7.4-intl php7.4-imagick
RUN sudo apt install -y php-fpm php-cgi
RUN sudo apt install -y php
RUN sudo apt install -y php-mysql php-mbstring php-intl php-imagick \
       php-redis php-apcu php-igbinary php-gmp php-bcmath \
       php-curl php-gd php-zip php-imap php-ldap php-bz2 \
       php-ssh2 php-phpseclib php-common php-json php-xml \
       php-dev libsmbclient-dev php-pear




# Install mysql (MariaDB)
RUN apt-get -y install mariadb-server

# Copy conf & create log dir
RUN mkdir /var/run/mysqld
RUN chown mysql:adm /var/run/mysqld
COPY supervisord_mysqld.conf /etc/supervisor/conf.d/
COPY run_MySQL.sh /etc/supervisor/conf.d/
RUN chmod 755 /etc/supervisor/conf.d/run_MySQL.sh

# Setup mysql data dir
RUN mv /var/lib/mysql /var/lib/mysql_or
RUN ln -s /mnt/md1/var/lib/mysql /var/lib/mysql

# Copy conf for ownCloud on Apache
COPY 001-owncloud.conf /etc/apache2/sites-available/ 
RUN ln -s /etc/apache2/sites-available/001-owncloud.conf /etc/apache2/sites-enabled/001-owncloud.conf

# Prestartup
COPY prestartup-owncloud.sh /prestartup/

# Apache php
RUN apt-get install -y libapache2-mod-php
RUN a2enmod php7.4

# Owncloud conf
COPY config.php /var/www/owncloud/config/
RUN chown 33:33 /var/www/owncloud/config/config.php

# Data & apps dir
#RUN mv /var/www/owncloud/data /var/www/owncloud/data_vanilla
RUN ln -s /mnt/md1/owncloud_data /var/www/owncloud/data 
RUN mkdir /var/www/owncloud/apps-external

# Finally make it the default stuff
RUN mv /var/www/html /var/www/html_or
RUN mv /var/www/owncloud /var/www/html
