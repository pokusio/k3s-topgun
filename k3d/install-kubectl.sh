#!/bin/bash

# You can redefine from outsite using 'export K3D_VERSION=theversionyouwant'
export KUBECTL_DESIRED_VERSION=${KUBECTL_DESIRED_VERSION:-'null'}
export KUBECTL_DESIRED_VERSION="v1.18.0"

Usage () {
  echo ""
  echo " - Usage :"
  echo ""
  echo " export KUBECTL_DESIRED_VERSION=<the version no. you want for kubectl>"
  echo " $0"
  echo ""
  echo " - Where : "
  echo ""
  echo " "
}

# https://kubernetes.io/docs/tasks/tools/install-kubectl/

if [ "${KUBECTL_DESIRED_VERSION}" == 'null' ]; then
  echo "You did not set the KUBECTL_DESIRED_VERSION env. var."
  exit 1
fi;

if [ "${KUBECTL_DESIRED_VERSION}" == 'latest' ]; then
  curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl && exit 0
else
  curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_DESIRED_VERSION}/bin/linux/amd64/kubectl
fi;

chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

kubectl version --client
