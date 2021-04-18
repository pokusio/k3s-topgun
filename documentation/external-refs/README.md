# Docs references

* https://k3d.io/usage/commands/
* https://rancher.com/docs/k3s/latest/en/installation/install-options/server-config/#k3s-server-cli-help :  all those options you can pass from `k3d` to `k3s` server,  using the `k3d` ` --server-arg "<K3S OPTION>"`. Example  `--server-arg "--no-deploy=traefik"`
* an interesting option is for setting the TLS Certs for the `KUBECONFIG` SAN :
  * `--tls-san value`  (listener) Add additional hostname or IP as a Subject Alternative Name in the TLS cert
  * `k3d create cluster topgunCluster --server-arg "--no-deploy=traefik" --server-arg  "--tls-san value"` --masters 5 --workers 9 --api-port "0.0.0.0:6551"

* https://devopstales.github.io/kubernetes/k8s-metallb-bgp-pfsense/ :
  * I want to try and setup MetalLb in BGP mode instead of Layer  2 ARP mode.
  * `documentation/saved-tutorials/metallb/bgp-mode/1`

* Quick tutorial video on installing GlusterFS on 3 VMs (to then try the GlusterFS CSI in Kubernetes ) : https://www.youtube.com/watch?v=8CJbyBdxcYU
