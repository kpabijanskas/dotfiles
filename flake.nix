{
  description = "My Dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    home-manager.url = "github:nix-community/home-manager/release-23.11";
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
