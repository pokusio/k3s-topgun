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
  * le problème c'est que l'option `--server-arg` ne fonctionne pas avec un `K3D` version `3.x`
