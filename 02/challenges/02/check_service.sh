#!/bin/bash

# 第 1 个参数为服务名
service=$1

# 查询服务状态
sudo service "$service" status

# service 命令的退出码具有特殊含义
status=$?
case $status in
0)
	echo "is Running"
	;;
1)
	echo "Error: Service Not Found"
	;;
3)
	echo "Restarting"
	sudo service "$service" start
	;;
esac

# 以 service 命令的退出码作为脚本退出码
exit $status
