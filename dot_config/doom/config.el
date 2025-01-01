;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Karolis Pabijanskas"
      user-mail-address "karolis@pabijanskas.lt")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 12))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!
;; (setq doom-font (font-spec :family "JetBrains Mono Nerd Font" :size 12))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq catppuccin-flavor 'latte)
(setq doom-theme 'catppuccin)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'visual)


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(setq shell-file-name (executable-find "bash"))
(setq-default vterm-shell (executable-find "fish"))

(use-package! org-ql
  :ensure t)

(defun kp/verify-refile-target ()
  "Exclude done states from refile targets"
  (not (member (nth 2 (org-heading-components)) org-done-keywords)))

(use-package! org
  :config
  (setq-default org-reverse-datetree-level-formats
                '("%Y"
                  (lambda (time) (format-time-string "%Y-%m %B" (org-reverse-datetree-monday time)))
                  "%Y-%m W%W"
                  "%Y-%m-%d %A"))
  (setq
   org-modules '(org-habit)
   org-directory "~/Nextcloud/org/"
   org-todo-keywords '((sequence "UNPROCESSED(u)" "TODO(t)" "NEXT(n)" "|" "DONE(d)")
                       (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "MEETING(m)")
                       (sequence "PROJECT(p)" "|" "DONE(d)")
                       (sequence "GOAL(g)" "|" "DONE(d)")
                       (sequence "BUY(b)" "|" "DONE(d)"))
   org-todo-state-tags-triggers '(("CANCELLED" ("cancelled" . t))
                                  ("WAITING" "WAITING" . t)
                                  ("HOLD" ("WAITING") ("hold" . t))
                                  ("PROJECT" ("project" . t))
                                  ("GOAL" ("goal" . t))
                                  (done ("WAITING") ("hold"))
                                  ("TODO" ("waiting") ("cancelled") ("hold"))
                                  ("NEXT" ("waiting") ("cancelled") ("hold"))
                                  ("MEETING" ("meeting" . t)))

   org-todo-repeat-to-state "TODO"
   org-agenda-files '("inbox.org" "work_log.org" "projects.org" "areas.org" "resources.org" "journal.org" "shopping.org")
   org-default-notes-file "inbox.org"
   org-startup-folded "content"
   org-hide-leading-stars t
   org-hide-emphasis-markers t
   org-ellipsis " [...]"
   org-log-done "time"
   org-log-repeat "time"
   org-log-into-drawer "STATE_CHANGES"
   org-deadline-warning-days 14
   org-agenda-span 7
   org-agenda-start-on-weekday nil
   org-agenda-start-day "-2d"
   org-use-tag-inheritance t
   org-tags-exclude-from-inheritance '("project" "goal" "active")
   org-refile-targets '((nil :maxlevel . 9)
                        (org-agenda-files :maxlevel . 9))
   org-refile-target-verify-function 'kp/verify-refile-target
   org-refile-use-outline-path t
   org-capture-templates '(("t" "Todo" entry (file "inbox.org")
                            "* UNPROCESSED %?")
                           ("r" "Store from clipboard" entry (file "inbox.org")
                            "* UNPROCESSED %(evil-paste-after 0)" :immediate-finish t) ;; evil-paste-after as '%x' does not work in macos
                           ("n" "Note" entry (file "inbox.org")
                            "* %?")

                           ("w" "Work")
                           ("wt" "WORK TODAY: Todo" entry (file+function "work_log.org" org-reverse-datetree-goto-date-in-file)
                            "* SELECTCTED %?")
                           ("wn" "WORK TODAY: Note" entry (file+function "work_log.org" org-reverse-datetree-goto-date-in-file)
                            "* %?")
                           ("wm" "WORK TODAY: Meeting" entry (file+function "work_log.org" org-reverse-datetree-goto-date-in-file)
                            "* MEETING %U %^{Meeting Name?} :MEETING:
%?")

                           ("j" "Journal")
                           ("jj" "Standard entry" entry (file+function "journal.org" org-reverse-datetree-goto-date-in-file)
                            "* %<%H-%M>
%?")
                           ("jr" "Reframe" entry (file+function "journal.org" org-reverse-datetree-goto-date-in-file)
                            "* %<%H-%M> This has happened: ^{What happened?}. How is this the best thing that ever happened to me?
%?")
                           ("jp" "Posibilities" entry (file+function "journal.org" org-reverse-datetree-goto-date-in-file)
                            "* %<%H-%M> I am %?, because of
- ")
                           ("ji" "Inversion" entry (file+function "journal.org" org-reverse-datetree-goto-date-in-file)
                            "* %<%H-%M> $?")
                           ("je" "Perspective" entry (file+function "journal.org" org-reverse-datetree-goto-date-in-file)
                            "* %<%H-%M> $?")
                           ("jx" "How would someone else solve this?" entry (file+function "journal.org" org-reverse-datetree-goto-date-in-file)
                            "* %<%H-%M> %?")
                           ("jt" "30 ideas in 5 minutes" entry (file+function "journal.org" org-reverse-datetree-goto-date-in-file)
                            "* %<%H-%M> %?
- ")
                           ("jg" "Gratitude" entry (file+function "journal.org" org-reverse-datetree-goto-date-in-file)
                            "* %<%H-%M> 3 things I am grateful for today
1.
2.
3. ")
                           ("js" "Progress" entry (file+function "journal.org" org-reverse-datetree-goto-date-in-file)
                            "* %<%H-%M> Progress Questions
** What excited me today?
%?
** What drained me today?

** What did I learn today?
")
                           ("jw" "Weekly Review" entry (file+function "journal.org" org-reverse-datetree-goto-date-in-file)
                            "* %<%H-%M> Weekly Review
** Am I moving closer or further from my goals?")

                           ("b" "Add to shopping list" entry (file "shopping.org")
                            "* BUY %?"))
   org-agenda-custom-commands '(("s" "Shopping list" todo "BUY" nil "shopping.org" ((org-agenda-overriding-header "Shopping list")))
                                ("p" "Planning list" todo "UNPROCESSED|TODO|NEXT" ((org-agenda-sorting-strategy '(todo-state-up deadline-up scheduled-up priority-up))
                                                                                   (org-agenda-overriding-header "Planning list")
                                                                                   (org-agenda-prefix-format " %-22c %-12t %?-4e %-60b ")))
                                ("r" "Project list" tags "+PROJECT" ((org-agenda-sorting-strategy '(priority-up deadline-up scheduled-up))
                                                                     (org-agenda-overriding-header "Project list")
                                                                     (org-agenda-prefix-format " %-22c | %-12s ")
                                                                     (org-agenda-remove-tags "t")))
                                ("g" "Goals list" tags "+GOAL" ((org-agenda-overriding-header "Goals list")))
                                ("z" "Personal Agenda" ((agenda)
                                                        (org-ql-block '(and (habit) (scheduled :on today))
                                                                      ((org-ql-block-header "Habits")))
                                                        (tags "+project+active-work" ((org-agenda-overriding-header "Active Projects")))
                                                        (org-ql-block '(and (todo "NEXT") (ancestors (and (todo "PROJECT") (tags "active") (not (tags "work")))))
                                                                      ((org-ql-block-header "Project next actions")
                                                                       (org-agenda-prefix-format " %-22c | %-12s ")))
                                                        (org-ql-block '(and (not (ancestors (todo "PROJECT"))) (todo "NEXT") (not (tags "work")))
                                                                      ((org-ql-block-header "One-off next actions")))
                                                        (org-ql-block '(and (todo "PROJECT") (not (tags "work")) (not (descendants (todo "NEXT"))))
                                                                      ((org-ql-block-header "Stuck Projects")))
                                                        (org-ql-block '(and (not (ancestors (todo "PROJECT"))) (todo "TODO") (not (habit)) (not (tags "work")))
                                                                      ((org-ql-block-header "Other one-off tasks")))))
                                ("x" "Work Agenda" ((agenda)
                                                    (tags "+project+active+work" ((org-agenda-overriding-header "Active Projects")))
                                                    (org-ql-block '(and (todo "NEXT") (ancestors (and (todo "PROJECT") (tags "active") (tags "work"))))
                                                                  ((org-ql-block-header "Project next actions")
                                                                   (org-agenda-prefix-format " %-22c | %-12s ")))
                                                    (org-ql-block '(and (not (ancestors (todo "PROJECT"))) (todo "NEXT") (tags "work"))
                                                                  ((org-ql-block-header "One-off next actions")))
                                                    (org-ql-block '(and (todo "PROJECT") (tags "work") (not (descendants (todo "NEXT"))))
                                                                  ((org-ql-block-header "Stuck Projects")))
                                                    (org-ql-block '(and (not (ancestors (todo "PROJECT"))) (todo "TODO") (tags "work"))
                                                                  ((org-ql-block-header "Other one-off tasks")))))))
  (add-hook! org-mode 'auto-save-mode)
  (add-hook! 'auto-save-hook 'org-save-all-org-buffers)
  (add-hook! 'org-todo-repeat-hook 'org-reset-checkbox-state-subtree)) ;; for some reason, org-checkbox does not work


(defun kp/run-command-runner-empty (command-line name output-buffer) nil)

(defun kp/shell-runner-command-def (command)
  "Returns a lambda"
  ( lambda () (progn (shell-command command) (kill-current-buffer))))

(defun kp/project-name ()
  (if (project-current)
      (project-name (project-current))))

(setq debug-on-error t)
(defun kp/commands-aoc ()
  (list
   (when (kp/project-name)
     (when-let* ((f (buffer-file-name)))
       (list :display (format "my command %s" (kp/project-name))
             :command-name "print-current-project"
             :command-line (format "echo %s" (project-current)))
       (list :display "gofumpt"
             :command-name "gofumpt"
             :hook (kp/shell-runner-command-def (format "gofumpt -w %s" f))
             :runner 'kp/run-command-runner-empty
             :command-line "")))))

(use-package! run-command
  :ensure t
  :config
  (setq run-command-default-runner 'run-command-runner-vterm
        run-command-selector 'run-command-selector-completing-read
        run-command-recipes '(kp/commands-aoc)))

(map! :leader
      :desc "Universal Argument" "U" #'universal-argument ;; Moved
      :desc "Run Command" "u" #'run-command)

(use-package! web-mode
  :config
  (setq web-mode-engines-alist
        '(("php"    . "\\\\.phtml\\\\\\='")
          ("blade"  . "\\\\.blade\\\\.")
          ("go" . "\\\\.tmpl\\\\."))))
