FROM ubuntu:14.04

MAINTAINER louplus@shiyanlou.com

# disable apt interactive mode
ENV DEBIAN_FRONTEND noninteractive

RUN mkdir /var/www ;\
    mkdir /var/run/sshd ;\
    echo "deb http://mirrors.aliyun.com/ubuntu/ trusty main universe" > /etc/apt/sources.list ;\
    echo "mysql-server mysql-server/root_password password shiyanlou" | debconf-set-selections ;\
    echo "mysql-server mysql-server/root_password_again password shiyanlou" | debconf-set-selections ;\
    apt-get -yqq update ;\
    apt-get -y install nginx supervisor wget php5-fpm php5-mysql mysql-server mysql-client openssh-server openssh-client ;\
    echo "daemon off;" >> /etc/nginx/nginx.conf ;\
    echo 'root:shiyanlou' | chpasswd ;\
    sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config ;


ADD http://labfile.oss-cn-hangzhou.aliyuncs.com/courses/498/wordpress-4.4.2.tar.gz /var/www/wordpress-4.4.2.tar.gz


RUN cd /var/www && tar zxvf wordpress-4.4.2.tar.gz && rm -rf wordpress-4.4.2.tar.gz ;\
    chown -R www-data:www-data /var/www/wordpress ;\
    sed -i 's/database_name_here/wordpress/g' /var/www/wordpress/wp-config-sample.php ;\
    sed -i 's/username_here/root/g' /var/www/wordpress/wp-config-sample.php ;\
    sed -i 's/password_here/shiyanlou/g' /var/www/wordpress/wp-config-sample.php ;\
    mv /var/www/wordpress/wp-config-sample.php /var/www/wordpress/wp-config.php ;\
    service mysql start && mysql -uroot -pshiyanlou -e "create database wordpress;" ;


EXPOSE 80 22

COPY nginx.conf /etc/nginx/sites-available/default
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord"]
