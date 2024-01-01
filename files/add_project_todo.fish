#!/bin/fish

set FILE $(mktemp)
set DATE $(date "+%Y-%m-%d")
set PROJECT $(git rev-parse --show-toplevel|xargs -I {} basename {})
if set -q PROJECT[1]
  hx $FILE
  pter -n (string join " " $DATE $(cat $FILE) +$PROJECT +code)
else
  echo "no repo set"
end
rm $FILE
