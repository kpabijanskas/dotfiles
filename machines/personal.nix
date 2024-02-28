# This is actually a macmini, but my dev env is a Fedora box in OrbStack
{ inputs, system, ... }: {
  config = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages."${system}";
    extraSpecialArgs = { inherit inputs system; };
    modules = [
      {
        home = {
          username = "karolispabijanskas";
          homeDirectory = "/home/karolispabijanskas";
        };
      }
      ../modules/general.nix
      ../modules/exercism.nix
      ../modules/zellij.nix
      ../modules/atuin.nix
      ../modules/bat.nix
      ../modules/direnv.nix
      ../modules/fish.nix
      ../modules/fzf.nix
      ../modules/git.nix
      ../modules/nvim.nix
    ];
  };
}
