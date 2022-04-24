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
kubectl apply -f client/client.deploy.yaml
kubectl apply -f client/client.service.yaml
kubectl apply -f server/server.deploy.yaml
kubectl apply -f server/server.service.yaml

# Describe
kubectl describe pod/<pod>