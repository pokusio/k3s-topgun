#!/bin/bash

# This stil deoes not work properly... July 2020
k3d create cluster topgunCluster  --server-arg "--no-deploy=traefik" --masters 5 --workers 9 --api-port "0.0.0.0:6551"
rm $KUBECONFIG
export KUBECONFIG=$(k3d get kubeconfig topgunCluster)
kubectl get all
