#!/bin/sh

kubectl create -f mysql-controller.yaml
kubectl create -f sahara-cms-controller.yaml
kubectl create -f sahara-oms-controller.yaml
kubectl create -f sahara-pms-controller.yaml
kubectl create -f sahara-web-controller.yaml

kubectl create -f mysql-service.yaml
kubectl create -f sahara-cms-service.yaml
kubectl create -f sahara-oms-service.yaml
kubectl create -f sahara-pms-service.yaml
kubectl create -f sahara-web-service.yaml
