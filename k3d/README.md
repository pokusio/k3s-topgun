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
```
