#!/bin/fish
set -l cwd (pwd)
set -l dir (pwd)

while not test "$dir" = '/'
  set project_name_file "$dir/.zk-project"

  if test -f "$project_name_file"
    set PROJECT_NAME $(cat $project_name_file)
    cd $cwd
    zk edit --limit=1 -M fts -m "title: \"$PROJECT_NAME\"" --tag active
    exit $status
  end

  cd $dir/..
  set dir (pwd)
end

echo "no project file found"
cd $cwd

