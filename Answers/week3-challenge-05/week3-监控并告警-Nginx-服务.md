# 挑战：监控并告警 Nginx 服务

## 挑战 1：监控 Nginx 服务

`prometheus.yml` 文件内容如下所示：

```yaml
global:
  # 默认抓取间隔为 5s
  scrape_interval: 5s

scrape_configs:
  # 抓取 prometheus 指标
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']

  # 抓取 nginx 指标
  - job_name: 'nginx'
    static_configs:
      - targets: ['localhost:9145']
```

`prometheus` 配置如下所示：

```conf
server {
  listen 9145;
  allow 127.0.0.1;
  deny all;
  # 创建一个 Endpoint 来输出当前已采集到的指标数据
  location /metrics {
    content_by_lua '
      metric_connections:set(ngx.var.connections_reading, {"reading"})
      metric_connections:set(ngx.var.connections_waiting, {"waiting"})
      metric_connections:set(ngx.var.connections_writing, {"writing"})
      prometheus:collect()
    ';
  }
}
```

`nginx.conf` 文件内容如下所示：

```conf
user www-data;
worker_processes auto;
pid /run/nginx.pid;

events {
  worker_connections 768;
}

http {
  sendfile on;
  tcp_nopush on;
  tcp_nodelay on;
  keepalive_timeout 65;
  types_hash_max_size 2048;

  include /etc/nginx/mime.types;
  default_type application/octet-stream;

  ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
  ssl_prefer_server_ciphers on;

  access_log /var/log/nginx/access.log;
  error_log /var/log/nginx/error.log;

  gzip on;
  gzip_disable "msie6";

    # 配置一个上限为 10M 的字典来存放指标
    lua_shared_dict prometheus_metrics 10M;
    # prometheus lua 脚本的存放路径，可以使用通配符
    lua_package_path "/home/shiyanlou/nginx-lua-prometheus/?.lua";
    # 启动时进行初始化，创建各个指标对象
    init_by_lua '
        prometheus = require("prometheus").init("prometheus_metrics")
        metric_requests = prometheus:counter(
        "nginx_http_requests_total", "Number of HTTP requests", {"host", "status"})
        metric_latency = prometheus:histogram(
        "nginx_http_request_duration_seconds", "HTTP request latency", {"host"})
        metric_connections = prometheus:gauge(
        "nginx_http_connections", "Number of HTTP connections", {"state"})
    ';
    # 每个请求结束时，设置各指标的取值
    log_by_lua '
        local host = ngx.var.host:gsub("^www.", "")
        metric_requests:inc(1, {host, ngx.var.status})
        metric_latency:observe(tonumber(ngx.var.request_time), {host})
    ';

  include /etc/nginx/conf.d/*.conf;
  include /etc/nginx/sites-enabled/*;
}
```

## 挑战 2：告警 Nginx 服务

`alerting.rules.yml` 文件内容如下所示：

```yaml
groups:
- name: nginx
  rules:
  # 如果最近 10s 404 状态的每秒请求数大于 0.01，并且这种情况持续时间超过 4s 就触发报警。
  # 设为 4s 是为了尽快触发告警，以便通过挑战。
  - alert: NotFound
    expr: rate(nginx_http_requests_total{status="404"}[10s]) > 0.01
    for: 4s
```

`alertmanager.yml` 文件内容如下所示：

```yaml
global:

route:
  group_wait: 1s
  group_interval: 1s
  receiver: shiyanlou
  routes:
  # 如果是 nginx job 触发的告警，则通知 shiyanlou
  - match:
      job: nginx
    group_by: ['job']
    receiver: shiyanlou

receivers:
- name: shiyanlou
  webhook_configs:
  # 告警接收方式为接口
  - url: http://localhost:8000/
```

`http_ok_server.sh` 文件内容如下所示：

```sh
#!/bin/bash

# 模拟的告警接收接口
while true; do
  echo -e "HTTP/1.1 200 OK\r\n\r\nOK\r\n" |
  nc -lp 8000 -q 1
  sleep 1
done
```

`prometheus.yml` 文件内容如下所示：

```yaml
global:
  scrape_interval: 5s
  evaluation_interval: 5s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']

  - job_name: 'nginx'
    static_configs:
      - targets: ['localhost:9145']

rule_files:
  # 配置告警规则文件
  - alerting.rules.yml

alerting:
  alertmanagers:
    # 配置告警管理器地址
    - static_configs:
        - targets: ['localhost:9093']
```

