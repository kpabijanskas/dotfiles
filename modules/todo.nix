{
  pkgs,
  ...
}: 
let
  pter = (pkgs.callPackage ../pkgs/pter.nix { }).pter;
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
