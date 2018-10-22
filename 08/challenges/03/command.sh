#!/bin/bash

# 创建一个子目录来构建镜像，以避免发送大量无关文件给 Docker 服务
mkdir -p challenge && cd challenge

# 创建相关文件，包括 Dockerfile、nginx.conf、supervisord.conf

# 构建镜像
docker build -t syl-wordpress .

# 运行镜像
docker run -d -p 80:80 --name syl-wordpress syl-wordpress

# 访问 Wordpress
curl http://127.0.0.1/