#!/bin/bash

# 比较当前值是否超过阈值，并打印提示信息
judgment() {
    vtype=$1
    threshold=$2
    # 剔除掉末尾可能的 % 号
    used=$(echo $3 | tr -d '%')
    if (( $used < $threshold ))
    then
        printf '%s %s\n' "$vtype" "$3 OK"
    else
        printf '%s %s\n' "$vtype" "$3 Alert"
    fi
}

# 磁盘使用情况
disk() {
    used=$(df | grep -w '/' | awk '{print $5}')
    judgment Disk-Root 85 $used
}

# 内存使用情况
memory() {
    total=$(free | grep Mem | awk '{print $2}')
    used=$(free | grep Mem | awk '{print $3}')
    usedp=$(( $used * 100 / $total ))%
    judgment Memory 90 $usedp
}

# CPU 使用情况
load() {
    total_core=$(grep -c 'model name' /proc/cpuinfo)
    total_load=$(uptime | awk -F ',' '{print $4}' | awk -F ':' '{print $2}')
    # 使用 AWK 来进行浮点运算，同时把 load 值放大 100 倍来转化成整数，使得后续运算不需要考虑浮点数
    per_load=$(awk -v total_core="$total_core" -v total_load="$total_load" 'BEGIN {print int(total_load * 100 / total_core)}')
    # 阈值同样需要放大 100 倍
    judgment Loadaverage 70 $per_load
}

# 调用各个使用情况函数
disk
memory
load
