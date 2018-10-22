#!/bin/bash

# 清空规则
iptables -F
# 删除所有用户自定义链
iptables -X
# 清空数据包和字节数计数器
iptables -Z

# 默认丢弃
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

# 允许回环网口的进出报文
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# 允许外部使用 TCP 协议连接 80 和 443 端口
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# 允许 IP 192.168.42.1 的客户端连接 22 端口，也就是允许远程登录
iptables -I INPUT -s 192.168.42.1 -p tcp --dport 22 -j ACCEPT

# 允许网段 192.168.42.0/24 的所有客户端连接 5901 端口，也就是允许远程桌面
iptables -I INPUT -s 192.168.42.0/24 -p tcp --dport 5901 -j ACCEPT
