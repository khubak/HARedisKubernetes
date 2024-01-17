#!/usr/bin/env bash

kubectl create ns redis
kubectl apply -f ./yamls/sc.yaml
kubectl apply -f ./yamls/pv.yaml
kubectl apply -n redis -f ./yamls/redis-service.yaml
kubectl apply -n redis -f ./yamls/redis-config.yaml
kubectl apply -n redis -f ./yamls/redis-statefulset.yaml
