编辑 /etc/nginx/sites-enable/default 文件，修改为以下内容

```
server {
    listen 80 default_server;
    listen [::]:80 default_server ipv6only=on;
    root /home/shiyanlou/page;
    index index.html index.htm shiyanlou.htm;
    server_name localhost;

    location / {
        try_files $uri $uri/ =404;
    }
}
```