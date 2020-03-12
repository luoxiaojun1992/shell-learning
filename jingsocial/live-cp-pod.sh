#! /bin/bash

kubectl --kubeconfig=$HOME/.kube-stage/config cp $1 $2 -n live-jingsocial
