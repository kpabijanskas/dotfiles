#!/bin/fish

set PROJECT $(git rev-parse --show-toplevel|xargs -I {} basename {})
if set -q PROJECT[1]
  pter -s (string join " " $PROJECT +code)
else
  echo "no repo set"
end
