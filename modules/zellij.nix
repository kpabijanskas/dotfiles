{ pkgs, ... }:
let zellij_plugins = (pkgs.callPackage ../pkgs/zellij_plugins.nix { });
in {
  home = {
    file = {
      ".config/zellij/config.kdl".source = ../files/zellij_config.kdl;
      ".config/zellij/layouts/default.kdl".text = ''
        layout {
          pane size=1 borderless=true {
            plugin location="file:${zellij_plugins.zjstatus}/plugins/zjstatus.wasm" {
              format_left  "{mode} | {tabs}"
              format_right "#[fg=#ACB0BE,bold]{session}"
              format_space ""

              border_enabled  "false"
              hide_frame_for_single_pane "false"

              mode_normal        "#[fg=#5C5F77] {name} "
              mode_locked        "#[fg=#E64553] {name} "
              mode_resize        "#[fg=#E64553] {name} "
              mode_pane          "#[fg=#E64553] {name} "
              mode_tab           "#[fg=#E64553] {name} "
              mode_scroll        "#[fg=#E64553] {name} "
              mode_enter_search  "#[fg=#E64553] {name} "
              mode_search        "#[fg=#E64553] {name} "
              mode_rename_tab    "#[fg=#E64553] {name} "
              mode_rename_pane   "#[fg=#E64553] {name} "
              mode_session       "#[fg=#E64553] {name} "
              mode_move          "#[fg=#E64553] {name} "
              mode_prompt        "#[fg=#E64553] {name} "
              mode_tmux          "#[fg=#40A02B] {name} "

              tab_normal   "#[fg=#6C6F85] {name} "
              tab_active   "#[fg=#40a02b,bold,italic] {name} "
            }
          }
          pane
        }
      '';
      # ../files/zellij_default_layout.kdl;
    };
    packages = [ zellij_plugins.zjstatus ];
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
