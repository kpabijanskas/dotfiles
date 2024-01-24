{ pkgs, ... }: {
  programs.kakoune = {
    enable = true;
    plugins = with pkgs; [
      kakounePlugins.auto-pairs-kak
      kakounePlugins.fzf-kak
      kak-lsp
    ];
  };
}
