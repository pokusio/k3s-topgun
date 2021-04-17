

### ETCD integration

Alright, now the next test :
* bring an etcd serice with docker-compose or in any k8s cluster (could be a postgres)
* and then I will create my cluster that way, to plug in the `ETCD` (`postgres`) :

```bash

k3d create cluster --k3s-server-arg "k3s server --tls-san \"192.168.1.28,0.0.0.0\"" \
                   --k3s-server-arg "k3s server --datastore-endpoint \"value\"" \
                   --k3s-server-arg "k3s server --datastore-cafile \"value\"" \
                   --k3s-server-arg "k3s server --datastore-certfile \"value\"" \
                   --k3s-server-arg "k3s server --datastore-keyfile \"value\"" \
                   topgunCluster2 --masters 3 --workers 5

```


<table>
<thead>
<tr>
<th>CLI Flag</th>
<th>Environment Variable</th>
<th>Description</th>
</tr>
</thead>

<tbody>
<tr>
<td><span style="white-space: nowrap"><code>--datastore-endpoint</code></span></td>
<td><code>K3S_DATASTORE_ENDPOINT</code></td>
<td>Specify a PostgresSQL, MySQL, or etcd connection string. This is a string used to describe the connection to the datastore. The structure of this string is specific to each backend and is detailed below.</td>
</tr>

<tr>
<td><span style="white-space: nowrap"><code>--datastore-cafile</code></span></td>
<td><code>K3S_DATASTORE_CAFILE</code></td>
<td>TLS Certificate Authority (CA) file used to help secure communication with the datastore. If your datastore serves requests over TLS using a certificate signed by a custom certificate authority, you can specify that CA using this parameter so that the K3s client can properly verify the certificate.</td>
</tr>

<tr>
<td><span style="white-space: nowrap"><code>--datastore-certfile</code></span></td>
<td><code>K3S_DATASTORE_CERTFILE</code></td>
<td>TLS certificate file used for client certificate based authentication to your datastore. To use this feature, your datastore must be configured to support client certificate based authentication. If you specify this parameter, you must also specify the <code>datastore-keyfile</code> parameter.</td>
</tr>

<tr>
<td><span style="white-space: nowrap"><code>--datastore-keyfile</code></span></td>
<td><code>K3S_DATASTORE_KEYFILE</code></td>
<td>TLS key file used for client certificate based authentication to your datastore. See the previous <code>datastore-certfile</code> parameter for more details.</td>
</tr>
</tbody>
</table>


### Quick ETCD

I found one that should work :

```bash
git clone https://github.com/dwilbraham/docker-compose-etcd
cd docker-compose-etcd/
git clone https://github.com/henszey/etcd-browser/ etcd-browser/
dcoker-compose up -d
```

* And now the source code for that `etcd` s in this repo :
  * So here is how to bring it up : `cd documentation/etcd/example && docker-compose up -d`
  * And how to test ETCD is fine, there and ready :

```bash
etcd=$(bin/service_address.sh etcd0 2379)
curl $etcd/v2/keys
curl $etcd/v2/keys/foo -XPUT -d value=bar

etcd_all="{$(bin/service_address.sh etcd0 2379),$(bin/service_address.sh etcd1 2379),$(bin/service_address.sh etcd2 2379)}"
curl $etcd_all/v2/keys

curl $etcd_all/v2/stats/leader
```

  * stdout of the test (expected `mocha chai http`):
```bash
jbl@pc-alienware-jbl:~/docker-compose-etcd$ etcd=$(bin/service_address.sh etcd0 2379)
jbl@pc-alienware-jbl:~/docker-compose-etcd$ curl $etcd/v2/keys
{"action":"get","node":{"dir":true}}
jbl@pc-alienware-jbl:~/docker-compose-etcd$ curl $etcd/v2/keys/foo -XPUT -d value=bar
{"action":"set","node":{"key":"/foo","value":"bar","modifiedIndex":8,"createdIndex":8}}
jbl@pc-alienware-jbl:~/docker-compose-etcd$
jbl@pc-alienware-jbl:~/docker-compose-etcd$ etcd_all="{$(bin/service_address.sh etcd0 2379),$(bin/service_address.sh etcd1 2379),$(bin/service_address.sh etcd2 2379)}"
jbl@pc-alienware-jbl:~/docker-compose-etcd$ curl $etcd_all/v2/keys

[1/3]: localhost:32770/v2/keys --> <stdout>
--_curl_--localhost:32770/v2/keys
{"action":"get","node":{"dir":true,"nodes":[{"key":"/foo","value":"bar","modifiedIndex":8,"createdIndex":8}]}}

[2/3]: localhost:32769/v2/keys --> <stdout>
--_curl_--localhost:32769/v2/keys
{"action":"get","node":{"dir":true,"nodes":[{"key":"/foo","value":"bar","modifiedIndex":8,"createdIndex":8}]}}

[3/3]: localhost:32768/v2/keys --> <stdout>
--_curl_--localhost:32768/v2/keys
{"action":"get","node":{"dir":true,"nodes":[{"key":"/foo","value":"bar","modifiedIndex":8,"createdIndex":8}]}}
jbl@pc-alienware-jbl:~/docker-compose-etcd$
jbl@pc-alienware-jbl:~/docker-compose-etcd$ curl $etcd_all/v2/stats/leader

[1/3]: localhost:32770/v2/stats/leader --> <stdout>
--_curl_--localhost:32770/v2/stats/leader
{"message":"not current leader"}
[2/3]: localhost:32769/v2/stats/leader --> <stdout>
--_curl_--localhost:32769/v2/stats/leader
{"leader":"ade526d28b1f92f7","followers":{"cf1d15c5d194b5c9":{"latency":{"current":0.002654,"average":0.0043555,"standardDeviation":0.003814415289398888,"minimum":0.001218,"maximum":0.01348},"counts":{"fail":0,"success":8}},"d282ac2ce600c1ce":{"latency":{"current":0.001708,"average":0.0042092499999999995,"standardDeviation":0.002915217005215907,"minimum":0.001708,"maximum":0.009956},"counts":{"fail":0,"success":8}}}}
[3/3]: localhost:32768/v2/stats/leader --> <stdout>
--_curl_--localhost:32768/v2/stats/leader
{"message":"not current leader"}jbl@pc-alienware-jbl:~/docker-compose-etcd$

```

## The Etcd Browser for the Etcd external datastore service for the K3D cluster

https://rancher.com/docs/k3s/latest/en/installation/ha/

![the Etcd Browser](./documentation/images/etcd/ETCD_BROWSER_FOR_MY_K3D_CLUSTER_2020-07-07 00-59-01.png)

So in here , will we see things happen because of the `k3d` `Kubernetes` Cluster, iusing this `etcd` service as external db


## `K3S` Architecture for high availability

* Default arhchtiecture for `k3s` is one server and an embedded datastore in the one unique server :

![one server](./documentation/k3s-architecture/K3S_ARCHITECTURE_1_2020-07-06T23-31-48.796Z.png)

* `HA` arhchtiecture for `k3s` is many servers and an external datastore :

![HA is many servers and external datastore](./documentation/k3s-architecture/K3S_HA_ARCHITECTURE_Firefox_Screenshot_2020-07-06T23-32-50.009Z.png)

* Also, It is possible that in the current verison of `k3d` I work with, version `3.0.0-rc.6` there is an option for external datastore https://github.com/rancher/k3d/issues/232
