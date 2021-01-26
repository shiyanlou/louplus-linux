# 挑战：让实验楼网站恢复访问

## 启动 nginx 服务

```bash
sudo service nginx start
```

## 配置 nginx

```bash
$ sudo vim /etc/nginx/sites-enabled/default
```

```conf
server {
    listen 80 default_server;
    listen [::]:80 default_server ipv6only=on;

    # 设置站点根目录
    root /home/shiyanlou/page;
    index index.html index.htm shiyanlou.htm;

    # 定义服务名为 localhost
    server_name localhost;

    location / {
        try_files $uri $uri/ =404;
    }
}
```

```bash
# 重启 nginx
sudo service nginx restart
```
