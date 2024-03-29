{ pkgs, ... }:
let zellij_plugins = (pkgs.callPackage ../pkgs/zellij_plugins.nix { });
in {
  home = {
    file = {
      ".config/zellij/config.kdl".text = ''
          pane_frames false
          scroll_buffer_size 100000
          session_serialization false
          theme "catppuccin-latte"
          copy_on_select true
          default_layout "default"

          plugins {
            tab-bar { path "tab-bar"; }
            // status-bar { path "status-bar"; }
            strider { path "strider"; }
            compact-bar { path "compact-bar"; }
            session-manager { path "session-manager"; }
          }

          keybinds clear-defaults=true {
          	normal { }
          	shared_except "normal" { }

          	shared_except "normal" "entersearch" {
          		bind "Enter" { SwitchToMode "Normal";}
          	}

          	locked {
          		bind "F12" { SwitchToMode "Normal"; }
          	}
          	shared_except "locked" {
          		bind "F12" { SwitchToMode "Locked"; }
          	}

          	resize {  }
          	shared_except "resize" { }

          	pane {  }
          	shared_except "pane" { }

          	move {  }
          	shared_except "move" { }

          	tab {  }
          	shared_except "tab" { }

          	scroll {
        	    // Switch back to tmux
              bind "Ctrl z" { SwitchToMode "Tmux"; }
          		bind "Esc" "Ctrl c" { SwitchToMode "Normal"; }

              bind "d" { HalfPageScrollDown; }
              bind "u" { HalfPageScrollUp; }
              bind "j" { ScrollDown; }
              bind "k" { ScrollUp; }
          		bind "b" { ScrollToBottom; }
          		bind "t" { ScrollToTop; }

          		bind "c" { SearchToggleOption "CaseSensitivity"; }
              bind "w" { SearchToggleOption "Wrap"; }
              bind "o" { SearchToggleOption "WholeWord"; }
          	}
          	shared_except "scroll" { }

          	search { 
        	    // Switch back to tmux
              bind "Ctrl a" { SwitchToMode "Tmux"; }
          		bind "Esc" "Ctrl c" { SwitchToMode "Normal"; }

              bind "e" { EditScrollback; SwitchToMode "Normal"; }
              bind "s" { SwitchToMode "EnterSearch"; SearchInput 0; }
              bind "j" { ScrollDown; }
              bind "k" { ScrollUp; }
              bind "d" { HalfPageScrollDown; }
              bind "u" { HalfPageScrollUp; }
          		bind "b" { ScrollToBottom; }
          		bind "t" { ScrollToTop; }
          		bind "n" { Search "down"; }
              bind "p" { Search "up"; }
          	}
          	shared_except "search" { }

          	entersearch { 
          		bind "Ctrl c" "Esc" { SwitchToMode "Normal"; }
          		bind "Enter" { SwitchToMode "Search"; }
          	}
          	shared_except "entersearch" { }

          	renametab { 
          		bind "Ctrl c" "Esc" { UndoRenameTab; SwitchToMode "Normal"; }
          	}
          	shared_except "renametab" { }

          	renamepane { 
          		bind "Ctrl c" "Esc" { UndoRenamePane; SwitchToMode "Normal"; }
          	}
          	shared_except "renamepane" { }

          	session { 
        	    // Switch back to tmux
              bind "Ctrl o" { SwitchToMode "Tmux"; }

        	    bind "d" { Detach; }
          		bind "Ctrl q" { Quit; }
        	    bind "w" {
                LaunchOrFocusPlugin "zellij:session-manager" {
                  floating true
                  move_to_focused_tab true
                };
                SwitchToMode "Normal"
              }
          	}
          	shared_except "session" { }

          	tmux  {
        	    // go to other modes
          		bind "Ctrl e" { SwitchToMode "EnterSearch"; SearchInput 0; }
          		bind "Ctrl a" { SwitchToMode "Search"; }
          		bind "Ctrl s" { SwitchToMode "Normal"; }
          		bind "Ctrl o" { SwitchToMode "Session"; }
          		bind "Ctrl z" { SwitchToMode "Scroll"; }

          		// Pane management
              bind "h" { MoveFocus "Left"; }
              bind "l" { MoveFocus "Right"; }
              bind "j" { MoveFocus "Down"; }
              bind "k" { MoveFocus "Up"; }
          		bind "n" { NewPane; SwitchToMode "Normal"; }
          		bind "s" { NewPane "Down"; SwitchToMode "Normal"; } 
          		bind "v" { NewPane "Right"; SwitchToMode "Normal"; } 
          		bind "p" { SwitchFocus; }
          		bind "x" { CloseFocus; SwitchToMode "Normal"; }
          		bind "f" { ToggleFocusFullscreen; SwitchToMode "Normal"; }
          		bind "w" { ToggleFloatingPanes; SwitchToMode "Normal"; }
          		bind "e" { TogglePaneEmbedOrFloating; SwitchToMode "Normal"; }
          		bind "b" { BreakPane; SwitchToMode "Normal"; }
          		bind "}" { BreakPaneRight; SwitchToMode "Normal"; }
          		bind "{" { BreakPaneLeft; SwitchToMode "Normal"; }
          		bind "Tab" { ToggleTab; }

          		// Pane movement
              bind "H" { MovePane "Left"; }
              bind "L" { MovePane "Right"; }
              bind "J" { MovePane "Down"; }
              bind "K" { MovePane "Up"; }
          		bind ")" { MovePane; }
          		bind "(" { MovePaneBackwards; }

          		// Pane resize
          		bind "Ctrl h" { Resize "Increase Left"; }
          		bind "Ctrl l" { Resize "Increase Right"; }
          		bind "Ctrl j" { Resize "Increase Down"; }
          		bind "Ctrl k" { Resize "Increase Up"; }
          		bind "Ctrl H" { Resize "Decrease Left"; }
          		bind "Ctrl L" { Resize "Decrease Right"; }
          		bind "Ctrl J" { Resize "Decrease Down"; }
          		bind "Ctrl K" { Resize "Decrease Up"; }

          		// Tab management
          		bind "t" { NewTab; SwitchToMode "Normal"; }
          		bind "1" { GoToTab 1; SwitchToMode "Normal"; }
              bind "2" { GoToTab 2; SwitchToMode "Normal"; }
              bind "3" { GoToTab 3; SwitchToMode "Normal"; }
              bind "4" { GoToTab 4; SwitchToMode "Normal"; }
              bind "5" { GoToTab 5; SwitchToMode "Normal"; }
              bind "6" { GoToTab 6; SwitchToMode "Normal"; }
              bind "7" { GoToTab 7; SwitchToMode "Normal"; }
              bind "8" { GoToTab 8; SwitchToMode "Normal"; }
              bind "9" { GoToTab 9; SwitchToMode "Normal"; }
              bind "0" { GoToTab 10; SwitchToMode "Normal"; }
          		bind "[" { GoToPreviousTab; }
          		bind "]" { GoToNextTab; }
          		bind "X" { CloseTab; }
          		bind "S" { ToggleActiveSyncTab; SwitchToMode "Normal"; }
          		bind "," { SwitchToMode "RenameTab"; TabNameInput 0; }

          		// Additional
          		// Clear scrollback buffer of the focused pane
          		bind "Ctrl z" { Clear; }
          		bind "?" {
                LaunchOrFocusPlugin "file:${zellij_plugins.zellij_forgot}/plugins/zellij_forgot.wasm" {
                  "switch to entersearch mode" "C-s -> C-e"
                  "switch to search mode" "C-s -> C-a"
                  "toggle normal/tmux mode" "C-s"
                  "switch to session mode" "C-s -> C-o"
                  "switch to scroll mode" "C-s -> C-z"

                  "focus pane left" "C-s -> h"
                  "focus pane right" "C-s -> l"
                  "focus pane down" "C-s -> j"
                  "focus pane up" "C-s -> k"
                  "new pane" "C-s -> n"
                  "new pane down" "C-s -> s"
                  "new pane right" "C-s -> v"
                  "switch focused pane" "C-s -> p"
                  "close focused pane" "C-s -> x"
                  "toggle full screen" "C-s -> f"
                  "toggle floating panes" "C-s -> w"
                  "toggle embed/float pane" "C-s -> e"
                  "toggle break pane" "C-s -> b"
                  "toggle break pane right" "C-s -> }"
                  "toggle break pane left" "C-s -> {"
                  "toggle tab" "C-s -> Tab"

                  "move pane left" "C-s -> H"
                  "move pane right" "C-s -> L"
                  "move pane down" "C-s -> J"
                  "move pane up" "C-s -> K"
                  "move pane" "C-s -> )"
                  "move pane backwards" "C-s -> ("

                  "increase pane size left" "C-s -> C-h"
                  "increase pane size right" "C-s -> C-l"
                  "increase pane size down" "C-s -> C-j"
                  "increase pane size up" "C-s -> C-k"
                  "decrease pane size left" "C-s -> C-H"
                  "decrease pane size right" "C-s -> C-L"
                  "decrease pane size down" "C-s -> C-J"
                  "decrease pane size up" "C-s -> C-K"

                  "new tab" "C-s -> t"
                  "go to tab 1" "C-s -> 1"
                  "go to tab 2" "C-s -> 2"
                  "go to tab 3" "C-s -> 3"
                  "go to tab 4" "C-s -> 4"
                  "go to tab 5" "C-s -> 5"
                  "go to tab 6" "C-s -> 6"
                  "go to tab 7" "C-s -> 7"
                  "go to tab 8" "C-s -> 8"
                  "go to tab 9" "C-s -> 9"
                  "go to tab 10" "C-s -> 0"
                  "go to previous tab" "C-s -> ["
                  "go to next tab" "C-s -> ]"
                  "close tab" "C-s -> X"
                  "toggle tab sync" "C-s -> S"
                  "rename tab" "C-s -> ,"

                  "clear scrollback of focused buffer" "C-s -> C-z"
                  "help" "C-s -> ?"

                  "[entersearch] cancel search" "C-c || Esc"
                  "[entersearch] submit" "Enter"

                  "[scroll] switch back to tmux" "C-z"
                  "[scroll] cancel search" "C-c || Esc"
                  "[scroll] scroll half page down" "d"
                  "[scroll] scroll half page up" "u"
                  "[scroll] scroll down" "j"
                  "[scroll] scroll up" "k"
                  "[scroll] scroll to bottom" "b"
                  "[scroll] scroll to top" "t"
                  "[scroll] toggle search case sensitivity" "c"
                  "[scroll] toggle search wrap" "w"
                  "[scroll] toggle search whole word" "o"
                  
                  "[session] switch back to tmux" "C-o"
                  "[session] deatch" "d"
                  "[session] quit" "C-q"
                  "[session] launch sesison manager" "w"

                  "[search] switch back to tmux" "C-a"
                  "[search] switch back to normal" "C-c || Esc"
                  "[search] edit scrollback" "e"
                  "[search] switch to entersearch" "s"
                  "[search] scroll half page down" "d"
                  "[search] scroll half page up" "u"
                  "[search] scroll down" "j"
                  "[search] scroll up" "k"
                  "[search] scroll to bottom" "b"
                  "[search] scroll to top" "t"
                  "[search] search down" "n"
                  "[search] search up" "p"

                  floating true
                }; SwitchToMode "Normal";	
          		}
          	}
          	shared_except "tmux" {
          		bind "Ctrl s" { SwitchToMode "Tmux"; }
          	}
          }
      '';
      ".config/zellij/layouts/default.kdl".text = ''
        layout {
          pane size=1 borderless=true {
            plugin location="file:${zellij_plugins.zjstatus}/plugins/zjstatus.wasm" {
              format_left  "#[bg=#CCD0DA]{mode}#[bg=#CCD0DA] | {tabs}"
              format_right "#[fg=#ACB0BE,bg=#CCD0DA,bold]{session}"
              format_space "#[bg=#CCD0DA]"

              mode_normal        "#[fg=#5C5F77,bg=#CCD0DA] {name} "
              mode_locked        "#[fg=#E64553,bg=#CCD0DA] {name} "
              mode_resize        "#[fg=#E64553,bg=#CCD0DA] {name} "
              mode_pane          "#[fg=#E64553,bg=#CCD0DA] {name} "
              mode_tab           "#[fg=#E64553,bg=#CCD0DA] {name} "
              mode_scroll        "#[fg=#E64553,bg=#CCD0DA] {name} "
              mode_enter_search  "#[fg=#E64553,bg=#CCD0DA] {name} "
              mode_search        "#[fg=#E64553,bg=#CCD0DA] {name} "
              mode_rename_tab    "#[fg=#E64553,bg=#CCD0DA] {name} "
              mode_rename_pane   "#[fg=#E64553,bg=#CCD0DA] {name} "
              mode_session       "#[fg=#E64553,bg=#CCD0DA] {name} "
              mode_move          "#[fg=#E64553,bg=#CCD0DA] {name} "
              mode_prompt        "#[fg=#E64553,bg=#CCD0DA] {name} "
              mode_tmux          "#[fg=#40A02B,bg=#CCD0DA] {name} "

              tab_normal   "#[fg=#6C6F85,bg=#CCD0DA] {name} "
              tab_active   "#[fg=#40a02b,bg=#CCD0DA,bold,italic] {name} "
            }
          }
          pane borderless=true
        }
      '';
      # ../files/zellij_default_layout.kdl;
    };
    packages = [ zellij_plugins.zjstatus zellij_plugins.zellij_forgot ];
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
