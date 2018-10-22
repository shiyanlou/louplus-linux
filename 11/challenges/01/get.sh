#!/bin/bash

# 检查参数个数是否符合要求
if [[ $# != 1 ]]
then
    echo "Need port"
    exit 1
fi

# 获取端口参数
port=$1

# 使用 netstat 命令查找所有 TCP 和 UDP 监听连接，并过滤出指定端口的那条
process=$(netstat -lntup | grep ":$1")
if [[ -z $process ]]
then
    echo "OFF"
else
    # netstat 输出结果中 PID 和 Program name 之间用 / 分隔
    program=$(echo $process | awk -F '/' '{print $2}')
    if [[ -z $program ]]
    then
        echo "Can't get process name"
    else
        echo $(which $program)
    fi
fi
