#! /bin/bash

kubectl --kubeconfig=/Users/luoxiaojun/.kube-dev/config exec -it $1 bash -n dev-jingsocial
