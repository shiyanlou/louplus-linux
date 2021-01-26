# 挑战：优化 ELK 配置

1. 修改 elasticsearch 的配置：

```bash
vim /home/shiyanlou/elasticsearch-7.4.1/config/jvm.options
```

将其中的 Xms 和 Xmx 配置信息修改为：

```text
# - Xms1g
# - Xmx1g
- Xms512m
- Xmx512m
```

2. 修改 logstash 的配置：

```bash
vim /home/shiyanlou/logstash-7.4.1/config/jvm.options
```

将其中的 Xms 和 Xmx 配置信息修改为：

```text
# - Xms1g
# - Xmx1g
- Xms512m
- Xmx512m
```
