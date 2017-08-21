#! /bin/bash

# 清除所有规则
iptables -F

# 清除所有自定义链
iptables -X

# 丢弃所有输入包
iptables -P INPUT DROP

# 丢弃所有输出包
iptables -P OUTPUT DROP

# 接收icmp数据包
iptables -A INPUT -p icmp --icmp-type any -j ACCEPT

# 发送icmp数据包
iptables -A OUTPUT -p icmp --icmp any -j ACCEPT

# 接收本地数据包
iptables -A INPUT -s localhost -d localhost -j ACCEPT

# 发送本地数据包
iptables -A OUTPUT -s localhost -d localhost -j ACCEPT

# 接收已经建立和相关的数据包
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# 发送已经建立和相关的数据包
iptables -A OUPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# 开放80端口入口
iptables -A INPUT -p tcp --dport 80 -j ACCEPT

# 开放80端口出口
iptables -A OUPUT -p tcp -m state --state NEW --dport 80 -j ACCEPT

# 允许发送udp包
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
