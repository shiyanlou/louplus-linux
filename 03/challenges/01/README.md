# 挑战：测试新项目

## 创建项目目录

```bash
mkdir /home/shiyanlou/test1
mkdir /home/shiyanlou/test2
echo "Hello, this is first" > /home/shiyanlou/test1/index.html
echo "Hello, this is second" > /home/shiyanlou/test2/index.html
```

## 配置目录访问权限

```bash
sudo vim /etc/apache2/apache2.conf
```

```xml
<Directory /home/shiyanlou>
        Options Indexes FollowSymLinks
        AllowOverride None
        Require all granted
</Directory>
```

## 增加监听端口

```bash
echo "Listen 8080" | sudo tee -a /etc/apache2/ports.conf
```

## 配置虚拟机

配置 ops1.shiyanlou.com

```bash
sudo vim /etc/apache2/sites-available/test1.conf
```

```xml
<VirtualHost *:8080>
        ServerName  ops1.shiyalou.com
        DocumentRoot /home/shiyanlou/test1
</VirtualHost>
```

配置 ops2.shiyanlou.com

```bash
sudo vim /etc/apache2/sites-available/test2.conf
```

```xml
<VirtualHost *:8080>
        ServerName  ops2.shiyalou.com
        DocumentRoot /home/shiyanlou/test2
</VirtualHost>
```

## 配置 hosts

```bash
echo "127.0.0.1    ops1.shiyanlou.com ops2.shiyanlou.com" | sudo tee -a /etc/hosts
```

## 加载新配置

```bash
sudo a2ensite test1.conf
sudo a2ensite test2.conf
sudo service apache2 reload
```
