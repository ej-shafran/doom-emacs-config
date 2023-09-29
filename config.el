;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

;; (custom-theme-set-faces! 'solaire-default-face
;;   '(default :background "#1a1b26"))
(setq doom-theme 'doom-tokyo-night)

;; Splash screen
(setq fancy-splash-image (concat doom-user-dir "splash.svg"))

(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-footer)
(assoc-delete-all "Recently opened files" +doom-dashboard-menu-sections)
(assoc-delete-all "Reload last session" +doom-dashboard-menu-sections)
(assoc-delete-all "Jump to bookmark" +doom-dashboard-menu-sections)
(assoc-delete-all "Open private configuration" +doom-dashboard-menu-sections)
(assoc-delete-all "Open documentation" +doom-dashboard-menu-sections)

(add-hook! '+doom-dashboard-functions :append
  (insert "\n" (+doom-dashboard--center +doom-dashboard--width "Powered by Emacs!")))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; Don't highlight symbols by default
(setq lsp-enable-symbol-highlighting nil)

(setq doom-font (font-spec :family "FiraCode" :size 16))

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

;; Make "s" behave like vim
(remove-hook 'doom-first-input-hook #'evil-snipe-mode)

;; Comment out a line
(map! :nv "gc" #'comment-line)

;; Toggle terminal
(map! :leader :desc "Terminal" :n "t t" #'term)

;; Move around in windows more comfortably
(map! :map 'override :n "C-h" #'evil-window-left
      :n "C-j" #'evil-window-down
      :n "C-k" #'evil-window-up
      :n "C-l" #'evil-window-right)

;; Transpose windows in frame
(map! :leader :n "w t" #'transpose-frame)

;; New lines without insert mode
(defun newline-same-mode (count direction)
  "Add COUNT newlines either above or below the current line, without changing modes."
  (interactive "P\nMInsert newlines (b)elow or (a)bove: ")
  (setq count (or count 1))
  (if (string= direction "a")
      (+evil/insert-newline-above count)
    (progn
      (+evil/insert-newline-below count)
      (forward-line count))
    ))

;; New lines above point without insert mode
(defun newline-above-same-mode (count)
  "Add COUNT newlines above the current line, without changing modes."
  (interactive "P")
  (newline-same-mode count "a"))

;; New lines below point without insert mode
(defun newline-below-same-mode (count)
  "Add COUNT newlines below the current line, without changing modes."
  (interactive "P")
  (newline-same-mode count "b"))

(map! :n "]o" #'newline-below-same-mode)
(map! :n "]O" #'newline-above-same-mode)

;; Insert Nerd Font icons
(map! :i "M-u" #'nerd-icons-insert)

;; Org mode
(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "PROG(p)" "INTR(i)" "HOLD(h)" "DONE(d)")))

(setq org-agenda-span 'week)

(setq org-agenda-todo-ignore-scheduled 'future)
