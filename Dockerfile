# pull base image
FROM centos:7

# locale & timezone
RUN sed -i -e "s/LANG=\"en_US.UTF-8\"/LANG=\"ja_JP.UTF-8\"/g" /etc/locale.conf && \
    cp -p /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# system update
RUN yum -y update

# install repository
RUN yum install -y epel-release && \
    rpm -Uvh http://www.city-fan.org/ftp/contrib/yum-repo/city-fan.org-release-1-13.rhel7.noarch.rpm && \
    rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm

# install packages
RUN yum install -y \
        #  Tools
        less \
        libcurl \
        net-tools \
    yum install -y --enablerepo=epel,remi \
        # httpd
        httpd \
        mod_ssl && \
    yum install -y --enablerepo=remi-php70 \
        php \
        php-devel \
        php-embedded \
        php-mcrypt \
        php-mbstring \
        php-gd \
        php-mysql \
        php-pdo \
        php-xml \
        php-pecl-apcu \
        php-pecl-zendopcache && \
    # cache cleaning
    yum clean all

# httpd
COPY ./conf/httpd.conf /etc/httpd/conf/httpd.conf
COPY ./conf/00-mpm.conf /etc/httpd/conf.modules.d/00-mpm.conf

# php
COPY ./conf/php.ini /etc/php.ini
COPY ./conf/init/info.php /var/www/html/info.php

# document root
RUN groupadd --gid 1000 www-data && \
    useradd www-data --uid 1000 --gid 1000 && \
    chmod -R 755 /var/www && \
    chown -R www-data:www-data /var/www

# listen port
EXPOSE 80
EXPOSE 443

# startup
ENTRYPOINT {"/usr/sbin/httpd","-DFOREGROUND"}
