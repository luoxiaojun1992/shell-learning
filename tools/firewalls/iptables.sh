#! /bin/bash

# 清除所有规则
iptables -F

# 清除所有自定义链
iptables -X

# 丢弃所有输入包
iptables -P INPUT DROP

# 丢弃所有输出包
iptables -P OUTPUT DROP
