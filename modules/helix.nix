{ pkgs, ... }: {
  programs = {
    helix = {
      enable = true;
      extraPackages = with pkgs; [
        dockerfile-language-server-nodejs
        emmet-ls
        gofumpt
        goimports-reviser
        gopls
        lua-language-server
        nil
        nixfmt
        nodePackages.bash-language-server
        nodePackages.vscode-json-languageserver
        nodePackages.svelte-language-server
        nodePackages.typescript-language-server
        nodePackages.vscode-html-languageserver-bin
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
          rulers = [ 120 ];
          idle-timeout = 0;
          completion-trigger-len = 1;
          bufferline = "multiple";
          statusline = {
            left = [
              "mode"
              "separator"
              "version-control"
              "separator"
              "spinner"
              "file-name"
            ];
            right = [
              "diagnostics"
              "separator"
              "workspace-diagnostics"
              "separator"
              "selections"
              "separator"
              "file-type"
              "position-percentage"
              "position"
            ];
            mode.normal = "NORMAL";
            mode.insert = "INSERT";
            mode.select = "SELECT";
          };
          auto-pairs = {
            "(" = ")";
            "{" = "}";
            "[" = "]";
            "'" = "'";
            "\"" = ''"'';
            "`" = "`";
            "<" = ">";
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
          lsp = { display-inlay-hints = true; };
          soft-wrap = { enable = true; };
          indent-guides = {
            render = true;
            character = "╎";
            skip-levels = 1;
          };
        };
        keys = {
          insert = { j = { k = "normal_mode"; }; };
          normal = {
            esc = [ "collapse_selection" "keep_primary_selection" ];
            C-r = {
              p = ":run-shell-command zellij run -f -- git pull";
              o = ":run-shell-command zellij run -fc -- open_project_file";
              C-r = ":lsp-restart";
            };
            C-s = "no_op";
            C-d =
              "save_selection"; # C-s is overriden by zellij so move it to C-d
            space = {
              C-w = ":write!";
              C-x = ":write-quit-all!";
            };
            C-e = [ ":lsp-workspace-command" ];
          };
        };
      };
      languages = {
        language = [
          {
            name = "go";
            auto-format = true;
            language-servers = [ "gopls" ];
            formatter = {
              command = "bash";
              args =
                [ "-c" "goimports|goimports-reviser -format |gofumpt -extra" ];
            };
          }
          {
            name = "gotmpl";
            auto-format = true;
            # language-servers = [ "gopls" ];
            # formatter = {
            #   command = "bash";
            #   args =
            #     [ "-c" "goimports|goimports-reviser -format |gofumpt -extra" ];
            # };
            language-servers = [ "gopls" "emmet-ls" ];
          }
          {
            name = "nix";
            auto-format = true;
            formatter = { command = "nixfmt"; };
          }
          {
            name = "html";
            auto-format = true;
            language-servers = [ "html-languageserver" ];
          }
          {
            name = "css";
            auto-format = true;
            language-servers = [ "css-languageserver" ];
          }
          {
            name = "scss";
            auto-format = true;
            language-servers = [ "css-languageserver" ];
          }
          {
            name = "javascript";
            auto-format = true;
            indent = {
              tab-width = 4;
              unit = " ";
            };
          }
          {
            name = "typescript";
            auto-format = true;
            indent = {
              tab-width = 4;
              unit = " ";
            };
          }
          {
            name = "jsx";
            auto-format = true;
            indent = {
              tab-width = 4;
              unit = " ";
            };
          }
          {
            name = "tsx";
            auto-format = true;
            indent = {
              tab-width = 4;
              unit = " ";
            };
          }
          {
            name = "svelte";
            auto-format = true;
            indent = {
              tab-width = 4;
              unit = " ";
            };
          }
          {
            name = "c";
            auto-format = true;
            indent = {
              tab-width = 4;
              unit = " ";
            };
          }
          {
            name = "markdown";
            language-servers = [ "zk" ];
            indent = {
              tab-width = 4;
              unit = " ";
            };
            rulers = [ ];
          }
        ];
        language-server = {
          zk = {
            command = "${pkgs.zk}/bin/zk";
            args = [
              "lsp"
              "--notebook-dir"
              "/home/karolispabijanskas/notes"
              "--no-input"
            ];
          };
          emmet-ls = {
            command = "${pkgs.emmet-ls}/bin/emmet-ls";
            args = [ "--stdio" ];
          };
          html-languageserver = {
            command =
              "${pkgs.nodePackages.vscode-html-languageserver-bin}/bin/html-languageserver";
          };
          gopls = {
            config = {
              "formatting.gofumpt" = true;
              "ui.diagnostic.staticcheck" = true;
              "ui.diagnostic.vulncheck" = "Imports";
              "ui.diagnostic.analyses" = {
                "shadow" = false;
                "useany" = true;
                "unusedvariable" = true;
              };
              "build.templateExtensions" = [ "gotmpl" "tmpl" ];
            };
          };
        };
      };
    };
  };
}
