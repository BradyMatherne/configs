;;-----------------------------------------------------------------
;; Laptop specific section
;;------------------------------------------------------------------

;; Directories to search for creating agenda files in org-mode
(setq org-agenda-files (quote ("~/documents/emacs/proj"
                               "~/documents/emacs/"
;			       "~/work/Home/"
;			       "~/work/Home/bup"
;			       "~/work/Home/global"
;			       "~/work/Home/bup/projects"
;			       "~/work/Home/org")))
			       )))
			       
;; Set font size for HDPI screen
(set-face-attribute 'default (selected-frame) :height 175)




;;-------------------------------------------------------------------
;; Non-Laptop specific scetion
;;-------------------------------------------------------------------

;; enable IDO
(require 'ido)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode t)


;; set TODO states
(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "Wait(w)" "|" "DONE(d)" "Canceled(c)")))

;; Include diary entries in agenda
(setq org-agenda-include-diary t)

;; Enable messages to LOGBOOK drawer
(setq org-log-into-drawer t)

;; enable org-mode for the following file extensions
;(add-to-list 'load-path (expand-file-name "~/git/org-mode/lisp"))
(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))
(require 'org)





;;---------------------------------------------------------------------
;; Keybindings
;;--------------------------------------------------------------------
;;
;; Standard key bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-cc" 'org-capture)


;; Custom Key Bindings
(global-set-key (kbd "<f12>") 'org-agenda)
(global-set-key (kbd "<f5>") 'bh/org-todo)
(global-set-key (kbd "<S-f5>") 'bh/widen)
(global-set-key (kbd "<f7>") 'bh/set-truncate-lines)
(global-set-key (kbd "<f8>") 'org-cycle-agenda-files)
(global-set-key (kbd "<f9> <f9>") 'bh/show-org-agenda)
(global-set-key (kbd "<f9> b") 'bbdb)
(global-set-key (kbd "<f9> c") 'calendar)
(global-set-key (kbd "<f9> f") 'boxquote-insert-file)
(global-set-key (kbd "<f9> g") 'gnus)
(global-set-key (kbd "<f9> h") 'bh/hide-other)
(global-set-key (kbd "<f9> n") 'bh/toggle-next-task-display)

(global-set-key (kbd "<f9> I") 'bh/punch-in)
(global-set-key (kbd "<f9> O") 'bh/punch-out)

(global-set-key (kbd "<f9> o") 'bh/make-org-scratch)

(global-set-key (kbd "<f9> r") 'boxquote-region)
(global-set-key (kbd "<f9> s") 'bh/switch-to-scratch)

(global-set-key (kbd "<f9> t") 'bh/insert-inactive-timestamp)
(global-set-key (kbd "<f9> T") 'bh/toggle-insert-inactive-timestamp)

(global-set-key (kbd "<f9> v") 'visible-mode)
(global-set-key (kbd "<f9> l") 'org-toggle-link-display)
(global-set-key (kbd "<f9> SPC") 'bh/clock-in-last-task)
(global-set-key (kbd "C-<f9>") 'previous-buffer)
(global-set-key (kbd "M-<f9>") 'org-toggle-inline-images)
(global-set-key (kbd "C-x n r") 'narrow-to-region)
(global-set-key (kbd "C-<f10>") 'next-buffer)
(global-set-key (kbd "<f11>") 'org-clock-goto)
(global-set-key (kbd "C-<f11>") 'org-clock-in)
(global-set-key (kbd "C-s-<f12>") 'bh/save-then-publish)
(global-set-key (kbd "C-c c") 'org-capture)

(defun bh/hide-other ()
  (interactive)
  (save-excursion
    (org-back-to-heading 'invisible-ok)
    (hide-other)
    (org-cycle)
    (org-cycle)
    (org-cycle)))

(defun bh/set-truncate-lines ()
  "Toggle value of truncate-lines and refresh window display."
  (interactive)
  (setq truncate-lines (not truncate-lines))
  ;; now refresh window display (an idiom from simple.el):
  (save-excursion
    (set-window-start (selected-window)
                      (window-start (selected-window)))))

(defun bh/make-org-scratch ()
  (interactive)
  (find-file "/tmp/publish/scratch.org")
  (gnus-make-directory "/tmp/publish"))

(defun bh/switch-to-scratch ()
  (interactive)
  (switch-to-buffer "*scratch*"))


;;--------------------------------------------------------------------
;; look / layout
;;--------------------------------------------------------------------
;; set theme
(load-theme 'wombat)

;;Customize header faces
(custom-theme-set-faces 'user
			`(org-level-1 ((t (:foreground "#BFBFBF" :height 200 :background "#383838")))))

;; Disable splash screen
(setq inhibit-startup-message t)

;; Set indent to be 2 spaces
(setq c-default-style "Linux" c-basic-offset 2)

;; Hide leading stars in heades - only a sigle indented star shown
(setq org-hide-leading-stars t)



;;------------------------------------------------------------------
;; Capture and refile functionality
;;-----------------------------------------------------------------
(setq org-directory "~/documents/emacs/org")
(setq org-default-notes-file "~/documents/emacs/org/refile.org")

;; C-c c to start capture mode
(global-set-key (kbd "C-c c") 'org-capture)

;; Capture template for TODO tasks, Notes, appointments, phone calls, meetings)
(setq org-capture-templates
      (quote (("t" "todo" entry (file "~/documents/emacs/org/refile.org")
	       "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
	      ("r" "respond" entry (file "~/documents/emacs/org/refile.org")
	       "* NEXT Respond to  %t\n%U\n%a\n")
	      ("n" "note" entry (file "~/documents/emacs/org/refile.org")
	       "* %? :NOTE:\n%U\n%a\n")
	      ("j" "Journal" entry (file "~/.emacs.d/diary")
	       "* %?\n%U\n" :clock-in t :clock-resume t)
	      ("m" "Meeting" entry (file "~/documents/emacs/org/refile.org")
	       "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t))))



;; Refile settings
;Targets include this file and any file contributing to the agenda - up to 9 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 9))))

; Use full outline paths for refile targets - we file directly with IDO
(setq org-refile-use-outline-path t)

; Targets complete directly with IDO
(setq org-outline-path-complete-in-steps nil)

; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

; Use IDO for both buffer and file completion and ido-everywhere to t
(setq org-completion-use-ido t)
(setq ido-everywhere t)
(setq ido-max-directory-size 100000)
(ido-mode (quote both))
; Use the current window when visiting files and buffers with ido
(setq ido-default-file-method 'selected-window)
(setq ido-default-buffer-method 'selected-window)
; Use the current window for indirect buffer display
(setq org-indirect-buffer-display 'current-window)

;;;; Refile settings
; Exclude DONE state tasks from refile targets
(defun bh/verify-refile-target ()
  "Exclude todo keywords with a done state from refile targets"
  (not (member (nth 2 (org-heading-components)) org-done-keywords)))

(setq org-refile-target-verify-function 'bh/verify-refile-target)


;----------------------------------------------------------------------
;; Custom Agenda
;----------------------------------------------------------------------
;; Do not dim blocked tasks
(setq org-agenda-dim-blocked-tasks nil)

;; Compact the block agenda view
(setq org-agenda-compact-blocks t)

;; Custom agenda command definitions
(setq org-agenda-custom-commands
      (quote (("N" "Notes" tags "NOTE"
               ((org-agenda-overriding-header "Notes")
                (org-tags-match-list-sublevels t)))
              ("h" "Habits" tags-todo "STYLE=\"habit\""
               ((org-agenda-overriding-header "Habits")
                (org-agenda-sorting-strategy
                 '(todo-state-down effort-up category-keep))))
              ("." "Agenda"
               ((agenda "" nil)
		
                (tags "REFILE"
                      ((org-agenda-overriding-header "Tasks to Refile")
                       (org-tags-match-list-sublevels nil)))
;                (tags-todo "-CANCELLED/!"
;                           ((org-agenda-overriding-header "Stuck Projects")
;                            (org-agenda-skip-function 'bh/skip-non-stuck-projects)
;                            (org-agenda-sorting-strategy
;                             '(category-keep))))
;                (tags-todo "-HOLD-CANCELLED/!"
;                           ((org-agenda-overriding-header "Projects")
;                            (org-agenda-skip-function 'bh/skip-non-projects)
;                            (org-tags-match-list-sublevels 'indented)
;                            (org-agenda-sorting-strategy
;                             '(category-keep))))

		(tags-todo "-CANCELLED/!NEXT"
			   ((org-agenda-overriding-header "Next Tasks")))
		(tags-todo "-CANCELLED-REFILE/!TODO"
			   ((org-agenda-overriding-header "ALL TODO Tasks")))))
                            
		nil)))






;; Open Start page by default
(find-file "~/documents/emacs/start.org")
