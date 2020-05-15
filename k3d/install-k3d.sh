#!/bin/bash

# You can redefine from outsite using 'export K3D_VERSION=theversionyouwant'
export K3D_DEISRED_VERSION=${K3D_VERSION:-'v3.0.0-beta.0'}
wget -q -O - https://raw.githubusercontent.com/rancher/k3d/master/install.sh | TAG=${K3D_DEISRED_VERSION} bash
