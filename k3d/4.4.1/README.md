# k3d standard ops

### Provision a multi node cluster

With version `4.4.1` of `k3d`, provisioning a multi node cluster is different than with version `3.0.0-beta` :

```bash
export CLUSTER_NAME="jblCluster"
docker network create jbl_network -d bridge
# succesfully created cluster, but failed starting load balancer and third agent :
k3d cluster create "${CLUSTER_NAME}" --agents 3 --servers 3 --network jbl_network  -p 8080:80@agent[0] -p 8081:80@agent[1] -p 8090:8090@server[0]  -p 8091:8090@server[1] --api-port 0.0.0.0:7888
# k3d cluster create jblCluster --agents 3 --servers 4 --network jbl_network  -p 8080:80@agent[0] -p 8081:80@agent[1] -p 8090:8090@server[0]  -p 8091:8090@server[1] --api-port 0.0.0.0:7888
# failed at starting all servers when nb of servers is 5, 6, or more up to 9, with 3 agents, and failed at creating cluster at all
k3d cluster create jblCluster --agents 3 --servers 9 --network jbl_network  -p 8080:80@agent[0] -p 8081:80@agent[1] -p 8090:8090@server[0]  -p 8091:8090@server[1] --api-port 0.0.0.0:7888

# to retrieve the KUBECONFIG
kubectl config use-context "k3d-${CLUSTER_NAME}"
```

When the cluster is created, started, here are the cluster info :

```bash
bash-3.2$ kubectl cluster-info
Kubernetes master is running at https://0.0.0.0:7888
CoreDNS is running at https://0.0.0.0:7888/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
Metrics-server is running at https://0.0.0.0:7888/api/v1/namespaces/kube-system/services/https:metrics-server:/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.

bash-3.2$ curl -ivvv https://0.0.0.0:7888/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy --insecure
*   Trying 0.0.0.0...
* TCP_NODELAY set
* Connected to 0.0.0.0 (127.0.0.1) port 7888 (#0)
* ALPN, offering h2
* ALPN, offering http/1.1
* successfully set certificate verify locations:
*   CAfile: /etc/ssl/cert.pem
  CApath: none
* TLSv1.2 (OUT), TLS handshake, Client hello (1):
* TLSv1.2 (IN), TLS handshake, Server hello (2):
* TLSv1.2 (IN), TLS handshake, Certificate (11):
* TLSv1.2 (IN), TLS handshake, Server key exchange (12):
* TLSv1.2 (IN), TLS handshake, Request CERT (13):
* TLSv1.2 (IN), TLS handshake, Server finished (14):
* TLSv1.2 (OUT), TLS handshake, Certificate (11):
* TLSv1.2 (OUT), TLS handshake, Client key exchange (16):
* TLSv1.2 (OUT), TLS change cipher, Change cipher spec (1):
* TLSv1.2 (OUT), TLS handshake, Finished (20):
* TLSv1.2 (IN), TLS change cipher, Change cipher spec (1):
* TLSv1.2 (IN), TLS handshake, Finished (20):
* SSL connection using TLSv1.2 / ECDHE-ECDSA-AES256-GCM-SHA384
* ALPN, server did not agree to a protocol
* Server certificate:
*  subject: O=k3s; CN=k3s
*  start date: Apr 17 23:59:41 2021 GMT
*  expire date: Apr 18 00:00:19 2022 GMT
*  issuer: CN=k3s-server-ca@1618703981
*  SSL certificate verify result: unable to get local issuer certificate (20), continuing anyway.
> GET /api/v1/namespaces/kube-system/services/kube-dns:dns/proxy HTTP/1.1
> Host: 0.0.0.0:7888
> User-Agent: curl/7.64.1
> Accept: */*
>
< HTTP/1.1 401 Unauthorized
< Cache-Control: no-cache, private
< Content-Type: application/json
< Date: Sun, 18 Apr 2021 00:25:19 GMT
< Content-Length: 165
<
{ [165 bytes data]
100   165  100   165    0     0   4852      0 --:--:-- --:--:-- --:--:--  4852
* Connection #0 to host 0.0.0.0 left intact
* Closing connection 0
HTTP/1.1 401 Unauthorized
Cache-Control: no-cache, private
Content-Type: application/json
Date: Sun, 18 Apr 2021 00:25:19 GMT
Content-Length: 165

{
  "kind": "Status",
  "apiVersion": "v1",
  "metadata": {

  },
  "status": "Failure",
  "message": "Unauthorized",
  "reason": "Unauthorized",
  "code": 401
}
```
