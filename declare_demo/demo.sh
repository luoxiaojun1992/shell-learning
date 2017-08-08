#! /bin/bash

declare -i a=1
echo $a

declare -r b=2 

declare -a arr='([0]=1 [1]=2)'
echo ${arr[0]}
echo ${arr[1]}

test_func()
{
    return 1
}

declare -f test_func
declare -F test_func
