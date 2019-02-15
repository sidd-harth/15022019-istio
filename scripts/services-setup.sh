#!/bin/bash

git clone https://github.com/sidd-harth/aio

oc login -u system:admin

echo "Changining work directory"
cd aio/kubernetes/kube-injected

oc project apigee

echo "Deploying Movies Services"
oc apply -f movies-v1-deployment-injected.yml -n apigee
oc apply -f movies-v2-deployment-injected.yml -n apigee
oc create -f movies-service.yml -n apigee 
oc expose svc movies -n apigee

echo "Deploying Booking Services"
oc apply -f booking-v1-deployment-injected.yml -n apigee
oc create -f booking-service.yml -n apigee 
oc expose svc booking -n apigee

echo "Deploying Payment Services"
oc apply -f payment-v1-deployment-injected.yml -n apigee
oc apply -f payment-v2-deployment-injected.yml -n apigee
oc create -f payment-service.yml -n apigee 
oc expose svc payment -n apigee

echo "Deploying UI Services"
oc apply -f ui-v1-deployment-injected.yml -n apigee
oc create -f ui-service.yml -n apigee
oc expose svc ui -n apigee
