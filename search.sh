#!/bin/bash

cd /home/sam/git/code-search/all_repos/

mode=$(fzf --no-sort << EOF
pattern
project
file
open
EOF
)

if [ "$mode" == "pattern" ]; then
  read -p "Extension: " extension

  while :; do
    read -p "Pattern (ctrl+d to exit): " pattern || break
    grep --exclude-dir=".git" -n --color=always -r --include "*$extension" "$pattern" .
    grep --exclude-dir=".git" -l -r --include "*$extension" "$pattern" . > /tmp/recent_matches
    grep --exclude-dir=".git" -r --include "*$extension" "$pattern" . | wc -l | tr -d '\n'
    echo " results found."
  done
elif [ "$mode" == "project" ]; then
  dir=$(ls | fzf)
  cd $dir && $SHELL
elif [ "$mode" == "open" ]; then
  fzf < /tmp/recent_matches | xargs cleanvim
elif [ "$mode" == "file" ]; then
  find | fzf | xargs cleanvim
fi
