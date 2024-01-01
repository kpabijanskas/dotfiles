{
  inputs,
  ...
}: {
  home = {
    packages =  [
      inputs.ejson-templater.packages.x86_64-linux.default
      inputs.exec-lsp.packages.x86_64-linux.default
    ];
    file = {
      ".config/execlsp.ini" = {
        source = ../files/execlsp.ini;
      };
      "bin/add_project_todo.fish" = {
        source = ../files/add_project_todo.fish;
        executable = true;
      };
      "bin/project_todos.fish" = {
        source = ../files/project_todos.fish;
        executable = true;
      };
    };
  };
}
