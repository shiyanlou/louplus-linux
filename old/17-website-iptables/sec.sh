#!/bin/bash

# 清除已有规则
iptables -F
iptables -X
iptables -Z

# 默认规则
iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT

iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT

iptables -I INPUT -s 192.168.42.1 -p tcp --dport 22 -j ACCEPT

iptables -I INPUT -s 192.168.42.0/24 -p tcp --dport 5901 -j ACCEPT
