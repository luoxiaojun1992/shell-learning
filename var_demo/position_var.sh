#! /bin/bash

echo '$0:' $0
echo '$1:' $1
echo '$2:' $2
echo '$@:' $@
echo '$*:' $*
echo '$#:' "$#"

test_func()
{
	return 1
}

test_func

echo $?
