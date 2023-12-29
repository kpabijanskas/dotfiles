{
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      todo-txt-cli
      topydo
      ttdl
    ];
    file = {
      ".config/ttdl/ttdl.toml" = {
        source = ../files/ttdl.toml;
      };
      ".config/fish/completions/todotxt.fish" = {
        source = ../files/todo_fish_completion.fish ;
      };
      ".todo/config" = {
        source = ../generated/todo_config;
      };
    };
  };
  programs = {
    fish = {
      shellAliases = {
        t = "todo.sh";
			};
		};
  };
}
