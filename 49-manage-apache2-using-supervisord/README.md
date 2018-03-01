#### 创建新的 supervisord 配置文件

```
cp /etc/supervisor/supervisord.conf /home/shiyanlou/supervisord1.conf
```

将其中的 supervisor.sock 等等都改成 supervisord1.sock 还有 pid 等等

修改 Include 为 /home/shiyanlou/apache2.conf


#### 创建 Apache 的配置文件

```
vim /home/shiyanlou/apache2.conf
```

输入下面的内容

```
[program:apache2]
command=/usr/sbin/apache2ctl -D "FOREGROUND" -k start
autostart=true
autorestart=true
startretries=3
stopwaitsecs=10
```

#### 启动 supervisord

```
supervisord -c /home/shiyanlou/supervisord1.conf
supervisorctl -c /home/shiyanlou/supervisord1.conf
```
