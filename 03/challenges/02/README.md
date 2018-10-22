# 挑战：让实验楼网站恢复访问

## 修复虚拟机配置错误

```bash
vi /etc/nginx/sites-enable/default
```

```nginx
server {
    server_name localhost;
    listen 80 default_server;
    listen [::]:80 default_server ipv6only=on;

    # 修正站点根目录
    root /home/shiyanlou/page;
    index index.html index.htm shiyanlou.htm;

    location / {
        # 修正语法错误，行尾需要有分号
        try_files $uri $uri/ =404;
    }
}
```