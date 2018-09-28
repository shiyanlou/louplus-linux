#!/bin/bash

# 安装 nginx 服务
sudo apt-get update && sudo apt-get install nginx

# 启动 nginx 服务
sudo service nginx start

# 查找 vnc 进程得到进程 ID
# ps -ef | grep vnc
# 使用 kill 命令发送信号给进程，默认发送 TERM 信号。如果进程不理会，可以发送 KILL 信号强制杀掉
# kill -KILL PID

# 使用 pkill 发送信号给名称包含 vnc 的进程
pkill -KILL vnc
