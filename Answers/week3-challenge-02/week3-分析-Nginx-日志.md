# 挑战：分析 Nginx 日志

```bash
cd /home/shiyanlou/logstash-7.4.1
mkdir conf.d && cd conf.d
touch logstash-shipper.conf
```

`/home/shiyanlou/logstash-7.4.1/conf.d/logstash-shipper.conf` 文件内容如下所示：

```yaml
input {
    # 日志来源文件
    file {
        path => "/var/log/nginx/access.log"
        start_position => beginning
        codec =>  multiline {
            'negate' => true
            'pattern' => '^[0-9a-zA-Z.:]+ - -'
            'what' => 'previous'
        }
    }
}

output {
    # 日志输出到 Elasticsearch
    elasticsearch {
        host => ["localhost:9200"]
        index => "logstash-%{+YYYY.MM.dd}"
    }

    # 日志输出到调试文件
    file {
        codec => "rubydebug"
        path => "/home/shiyanlou/elk/logstash-debug"
    }
}
```
