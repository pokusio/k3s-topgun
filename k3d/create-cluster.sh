#!/bin/bash

# This stil deoes not work properly... July 2020
k3d create cluster topgunCluster --masters 5 --workers 9 --api-port "0.0.0.0:6551"
