{
  inputs,
  pkgs,
  ...
}: 
let
  add_project_todo = pkgs.writeScriptBin "add_project_todo" ''
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
  '';
  project_todos = pkgs.writeScriptBin "project_todos" ''
    #!/bin/fish

    set PROJECT $(git rev-parse --show-toplevel|xargs -I {} basename {})
    if set -q PROJECT[1]
      pter -s (string join " " $PROJECT +code)
    else
      echo "no repo set"
    end
  '';
  open_project_file = pkgs.writeScriptBin "open_project_file" ''
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
  '';
in {
  home = {
    packages =  [
      inputs.ejson-templater.packages.x86_64-linux.default
      inputs.exec-lsp.packages.x86_64-linux.default
      add_project_todo
      project_todos
      open_project_file
    ];
    file = {
      ".config/execlsp.ini" = {
        source = ../files/execlsp.ini;
      };
    };
  };
}
