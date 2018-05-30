#!/bin/bash

old_host_port=3306
new_host_port=3305
dst_port=3306

mysql_container_ip=`docker inspect -f {{.NetworkSettings.IPAddress}} mysql_server`

sudo iptables -t nat -A DOCKER ! -i docker0 -p tcp --dport $new_host_port -j DNAT --to-destination $mysql_container_ip:$dst_port
sudo iptables -t nat -D DOCKER ! -i docker0 -p tcp --dport $old_host_port -j DNAT --to-destination $mysql_container_ip:$dst_port
