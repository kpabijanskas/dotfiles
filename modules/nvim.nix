{ pkgs, ... }: {
  home.packages = [ pkgs.libcxx ];
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  programs.neovim.withPython3 = true;
  programs.neovim.extraPackages = [ pkgs.fzf ];
  home.file."~/.config.nvim" = {
      enable = true;
      recursive = true;
      source = ../files/nvim;
  };
}
