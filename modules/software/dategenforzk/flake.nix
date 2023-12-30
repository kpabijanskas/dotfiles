{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }: 
    flake-utils.lib.eachDefaultSystem (system:
      let
        name = "dategenforzk";
        pkgs = nixpkgs.legacyPackages."${system}";
      in {
        packages.default = pkgs.buildGoModule {
          name = "${name}";

          src = ./.;

          vendorHash = null;

          meta = with pkgs.lib; {
            description = "Date generator for zk";
            license = licenses.mit;
          };
        };
      }
    );
}

