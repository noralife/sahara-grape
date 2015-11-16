#!/bin/sh

kubectl delete rc mysql
kubectl delete rc sahara-cms
kubectl delete rc sahara-oms
kubectl delete rc sahara-pms
kubectl delete rc sahara-web

kubectl delete service mysql
kubectl delete service sahara-cms
kubectl delete service sahara-oms
kubectl delete service sahara-pms
kubectl delete service sahara-web
