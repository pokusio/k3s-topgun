# Git Flow

HEre I document the git workflow used in this repo

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
