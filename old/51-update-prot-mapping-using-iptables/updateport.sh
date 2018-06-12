#!/bin/bash

old_host_port=3306
new_host_port=3305
dst_port=3306

# 命令最后的 mysql 为 MySQL 服务容器的名称，请依据实际情况修改。
mysql_container_ip=`docker inspect -f {{.NetworkSettings.IPAddress}} mysql`

sudo iptables -t nat -A DOCKER ! -i docker0 -p tcp --dport $new_host_port -j DNAT --to-destination $mysql_container_ip:$dst_port
sudo iptables -t nat -D DOCKER ! -i docker0 -p tcp --dport $old_host_port -j DNAT --to-destination $mysql_container_ip:$dst_port
