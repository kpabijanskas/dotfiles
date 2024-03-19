{ pkgs, ... }:
let isLinux = pkgs.stdenv.isLinux;
in {
  programs = {
    fish = {
      enable = true;

      interactiveShellInit = ''
        set -gx PAGER most
        set -gx PATH ~/bin $PATH
        set -gx ZK_NOTEBOOK_DIR ~/notes
      '';

      shellAliases = {
        vi = "nvim";
        vim = "nvim";
        hx = "nvim";
        e = "nvim";
        dnf-up = "sudo dnf update -y --refresh";
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
          cd ~/repos/gitea.l.pabijanskas.lt/kpabijanskas/dotfiles
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
        pro.body = ''
          set SEARCH (string join " " $argv)
          set DIRECTORIES ~/repos
          set -a DIRECTORIES ~/workspaces

          for dir in $DIRECTORIES 
            set repo_list $(fd '\.git$' $dir --prune -utd | sed 's/\/\.git\/$//g'|awk '{ if (NR == 1 || !index($0, prev)) { print; prev = $0 } }')
            for repo in $repo_list
              set -a REPOS $repo
            end
          end


          set TARGET $(echo $REPOS | tr ' ' '\n' |fzf --query=$SEARCH)
          if test -z $TARGET
            return
          end

          cd $TARGET
        '';
      };

    };
  };
}
