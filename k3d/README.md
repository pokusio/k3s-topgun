# Example outputs

```bash
jbl@pc-alienware-jbl:~$ k3d create cluster jblCluster  --masters 5 --workers 9  --api-port "0.0.0.0:6551"
INFO[0000] Created network 'k3d-jblCluster'
INFO[0000] Created volume 'k3d-jblCluster-images'
INFO[0000] Creating initializing master node
INFO[0000] Creating node 'k3d-jblCluster-master-0'
INFO[0013] Creating node 'k3d-jblCluster-master-1'
INFO[0014] Creating node 'k3d-jblCluster-master-2'
INFO[0016] Creating node 'k3d-jblCluster-master-3'
INFO[0018] Creating node 'k3d-jblCluster-master-4'
INFO[0019] Creating node 'k3d-jblCluster-worker-0'
INFO[0020] Creating node 'k3d-jblCluster-worker-1'
INFO[0022] Creating node 'k3d-jblCluster-worker-2'
INFO[0024] Creating node 'k3d-jblCluster-worker-3'
INFO[0025] Creating node 'k3d-jblCluster-worker-4'
INFO[0027] Creating node 'k3d-jblCluster-worker-5'
INFO[0028] Creating node 'k3d-jblCluster-worker-6'
INFO[0029] Creating node 'k3d-jblCluster-worker-7'
INFO[0031] Creating node 'k3d-jblCluster-worker-8'
INFO[0032] Creating LoadBalancer 'k3d-jblCluster-masterlb'
INFO[0033] Cluster 'jblCluster' created successfully!
INFO[0033] You can now use it like this:
export KUBECONFIG=$(k3d get kubeconfig jblCluster)
kubectl cluster-info
jbl@pc-alienware-jbl:~$ rm $KUBECONFIG
jbl@pc-alienware-jbl:~$ export KUBECONFIG=$(k3d get kubeconfig jblCluster)
jbl@pc-alienware-jbl:~$ kubectl get all
NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.43.0.1    <none>        443/TCP   93s
jbl@pc-alienware-jbl:~$
jbl@pc-alienware-jbl:~$ kubectl get all
NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.43.0.1    <none>        443/TCP   6m43s
jbl@pc-alienware-jbl:~$ kubectl get all --all-namespaces
NAMESPACE     NAME                                          READY   STATUS              RESTARTS   AGE
kube-system   pod/helm-install-traefik-65ns9                0/1     ContainerCreating   0          6m33s
kube-system   pod/local-path-provisioner-58fb86bdfd-b4qhf   0/1     ContainerCreating   0          6m33s
kube-system   pod/coredns-6c6bb68b64-wsx8m                  0/1     ContainerCreating   0          6m32s
kube-system   pod/metrics-server-6d684c7b5-hj6xr            0/1     ContainerCreating   0          6m32s

NAMESPACE     NAME                     TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)                  AGE
default       service/kubernetes       ClusterIP   10.43.0.1      <none>        443/TCP                  6m57s
kube-system   service/kube-dns         ClusterIP   10.43.0.10     <none>        53/UDP,53/TCP,9153/TCP   6m55s
kube-system   service/metrics-server   ClusterIP   10.43.60.178   <none>        443/TCP                  6m54s

NAMESPACE     NAME                                     READY   UP-TO-DATE   AVAILABLE   AGE
kube-system   deployment.apps/local-path-provisioner   0/1     1            0           6m54s
kube-system   deployment.apps/coredns                  0/1     1            0           6m55s
kube-system   deployment.apps/metrics-server           0/1     1            0           6m54s

NAMESPACE     NAME                                                DESIRED   CURRENT   READY   AGE
kube-system   replicaset.apps/local-path-provisioner-58fb86bdfd   1         1         0       6m34s
kube-system   replicaset.apps/coredns-6c6bb68b64                  1         1         0       6m34s
kube-system   replicaset.apps/metrics-server-6d684c7b5            1         1         0       6m34s

NAMESPACE     NAME                             COMPLETIONS   DURATION   AGE
kube-system   job.batch/helm-install-traefik   0/1           6m30s      6m53s
jbl@pc-alienware-jbl:~$

```
