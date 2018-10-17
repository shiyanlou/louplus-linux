# 基础镜像
FROM registry.cn-hangzhou.aliyuncs.com/louplus-linux/ubuntu:14.04

# 禁用交互模式，使得在使用 apt 命令安装软件时无需人工介入
ENV DEBIAN_FRONTEND noninteractive

# 安装相关软件，包括 MySQL、Nginx、PHP-FPM、OpenSSH、Supervisor 等
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

# 下载 Wordpress 安装包
ADD http://labfile.oss-cn-hangzhou.aliyuncs.com/courses/498/wordpress-4.4.2.tar.gz /var/www/wordpress-4.4.2.tar.gz

# 解压 Wordpress 安装包并配置数据库访问参数
RUN cd /var/www && tar zxvf wordpress-4.4.2.tar.gz && rm -rf wordpress-4.4.2.tar.gz ;\
    chown -R www-data:www-data /var/www/wordpress ;\
    sed -i 's/database_name_here/wordpress/g' /var/www/wordpress/wp-config-sample.php ;\
    sed -i 's/username_here/root/g' /var/www/wordpress/wp-config-sample.php ;\
    sed -i 's/password_here/shiyanlou/g' /var/www/wordpress/wp-config-sample.php ;\
    mv /var/www/wordpress/wp-config-sample.php /var/www/wordpress/wp-config.php ;\
    service mysql start && mysql -uroot -pshiyanlou -e "create database wordpress;" ;

# 拷贝 Nginx 和 Supervisor 配置文件到镜像里
COPY nginx.conf /etc/nginx/sites-available/default
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# 对外声明本镜像启动的容器会监听的端口
EXPOSE 80 22

# 启动本镜像的容器时运行 Supervisor，然后由 Supervisor 来管理其它各服务的启动
CMD ["/usr/bin/supervisord"]
