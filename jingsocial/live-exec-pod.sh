#! /bin/bash

kubectl --kubeconfig=/Users/luoxiaojun/.kube-stage/config exec -it $1 bash -n live-jingsocial
