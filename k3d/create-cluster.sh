#!/bin/bash

# You can redefine from outsite using 'export K3D_VERSION=theversionyouwant'
k3d create cluster topgunCluster --masters 5 --workers 9
