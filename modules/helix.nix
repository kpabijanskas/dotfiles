{
  pkgs,
  ...
}: let
  execlsp = pkgs.callPackage ../pkgs/execlsp.nix {};
  scripts = pkgs.callPackage ../pkgs/todo_scripts.nix {};
in {
  home = {
    file = {
      ".config/execlsp.ini" = {
        source = ../files/execlsp.ini;
      };
    };
  };
	programs = {
    helix = {
      enable = true;
      extraPackages = with pkgs; with scripts; [
        add_project_todo
        project_todos
        open_project_file
        execlsp
				dockerfile-language-server-nodejs
				gopls
				lua-language-server
        nil
				nodePackages.bash-language-server
				nodePackages.vscode-json-languageserver
				rust-analyzer
				yaml-language-server
        zk
      ];
      defaultEditor = true;
      settings = {
        theme = "catppuccin_latte";
        editor = {
          line-number = "relative";
          cursorline = true;
          cursorcolumn = true;
          mouse = false;
          true-color = true;
          idle-timeout = 0;
          completion-trigger-len = 1;
          bufferline = "multiple";
          statusline = {
            left = ["mode" "separator" "version-control" "separator" "spinner" "file-name"];
            right = ["diagnostics" "separator" "workspace-diagnostics" "separator" "selections" "separator" "file-type" "position-percentage" "position" ];
            mode.normal = "NORMAL";
            mode.insert = "INSERT";
            mode.select = "SELECT";
          };
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
          file-picker = {
            hidden = false;
            git-ignore = false;
          };
          lsp = {
            display-inlay-hints = true;
          };
          soft-wrap = {
            enable = true;
          };
        };
        keys = {
          insert = {
            j = {
              k = "normal_mode";
            };
          };
          normal =  {
            esc = ["collapse_selection" "keep_primary_selection"];
            space = {
              C-w = ":write!";
              C-x = ":write-quit-all!";
              C-R = ":lsp-restart";
            };
            C-e = [":lsp-workspace-command"];
          };
        };
      };
      languages = {
        language = [
          { name = "go"; auto-format = true; language-servers = [ "execlspgo" "gopls" ]; formatter = { command = "goimports";};}
          { name = "html"; auto-format = true; language-servers = ["html-languageserver"];}
          { name = "css"; auto-format = true; language-servers = ["css-languageserver"];}
          { name = "scss"; auto-format = true; language-servers = ["css-languageserver"];}
          { name = "javascript"; auto-format = true; indent = { tab-width = 4; unit = " ";};}
          { name = "typescript"; auto-format = true; indent = { tab-width = 4; unit = " ";};}
          { name = "jsx"; auto-format = true; indent = { tab-width = 4; unit = " ";};}
          { name = "tsx"; auto-format = true; indent = { tab-width = 4; unit = " ";};}
          { name = "svelte"; auto-format = true; indent = { tab-width = 4; unit = " ";};}
          { name = "c"; auto-format = true; indent = { tab-width = 4; unit = " ";};}
          { name = "markdown"; language-servers = [ "execlspnotes" "zk" ]; indent = { tab-width = 2; unit = " ";}; }
        ];
        language-server = {
          zk = {
            command = "${pkgs.zk}/bin/zk";
            args = ["lsp" "--notebook-dir" "/home/karolispabijanskas/notes" "--no-input"];
          };
          execlspgo = {
            command = "${execlsp}/bin/exec-lsp";
            args = ["-presets=go"];
          };
          execlspnotes = {
            command = "${execlsp}/bin/exec-lsp";
            args = ["-presets=notes"];
          };
        };
      };
    };
  };
}
