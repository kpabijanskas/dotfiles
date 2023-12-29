{
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      git-sync
      marksman
      zk
    ];
    file = {
      ".config/zk/config.toml" = {
        source = ../files/zk_config.toml;
      };
      ".config/zk/templates/daily.md" = {
        source = ../files/zk_templates_daily.md;
      };
      ".config/zk/templates/weekly.md" = {
        source = ../files/zk_templates_weekly.md;
      };
      ".config/zk/templates/default.md" = {
        source = ../files/zk_templates_default.md;
      };
      ".config/zk/templates/wproject.md" = {
        source = ../files/zk_templates_wproject.md;
      };
      ".config/zk/templates/pproject.md" = {
        source = ../files/zk_templates_pproject.md;
      };
    };
  };
  programs = {
    helix = {
      extraPackages = with pkgs; [
        zk
        marksman
      ];
    };
  };
}
