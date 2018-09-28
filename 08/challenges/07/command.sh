#!/bin/bash

# 创建一个子目录来构建镜像，以避免发送无关文件给 Docker 服务
mkdir -p challenge && cd challenge

# 创建相关文件，包括 Dockerfile、nginx.conf、supervisord.conf

docker build -t syl-wordpress .

docker run -d -p 80:80 --name syl-wordpress syl-wordpress

curl -v http://127.0.0.1/