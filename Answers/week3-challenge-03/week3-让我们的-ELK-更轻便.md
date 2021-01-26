# 挑战：让我们的 ELK 更轻便

`/home/shiyanlou/filebeat-7.4.1-linux-x86_64/filebeat.yml` 的文件内容如下所示：

```yaml
# 日志来源文件路径
filebeat.prospectors:
  - type: log
    paths:
      - /var/log/nginx/access.log

# 日志输出到 redis
output.redis:
  hosts: ["10.119.13.23"]
  port: 6379
```


