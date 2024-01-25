local wezterm = require 'wezterm';
return {
  default_prog = { '/home/karolispabijanskas/.nix-profile/bin/fish' },
  enable_scroll_bar = false,
  enable_tab_bar = false,
  font = wezterm.font "JetBrains Mono Nerd Font Mono",
  font_size = 10,
  color_scheme = "Catppuccin Latte",
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0
  },
}
