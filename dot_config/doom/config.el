;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(load "~/.config/doom/secrets.el")

(setq user-full-name "Karolis Pabijanskas"
      user-mail-address (kp/get_secret "personal_email")
      doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 12)
      catppuccin-flavor 'latte
      doom-theme 'doom-nord-light
      display-line-numbers-type 'visual
      shell-file-name (executable-find "bash"))

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
                  "%Y-%m %B"
                  "%Y-%m W%V"
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
                            "* %<%H:%M>
%?" :prepend t)
                           ("jr" "Reframe" entry (file+function "journal.org" org-reverse-datetree-goto-date-in-file)
                            "* %<%H:%M> This has happened: ^{What happened?}. How is this the best thing that ever happened to me?
%?" :prepend t)
                           ("jp" "Posibilities" entry (file+function "journal.org" org-reverse-datetree-goto-date-in-file)
                            "* %<%H:%M> I am %?, because of
- " :prepend t)
                           ("ji" "Inversion" entry (file+function "journal.org" org-reverse-datetree-goto-date-in-file)
                            "* %<%H:%M> %?" :prepend t)
                           ("je" "Perspective" entry (file+function "journal.org" org-reverse-datetree-goto-date-in-file)
                            "* %<%H:%M> %?" :prepend t)
                           ("jx" "How would someone else solve this?" entry (file+function "journal.org" org-reverse-datetree-goto-date-in-file)
                            "* %<%H:%M> %?" :prepend t)
                           ("jt" "30 ideas in 5 minutes" entry (file+function "journal.org" org-reverse-datetree-goto-date-in-file)
                            "* %<%H:%M> %?
- " :prepend t)
                           ("jg" "Gratitude" entry (file+function "journal.org" org-reverse-datetree-goto-date-in-file)
                            "* %<%H:%M> 3 things I am grateful for today
1.
2.
3. " :prepend t)
                           ("js" "Progress" entry (file+function "journal.org" org-reverse-datetree-goto-date-in-file)
                            "* %<%H:%M> Progress Questions
** What excited me today?
%?
** What drained me today?

** What did I learn today?
" :prepend t)
                           ("jw" "Weekly Review" entry (file+function "journal.org" org-reverse-datetree-goto-date-in-file)
                            "* %<%H:%M> Weekly Review
** Am I moving closer or further from my goals?" :prepend t)

                           ("b" "Add to shopping list" entry (file "shopping.org")
                            "* BUY %?"))
   org-agenda-custom-commands '(("s" "Shopping list" todo "BUY" nil "shopping.org" ((org-agenda-overriding-header "Shopping list")))
                                ("p" "Planning list" todo "UNPROCESSED|TODO|NEXT" ((org-agenda-sorting-strategy '(todo-state-up deadline-up scheduled-up priority-up))
                                                                                   (org-agenda-overriding-header "Planning list")
                                                                                   (org-agenda-prefix-format " %-22c %-12t %?-4e %-60b ")))
                                ("r" "Project list" tags "+project" ((org-agenda-sorting-strategy '(priority-up deadline-up scheduled-up))
                                                                     (org-agenda-overriding-header "Project list")
                                                                     (org-agenda-prefix-format " %-22c | %-12s ")
                                                                     (org-agenda-remove-tags "t")))
                                ("g" "Goals list" tags "+goal" ((org-agenda-overriding-header "Goals list")))
                                ("z" "Personal Agenda" ((agenda)
                                                        (org-ql-block '(and (habit) (scheduled :to today))
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
  :defer
  :config
  (setq run-command-default-runner 'run-command-runner-vterm
        run-command-selector 'run-command-selector-completing-read
        run-command-recipes '(kp/commands-aoc)))

(map! :leader
      :desc "Universal Argument" "U" #'universal-argument ;; Moved
      :desc "Run Command" "u" #'run-command
      :desc "Pop up scratch window" "X" #'doom/open-scratch-buffer ;; Moved
      :desc "Org Capture" "x" #'org-capture                        ;; Moved
      :desc "Org Agenda" "z" #'org-agenda)


(use-package! web-mode
  :config
  (setq web-mode-engines-alist
        '(("php"    . "\\\\.phtml\\\\\\='")
          ("blade"  . "\\\\.blade\\\\.")
          ("go" . "\\\\.tmpl\\\\."))))

(use-package! exercism
  :defer
  :commands (exercism)
  :config
  (setq exercism--workspace "~/workspaces/exercism/"))

(use-package! php
  :init
  (setq lsp-intelephense-licence-key (kp/get_secret "intelephense_key"))
  :config
  (require 'dap-php)
  (dap-php-setup))

(require 'dap-dlv-go)
