#! /bin/bash

originBr=$1
echo "Origin branch:${originBr}"

newBr=$2
echo "Target branch:${newBr}"

git checkout ${originBr} && git checkout -b ${newBr}
