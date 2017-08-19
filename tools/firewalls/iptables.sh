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
