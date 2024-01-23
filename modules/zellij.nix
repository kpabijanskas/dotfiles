{ ... }: {
  programs = {
    zellij = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      settings = {
        pane_frames = false;
        theme = "catppuccin-latte";
        scroll_buffer_size = 100000;
        session_serialization = false;
      };
    };
  };
}
