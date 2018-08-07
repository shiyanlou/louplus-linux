#!/bin/bash

# 创建一个子目录来构建镜像，以避免发送无关文件给 Docker 服务
mkdir -p challenge && cd challenge

# 创建相关文件，包括 Dockerfile、app.py、shiyanlou.conf

docker build -t shiyanlou .

docker network create shiyanlou

docker run -d --name shiyanlou --network shiyanlou shiyanlou

docker run -d --name nginx --network shiyanlou -v /home/shiyanlou/challenge/shiyanlou.conf:/etc/nginx/conf.d/shiyanlou.conf -p 8080:80 registry.cn-hangzhou.aliyuncs.com/louplus-linux/nginx:1.9.1

# 执行下面命令之前，请先添加 Hosts “127.0.0.1   shiyanlou.com”
curl http://shiyanlou.com:8080/