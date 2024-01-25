{ ... }: {
  home.file = {
    ".config/zellij/config.kdl".source = ../files/zellij_config.kdl;
    ".config/zellij/layouts/default.kdl".source =
      ../files/zellij_default_layout.kdl;
  };
  programs = {
    zellij = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };
  };
}
