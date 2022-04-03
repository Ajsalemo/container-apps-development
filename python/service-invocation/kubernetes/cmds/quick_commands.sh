#!/bin/bash

#############################################
# Quick kubectl commands that can be referenced for kube management
#############################################

# List commands
kubectl get pods
kubectl get services

# Delete commands
kubectl delete pod/<pod>
kubectl delete server/<pod>

# Deploy commands
kubectl apply -f kubernetes/checkout/checkout.deploy.yaml
kubectl apply -f kubernetes/checkout/checkout.service.yaml
kubectl apply -f kubernetes/order-processor/order-processor.deploy.yaml
kubectl apply -f kubernetes/order-processor/order-processor.service.yaml

# Describe
kubectl describe pod/<pod>