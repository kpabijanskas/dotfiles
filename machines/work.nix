{ inputs, system, ... }: {
  config = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages."${system}";
    extraSpecialArgs = { inherit inputs; };
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
      ../modules/zellij.nix
      ../modules/helix.nix
      ../modules/atuin.nix
      ../modules/bat.nix
      ../modules/direnv.nix
      ../modules/fish.nix
      ../modules/fzf.nix
      ../modules/git.nix
      ../modules/kakoune.nix
      ../modules/wezterm.nix
    ];
  };
}
