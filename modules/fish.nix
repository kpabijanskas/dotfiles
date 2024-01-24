{ pkgs, ... }:
let isLinux = pkgs.stdenv.isLinux;
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
      } else
        { });

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
          cd ~/repos/github.com/kpabijanskas/dotfiles
          nix-channel --update
          nix flake update
          rm ./generated/*
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
        zellij.body = ''
          if count $argv > /dev/null
            ${pkgs.zellij}/bin/zellij $argv
          else
            ${pkgs.zellij}/bin/zellij a --create
          end
        '';
        project.body = ''
          set DIRECTORIES ~/repos
          set -a DIRECTORIES ~/workspaces

          for dir in $DIRECTORIES 
            set repo_list $(fd '\.git$' $dir --prune -utd | sed 's/\/\.git\/$//g'|awk '{ if (NR == 1 || !index($0, prev)) { print; prev = $0 } }')
            for repo in $repo_list
              set -a REPOS $repo
            end
          end


          set TARGET $(echo $REPOS | tr ' ' '\n' |fzf)
          if test -z $TARGET
            return
          end

          cd $TARGET
        '';
        pro.body = "project";
      };

    };
  };
}
