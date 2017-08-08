#! /bin/bash

a=1
echo $a
unset a
echo $a

test_func()
{
	echo 'test func'
}

test_func
unset test_func
# test_func
