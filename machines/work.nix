{
  inputs,
  outputs,
  nixpkgs,
  home-manager,
  ...
}: {
   config = home-manager.lib.homeManagerConfiguration {
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    extraSpecialArgs = {inherit inputs outputs;};
    modules = [
      {
        home = {
          username = "karolispabijanskas";
          homeDirectory = "/home/karolispabijanskas";
        };
      }
      ../modules/general.nix
      ../modules/zk.nix
      ../modules/todo.nix
      ../modules/exercism.nix
      ../modules/devtools.nix
      ../modules/zellij.nix
      ../modules/helix.nix
      ../modules/atuin.nix
      ../modules/bat.nix
      ../modules/direnv.nix
      ../modules/fish.nix
      ../modules/fzf.nix
      ../modules/git.nix
    ];
  };
}
