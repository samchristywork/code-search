#!/bin/bash

mkdir -p all_repos
cd all_repos

gh api users/samchristywork/repos --paginate  --jq '.[] | "\(.name)"' | \
  while read repo; do
    git clone "git@github.com:samchristywork/$repo.git"
  done
