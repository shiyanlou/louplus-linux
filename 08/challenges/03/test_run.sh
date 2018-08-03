#!/bin/bash

docker run --name mysql -d --env-file /home/shiyanlou/env_file -p 3306:3306 registry.cn-hangzhou.aliyuncs.com/louplus-linux/mysql:5.5
