1. 创建项目目录

```
mkdir /home/shiyanlou/test1
echo "Hello,this is first" > /home/shiyanlou/test1/index.html
echo "Hello,this is second" > /home/shiyanlou/test2/index.html
```

2. 修改目录访问权限

```
vim /etc/apache2/apache2.conf
```

添加以下内容

```
<Directory /home/shiyanlou>
        Options Indexes FollowSymLinks
        AllowOverride None
        Require all granted
</Directory>
```

3. 增加监听端口

```
echo "Listen 8080"   >> /etc/apach2/ports.conf
```

4. 创建虚拟机配置文件

```
vim /etc/apache2/sites-available/test1.conf
```

添加下面的内容

```
<VirtualHost *:8080>
        ServerName  ops1.shiyanou.com
        DocumentRoot /home/shiyanlou/test1
</VirtualHost>
```

配置 ops2.shiyanlou.com

```
vim /etc/apache2/sites-available/test2.conf
```

添加下面的内容

```
<VirtualHost *:8080>
        ServerName  ops2.shiyanou.com
        DocumentRoot /home/shiyanlou/test2
</VirtualHost>
```

5. 修改 hosts 文件

```
echo "127.0.0.1    localhost ops1.shiyanlou.com ops2.shiyanlou.com" >> /etc/hosts
```

6. 加载配置文件

```
a2ensite /etc/apache2/sites-avaliable/test1.conf
a2ensite /etc/apache2/sites-avaliable/test2.conf
serivec apache2 reload
```