# The best I can do with k3s



### Provision

* The first thing we need to do with k3s, is to install it.
* The way I want to install it, is a high availability mode :
  * the best way yot do that, as i found out, is to use `k3d`, also released by `Rancher` : https://k3d.io/



## IAAC Cycle

```bash
# ~/k3s-topgun$
export URI_REPO=https://github.com/pokusio/k3s-topgun.git
git clone ${URI_REPO} ~/k3s-topgun
cd ~/k3s-topgun
export FEATURE_ALIAS="k3d-install"
git checkout feature/${FEATURE_ALIAS}

export COMMIT_MESSAGE="feat. ${FEATURE_ALIAS} : "
export COMMIT_MESSAGE="${COMMIT_MESSAGE} Ajout de la recette d'installation K3S avec 3 masters "

# git flow feature start ${FEATURE_ALIAS}

git add --all && git commit -m "${COMMIT_MESSAGE}" && git push -u origin HEAD


# git push -u origin --all && git push -u origin --tags


```

# Docs references

* https://k3d.io/usage/commands/
* https://rancher.com/docs/k3s/latest/en/installation/install-options/server-config/#k3s-server-cli-help :  all those options you can pass from `k3d` to `k3s` server,  using tehe `k3d` ` --server-arg "<K3S OPTION>"`. Example  `--server-arg "--no-deploy=traefik"`
* an interesting option is for setting the TLS Certs for the `KUBECONFIG` SAN :
  * `--tls-san value`  (listener) Add additional hostname or IP as a Subject Alternative Name in the TLS cert
  * `k3d create cluster topgunCluster --server-arg "--no-deploy=traefik" --server-arg  "--tls-san value"` --masters 5 --workers 9 --api-port "0.0.0.0:6551"


## The TLS Certs in the KUBECONFIG

Oh les salopards, comme elle était chiante à rtrovuer celle-là :

```bash
docker version
kubectl version
uname -a
k3d version
k3d create cluster --help
```
* outputs :

```bash
jbl@pc-alienware-jbl:~$ docker version
Client: Docker Engine - Community
 Version:           19.03.8
 API version:       1.40
 Go version:        go1.12.17
 Git commit:        afacb8b7f0
 Built:             Wed Mar 11 01:26:02 2020
 OS/Arch:           linux/amd64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          19.03.8
  API version:      1.40 (minimum version 1.12)
  Go version:       go1.12.17
  Git commit:       afacb8b7f0
  Built:            Wed Mar 11 01:24:36 2020
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.2.13
  GitCommit:        7ad184331fa3e55e52b890ea95e65ba581ae3429
 runc:
  Version:          1.0.0-rc10
  GitCommit:        dc9208a3303feef5b3839f4323d9beb36df0a9dd
 docker-init:
  Version:          0.18.0
  GitCommit:        fec3683

jbl@pc-alienware-jbl:~$ kubectl version --client
Client Version: version.Info{Major:"1", Minor:"18", GitVersion:"v1.18.0", GitCommit:"9e991415386e4cf155a24b1da15becaa390438d8", GitTreeState:"clean", BuildDate:"2020-03-25T14:58:59Z", GoVersion:"go1.13.8", Compiler:"gc", Platform:"linux/amd64"}
jbl@pc-alienware-jbl:~$ uname -a
Linux pc-alienware-jbl 4.9.0-7-amd64 #1 SMP Debian 4.9.110-3+deb9u2 (2018-08-13) x86_64 GNU/Linux
jbl@pc-alienware-jbl:~$ k3d version
k3d version v3.0.0-beta.0
jbl@pc-alienware-jbl:~$ k3d create cluster --help

Create a new k3s cluster with containerized nodes (k3s in docker).
Every cluster will consist of at least 2 containers:
	- 1 master node container (k3s)
	- 1 loadbalancer container as the entrypoint to the cluster (nginx)

Usage:
  k3d create cluster NAME [flags]

Flags:
  -a, --api-port --api-port [HOST:]HOSTPORT                            Specify the Kubernetes API server port exposed on the LoadBalancer (Format: --api-port [HOST:]HOSTPORT)
                                                                        - Example: `k3d create -m 3 -a 0.0.0.0:6550` (default "6443")
  -h, --help                                                           help for cluster
  -i, --image string                                                   Specify k3s image that you want to use for the nodes (default "docker.io/rancher/k3s:v1.17.4-k3s1")
      --k3s-agent-arg k3s agent                                        Additional args passed to the k3s agent command on worker nodes (new flag per arg)
      --k3s-server-arg k3s server                                      Additional args passed to the k3s server command on master nodes (new flag per arg)
  -m, --masters int                                                    Specify how many masters you want to create (default 1)
      --network string                                                 Join an existing network
      --no-image-volume                                                Disable the creation of a volume for importing images
  -p, --port [HOST:][HOSTPORT:]CONTAINERPORT[/PROTOCOL][@NODEFILTER]   Map ports from the node containers to the host (Format: [HOST:][HOSTPORT:]CONTAINERPORT[/PROTOCOL][@NODEFILTER])
                                                                        - Example: `k3d create -w 2 -p 8080:80@worker[0] -p 8081@worker[1]`
      --secret string                                                  Specify a cluster secret. By default, we generate one.
      --timeout duration                                               Rollback changes if cluster couldn't be created in specified duration.
      --update-kubeconfig                                              Directly update the default kubeconfig with the new cluster's context
  -v, --volume --volume [SOURCE:]DEST[@NODEFILTER[;NODEFILTER...]]     Mount volumes into the nodes (Format: --volume [SOURCE:]DEST[@NODEFILTER[;NODEFILTER...]]
                                                                        - Example: `k3d create -w 2 -v /my/path@worker[0,1] -v /tmp/test:/tmp/other@master[0]`
      --wait                                                           Wait for the master(s) to be ready before returning. Use '--timeout DURATION' to not wait forever.
  -w, --workers int                                                    Specify how many workers you want to create

Global Flags:
  -r, --runtime string   Choose a container runtime environment [docker, containerd] (default "docker")
      --verbose          Enable verbose output (debug logging)
jbl@pc-alienware-jbl:~$

```

le problème c'est que l'option `--server-arg` ne fonctionne pas avec un `K3D` version `3.x`..

mais j'ai trouvé l'alternative :

```bash
k3d create cluster --k3s-server-arg "k3s server --tls-san example.com" topgunCluster --masters 5 --workers 9 --api-port "0.0.0.0:6551"
export KUBECONFIG=$(k3d get kubeconfig topgunCluster)
kubectl get all,nodes --all-namespaces
cat $KUBECONFIG
```

* tried another (so much fun) :

```bash
# this one works with no error for sure
k3d create cluster --k3s-server-arg "k3s server --tls-san 192.168.1.28" topgunCluster --masters 5 --workers 9

# I also tried those ones :
# k3d create cluster --k3s-server-arg "k3s server --tls-san 'alien.io,192.168.1.28,k3s.alien.io'" topgunCluster --masters 5 --workers 9
# k3d create cluster --k3s-server-arg "k3s server --tls-san '192.168.1.28'"  --k3s-agent-arg "k3s agent --tls-san '192.168.1.28'" topgunCluster --masters 5 --workers 9

```

* clean evertyhing up when k3d created cluster start to get crazy...

```bash
k3d delete cluster topgunCluster
sudo rm /etc/docker/*.json
docker system prune -f --all && docker system prune -f --volumes
sudo systemctl daemon-reload
sudo systemctl restart docker

```
