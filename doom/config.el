;;; Mi configuración: acph
;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

(setq user-full-name "Augusto César Poot Hernández"
      user-mail-address "apoot@ifc.unam.mx")

(setq ein:output-area-inlined-images t)

(setq org-babel-python-command "ipython")
(setq python-shell-interpreter "ipython")
;; this help a lot, it looks that fix some problem with corfu
(setq python-shell-interpreter-args "--simple-prompt")


;;;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Fira Code" :size 16 :weight 'semi-light)
)
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-bluloco-dark)
(setq fancy-splash-image "~/Sync/Emacs/dragon_mark.png")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;;;;;;;;;
;; org ;;
;;;;;;;;;

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Sync/Emacs/org/")
(setq org-log-done 'time)



;;;;;;;;;;;;;;
;; org-roam ;;
;;;;;;;;;;;;;;

(setq org-roam-directory (file-truename "~/Sync/Emacs/org/roam"))
(org-roam-db-autosync-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org mode capture templates ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(after! org
(setq org-capture-templates
      '(("t" "Todo" entry
         (file+headline "~/Sync/Emacs/org/todo.org" "Inbox")
         "* TODO %^{Task}\n:PROPERTIES:\n:CREATED: %U\n:END:\n%?\n")

      ("c" "Calendar" entry
       (file "~/Sync/Emacs/org/calendar.org")
        "* %^{Task}\n%?")

       ("i" "Idea" entry
         (file+headline "~/Sync/Emacs/org/ideas.org" "Ideas")
         "* IDEA %^{title}\n:PROPERTIES:\n:CREATED: %U\n:END:\n%?\n")

       ("l" "Log" entry
         (file+headline "~/Sync/Emacs/org/log.org" "Log")
         "* %U - %^{log-text} :TAGS:%(org-capture-log-tags)")
       )
      )
)

(defun org-capture-log-tags ()
  "Get tags from existing bookmarks and prompt for tags with completion. from: https://github.com/joshuablais/dotfiles/blob/master/doom/.config/doom/config.el"
  (save-window-excursion
    (let ((tags-list '()))
      ;; Collect existing tags
      (with-current-buffer (find-file-noselect "~/Sync/Emacs/org/log.org")
        (save-excursion
          (goto-char (point-min))
          (while (re-search-forward ":TAGS:\\s-*\\(.+\\)$" nil t)
            (let ((tag-string (match-string 1)))
              (dolist (tag (split-string tag-string "[:]" t "[[:space:]]"))
                (push (string-trim tag) tags-list))))))
      ;; Remove duplicates and sort
      (setq tags-list (sort (delete-dups tags-list) 'string<))
      ;; Prompt user with completion
      (let ((selected-tags (completing-read-multiple "Tags (comma-separated): " tags-list)))
        ;; Return as a comma-separated string
        (concat (mapconcat 'identity selected-tags ":") ":")))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-roam capture templates ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq org-roam-capture-templates
      '(
        ("d" "default" plain "%?"
          :if-new (file+head "${slug}-%<%Y%m%d%H%M%S>.org"
                             "#+title: ${title}\n")
          :unnarrowed t
          )

        ("p" "Project" plain "* Objective\n\n%?\n\n* Ideas\n\n** IDEA \n\n* Tasks\n\n** TODO Add initial tasks\n\n* Dates\n\n** Created %U\n\n"
         :if-new (file+head "projects/${slug}-%<%Y%m%d%H%M%S>.org"
                            "#+title: ${title}\n#+filetags: :Project:")
         :unnarrowed t
         )

        ("r" "Presentation" plain "* %? \n\n\n\n----------\nSLIDES----------\n\n* First slide"
         :if-new (file+head "presentations/${slug}-%<%Y%m%d%H%M%S>.org"
                            "#+title: ${title}\n#+filetags: :Presentation:")
         :unnarrowed t
         )
        )
      )

(use-package! websocket
  :after org-roam)

(use-package! org-roam-ui
  :after org-roam
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))


;;;;;;;;;;;;;;;;;;;;;;;
;; org-super-agenda  ;;
;;;;;;;;;;;;;;;;;;;;;;;

;; (after! org-agenda
;;    (setq org-super-agenda-groups
;;         '((:auto-category t))
;;         )

;;   (org-super-agenda-mode +1)
;; )

(use-package! org-super-agenda
  :after org-agenda
  :config
  (setq org-super-agenda-groups
        '((:auto-category t)))
  (org-super-agenda-mode +1))


 ;; Whenever you reconfigure a package, make sure to wrap your config in an
 ;; `after!' block, otherwise Doom's defaults may override your settings. E.g.

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


;; Cesar
;; Mostrar reloj en emacs
(display-time-mode 1)

(use-package ellama
  :init
 (setopt ellama-keymap-prefix "C-x e")
 (require 'llm-ollama)
 (setopt ellama-provider
         (make-llm-ollama
                :chat-model "gemma3:12b"
                )
         )
 )




;;;;;;;;;;;;;;
;; Calendar ;;
;;;;;;;;;;;;;;

;; Dummy variables before loading
;;


(after! plstore
  (add-to-list 'plstore-encrypt-to "GPG-key-id"))

(setq epg-pinentry-mode 'loopback)

(setq plstore-cache-passphrase-for-symmetric-encryption t)

;; (setq org-gcal-client-id "pending"
;;       org-gcal-client-secret "pending")


(load! "~/Sync/Emacs/cal.el")
