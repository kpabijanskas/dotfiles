{ pkgs, ... }: {
  home = {
    file = { ".gitconfig" = { source = ../generated/gitconfig; }; };
    packages = [ pkgs.jujutsu ];
  };
  programs = { git.enable = true; };
}
