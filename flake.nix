{
  description = "Nix on MacOS/Fedora";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    ejson-templater.url = "github:kpabijanskas/ejson-templater/v1.0.2";
    ejson-templater.inputs.nixpkgs.follows = "nixpkgs";

    exec-lsp.url = "github:kpabijanskas/exec-lsp/v1.0.0";
    exec-lsp.inputs.nixpkgs.follows = "nixpkgs";

    dategenforzk.url = "path:modules/software/dategenforzk/";
    dategenforzk.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    homeConfigurations = {
      "NS-PF43XW2B" = (import ./machines/work.nix { inherit inputs outputs nixpkgs home-manager; }).config;
    };
  };
}
