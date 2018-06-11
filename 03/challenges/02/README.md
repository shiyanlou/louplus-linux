1. 创建项目目录

```
mkdir /home/shiyanlou/test1
mkdir /home/shiyanlou/test2
echo "Hello,this is first" > /home/shiyanlou/test1/index.html
echo "Hello,this is second" > /home/shiyanlou/test2/index.html
```

2. 修改目录访问权限

```
sudo vim /etc/apache2/apache2.conf
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
echo "Listen 8080" | sudo tee -a /etc/apache2/ports.conf
```

4. 创建虚拟机配置文件

```
sudo vim /etc/apache2/sites-available/test1.conf
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
sudo vim /etc/apache2/sites-available/test2.conf
```

添加下面的内容

```
<VirtualHost *:8080>
        ServerName  ops2.shiyalou.com
        DocumentRoot /home/shiyanlou/test2
</VirtualHost>
```

5. 修改 hosts 文件

```
echo "127.0.0.1    localhost ops1.shiyanlou.com ops2.shiyanlou.com" | sudo tee -a /etc/hosts
```

6. 加载配置文件

```
sudo a2ensite test1.conf
sudo a2ensite test2.conf
sudo service apache2 start
sudo service apache2 reload
```
