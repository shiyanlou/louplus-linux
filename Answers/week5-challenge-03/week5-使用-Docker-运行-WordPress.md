# 挑战：使用 Docker 运行 WordPress

nginx.conf 文件内容如下所示：

```conf
server {
    listen *:80;
    server_name localhost;

    # 网站根目录及首页配置
    root /var/www/wordpress;
    index index.html index.php;

    # 处理静态页面请求
    location / {
        try_files $uri $uri/ =404;
    }

    # 处理动态 PHP 页面请求
    location ~ \.php$ {
        # 检查请求的 PHP 文件是否存在，防止恶意 PHP 代码被执行
        fastcgi_split_path_info ^(.+?\.php)(/.*)$;
        if (!-f $document_root$fastcgi_script_name) {
            return 404;
        }

        # 缓解 https://httpoxy.org/ 攻击
        fastcgi_param HTTP_PROXY "";

        # 转发请求给 PHP-FPM 服务，由 PHP-FPM 来执行 PHP 脚本
        fastcgi_pass unix:/var/run/php5-fpm.sock;
        fastcgi_index index.php;

        # 包含内置的 FastCGI 参数
        include fastcgi_params;
    }
}
```

supervisord.conf 文件内容如下所示：

```conf
[supervisord]
# 在容器里放在前台运行，否则容器会立即运行结束
nodaemon=true

[program:php5-fpm]
command=/usr/sbin/php5-fpm -c /etc/php5/fpm
autorstart=true

[program:mysqld]
command=/usr/bin/mysqld_safe
autorstart=true

[program:nginx]
command=/usr/sbin/nginx
autorstart=true

[program:ssh]
command=/usr/sbin/sshd -D
autorstart=true
```

Dockerfile 文件内容如下所示：

```dockerfile
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
```

完整命令如下所示：

```bash
# 创建一个子目录来构建镜像，以避免发送大量无关文件给 Docker 服务
mkdir -p challenge && cd challenge

# 创建相关文件，包括 Dockerfile、nginx.conf、supervisord.conf

# 构建镜像
docker build -t syl-wordpress .

# 运行镜像
docker run -d -p 8080:80 --name syl-wordpress syl-wordpress:latest

# 访问 Wordpress
curl http://localhost:8080
```
