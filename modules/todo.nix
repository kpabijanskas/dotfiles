{
  pkgs,
  ...
}: 
let
  packageOverrides = pkgs.callPackage ./software/pter/default.nix { };
  python = pkgs.python3.override { inherit packageOverrides; };
  pter = python.withPackages (ps: [ ps.pter ]);
in {
  home = {
    packages = [
      pter
    ];
    file = {
      ".config/pter/pter.conf" = {
        source = ../generated/pter.conf;
      };
      ".config/pter/searches.txt" = {
        source = ../files/pter_searches.txt;
      };
    };
  };
  programs = {
    fish = {
      shellAliases = {
        p = "pter";
			};
		};
  };
}
