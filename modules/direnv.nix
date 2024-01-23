{ ... }: {
  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      # enableFishIntegration = true; this is always enabled by default
      nix-direnv.enable = true;
    };
  };
}
