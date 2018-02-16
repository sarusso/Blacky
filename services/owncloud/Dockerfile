FROM blackymetabox/base
MAINTAINER Stefano Alberto Russo <stefano.russo@gmail.com>

###################################
#
#            A P A C H E
#
###################################

# Install Apache
RUN apt-get update #20161005
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

# Download ownCloud
RUN cd /var/www && wget https://download.owncloud.org/community/owncloud-9.1.1.zip
RUN cd /var/www && unzip owncloud-9.1.1.zip && rm owncloud-9.1.1.zip

# Copy onwCloud conf
COPY config.php /var/www/owncloud/config/

# Give right permissions
RUN chown -R www-data:www-data /var/www/owncloud

# Install requirements for OwnCloud
RUN apt-get install -y libapache2-mod-php5
RUN apt-get install -y php5-gd php5-json php5-mysql php5-curl
RUN apt-get install -y php5-intl php5-mcrypt php5-imagick

# Install mysql (MariaDB)
RUN apt-get -y install mariadb-server

# Copy conf & creta log dir
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

