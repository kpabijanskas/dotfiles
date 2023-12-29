{
  ...
}: {
  programs = {
    atuin = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      settings = {
        update_check = false;
      };
    };
  };
}
