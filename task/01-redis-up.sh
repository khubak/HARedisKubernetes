#!/usr/bin/env bash

kubectl create ns redis
kubectl apply -f ./configs/sc.yaml
kubectl apply -f ./configs/pv.yaml
kubectl apply -n redis -f ./yamls/redis-config.yaml

#check replicationhttps://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#delete
kubectl -n redis logs redis-0