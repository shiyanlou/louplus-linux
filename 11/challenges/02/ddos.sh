#!/bin/bash

# 单个 IP 最多连接数限制
LIMIT=21

# 找出连接数超过限制的 IP，保存到文件中
netstat -na | awk '/ESTABLISHED/{split($5, T, ":"); print T[1]}' | sort | grep -v -E '192.168|127.0' | uniq -c | sort -rn | awk -v limit=$LIMIT '{if($2 != null && $1 > limit) {print $2}}' >/var/log/rejectip

for i in $(cat /var/log/rejectip)
do
    # 跳过白名单里的 IP
    if grep $i /home/shiyanlou/goodip
    then
		continue
	fi

    # 判断是否已加过限制
    rep=$(iptables-save | grep $i)
    if [[ -z $rep ]]
    then
        # 限制 IP 每分钟新建连接数不超过 5 个
        /sbin/iptables -A INPUT -s $i -m limit --limit 5/m -j ACCEPT
        echo "$i limit at `date`" >>/var/log/ddos-ip
    fi
done
