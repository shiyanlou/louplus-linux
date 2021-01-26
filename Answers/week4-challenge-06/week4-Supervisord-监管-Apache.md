# 挑战：Supervisord 监管 Apache

## 安装

```bash
sudo apt install -y supervisor
sudo service supervisor status
```

## 配置

停止 nginx，避免占用 80 端口：

```bash
sudo service nginx stop
```

向 `/etc/apache2/apache2.conf` 文件末尾添加如下一行内容：

```conf
ServerName 127.0.0.1
```

`/etc/supervisor/conf.d/apache2.conf` 文件内容如下所示：

```conf
[program:apache]
command=/usr/sbin/apache2ctl -D "FOREGROUND" -k start
autostart=true
autorestart=true
startretries=3
redirect_stderr=true
stderr_logfile=/var/log/myapache.err.log
stdout_logfile=/var/log/myapache.out.log
```

配置完成以后进行更新：

```bash
sudo supervisorctl reread
sudo supervisorctl update
```