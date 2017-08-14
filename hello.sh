#! /bin/bash

echo 'Hello \t'
echo -n 'Hello '
echo -e 'Hello \t'

type echo

# MAC needs a suffix ''
# sed -i '' 's/^%//' hello.sh

echo $1

shift 1

echo $1

read -p "Please input a number:" NUMBER
echo $NUMBER

