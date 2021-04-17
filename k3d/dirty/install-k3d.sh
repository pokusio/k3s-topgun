#!/bin/bash

# You can redefine from outsite using 'export K3D_VERSION=theversionyouwant'
export K3D_DESIRED_VERSION=${K3D_VERSION:-'v3.0.0-beta.0'}
export K3D_DESIRED_VERSION=${K3D_VERSION:-'v3.0.0-rc.6'}

wget -q -O - https://raw.githubusercontent.com/rancher/k3d/master/install.sh | TAG=${K3D_DESIRED_VERSION} bash

k3d version
