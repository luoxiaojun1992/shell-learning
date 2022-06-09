#! /bin/bash

originBr=$1
echo "Origin branch:${originBr}"
originBrCnt=`git branch | egrep "\\s+${originBr}$" | wc -l`
if [ $originBrCnt -ne 1 ]; then
	echo "Origin branch not existed"
	exit 1
fi

newBr=$2
echo "Target branch:${newBr}"
newBrCnt=`git branch | egrep "\\s+${newBr}$" | wc -l`
if [ $newBrCnt -ne 0 ]; then
        echo "New branch existed"
        exit 1
fi

git checkout ${originBr} && git pull origin ${originBr} && git checkout -b ${newBr}
