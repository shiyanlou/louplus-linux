#!/bin/bash

echo "114.110.100.100" > /tmp/goodip

netstat -na | awk '/ESTABLISHED/{split($5,T,":"); print T[1]}' | sort | grep -v -E '192.168|127.0' | uniq -c | sort -rn | head -10 | awk '{if ($2!=null && $1>21) {print $2}}' > /var/log/rejectip

for i in $(cat /var/log/rejectip)
do
    if grep $1 /tmp/goodip ;then
		break
	fi
    if [[ -z $rep ]];then
        /sbin/iptables -A INPUT -s $i -m limit --limit 5/m -j ACCEPT
		/sbin/iptables -A INPUT -s $i -j DROP
        echo “$i limit at `date`”>>/var/log/ddos-ip
    fi
done

