#!/bin/bash

# 环境变量如果比较多可以放在单独的文件里，少的话可以通过 -e 选项传递，该选项可重复多次
# 由于 Docker 官方镜像 Registry 国内访问速度较慢，因此使用了实验楼自己的镜像 Registry
docker run --name mysql -d --env-file ./env_file -p 3306:3306 registry.cn-hangzhou.aliyuncs.com/louplus-linux/mysql:5.5
