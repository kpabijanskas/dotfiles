{
  description = "My Dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ { self, ... }: {
    homeConfigurations = {
      "NS-PF43XW2B" = (import ./machines/work.nix {
        inherit inputs;
        system="x86_64-linux";
      }).config;
      "fedora" = (import ./machines/personal.nix {
        inherit inputs;
        system="aarch64-linux";
      }).config;
    };
  };
}
