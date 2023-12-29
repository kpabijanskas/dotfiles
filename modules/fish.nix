{
  pkgs,
  ...
}:
let
  isLinux = pkgs.stdenv.isLinux;
in {
  programs = {
    fish = {
      enable = true;

      interactiveShellInit = ''
      set -gx PAGER most
      set -gx PATH ~/bin $PATH
      '';

      shellAliases = {
        vi = "hx";
        vim = "hx";
        nvim = "hx";
        e = "hx";
        dnf-up = "sudo dnf update -y";
        flatpak-up = "sudo flatpak update -y";
        flatpak-clear = "sudo flatpak uninstall --unused -y";
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        "....." = "cd ../../../..";
      } // (if isLinux then {
        pbcopy = "wl-copy";
        pbpaste = "wl-paste";
      } else {});

      shellInit = ''
        abbr -a !! --position anywhere --function last_history_item
        for f in ~/.config/fish/completions/*.fish
          source $f
        end
      '';

      functions = {
        fish_greeting = "";
        brew-up.body = ''
          brew update
          brew upgrade
        '';
        nix-up.body = ''
          set cwd $PWD
          cd ~/nix
          nix-channel --update
          nix flake update
          ejson-templater -srcDir ./templates -secretsFile ~/.secrets.ejson -dstDir ./generated
          home-manager switch --flake path:"$PWD#$(hostname -f)" -b backup
          cd $cwd
          set -x cwd
        '';
        up.body = (if isLinux then ''
          echo ">>>> Updating DNF"
          dnf-up
          echo
          echo ">>>> Updating Nix"
          nix-up
          echo
          echo ">>>> Updating FlatPak"
          flatpak-up
          echo
          echo ">>>> Clearing Unused Flatpak"
          flatpak-clear
          echo
        '' else ''
          echo ">>>> Updating Homebrew"
          brew-up
          echo
        '');
        last_history_item.body = ''
          echo $history[1]
        '';
      };

    };
  };
}
