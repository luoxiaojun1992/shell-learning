#! /bin/bash

kubectl --kubeconfig=/Users/luoxiaojun/.kube-dev/config cp $1 $2 -n dev-jingsocial
