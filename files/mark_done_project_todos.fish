#!/bin/fish
# just --list --list-heading= --list-prefix=|fzf --preview="just --show {}"|xargs -I {} just {}

set PROJECT $(git rev-parse --show-toplevel|xargs -I {} basename {})
if set -q PROJECT[1]
  todo.sh ls +code +$PROJECT | fzf |awk '{ print $1 }'|xargs -I {} todo.sh do {}
else
  echo "no repo set"
end
