{
  pkgs,
  ...
}: 
let
  packageOverrides = pkgs.callPackage ./software/pter/default.nix { };
  python = pkgs.python3.override { inherit packageOverrides; };
  pythonWithPackages = python.withPackages (ps: [ ps.pter ]);
in {
  home = {
    packages = with pkgs; [
      pythonWithPackages
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
