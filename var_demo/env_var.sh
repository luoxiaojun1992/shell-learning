#! /bin/bash

echo 'SHELL:' $SHELL
echo 'BASH:' $BASH
echo 'BASH_VERSION' $BASH_VERSION
echo 'CDPATH:' $CDPATH
echo 'EUID:' $EUID

test_func()
{
	echo 'FUNCNAME:' $FUNCNAME
}

test_func

echo 'HISTCMD' $HISTCMD
echo 'HISTFILE' $HISTFILE
echo 'HISTFILESIZE' $HISTFILESIZE
