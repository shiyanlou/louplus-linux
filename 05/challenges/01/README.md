# 挑战：优化 ELK 配置

## 优化 Elasticsearch

编辑 `/etc/elasticsearch/jvm.options` 文件，调整 `Xms` 和 `Xmx` 选项：

```text
-Xms512m
-Xmx512m
```

## 优化 Logstash

编辑 `/etc/logstash/jvm.options` 文件，调整 `Xms` 和 `Xmx` 选项：

```text
-Xms512m
-Xmx512m
```
