#! /bin/bash

declare -a Arr
Arr[0]=0
Arr[1]=1
echo ${Arr[0]}
echo ${Arr[1]}

declare -a Name=('John' 'Sue')
echo ${Name[0]}
echo ${Name[1]}

# 所有元素
echo ${Name[@]}
echo ${Arr[*]}

# 数组长度
echo ${#Arr[@]}
echo ${#Name[*]}

# 元素长度
echo ${#Name[0]}

# 数组截取
echo ${Name[@]:0:2}
echo ${Name[1]:0:1}
