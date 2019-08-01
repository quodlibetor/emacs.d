; use this with a bash script that runs emacsclient -s ~/.emacs.d/server/server
; to avoid macOS temp dir randomization
(setq server-socket-dir (expand-file-name "~/.emacs.d/server"))
(server-start)

(require 'atomic-chrome)
(atomic-chrome-start-server)

(require 'company)
(require 'lsp)
(require 'company-lsp)
(require 'lsp-ui)
(add-hook 'lsp-mode-hook 'lsp-ui-mode)

;(require 'flymake-cursor "packages/emacs-flymake-cursor/flymake-cursor")

(global-company-mode 1)

;(auto-complete-mode)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(show-paren-mode 1)
(column-number-mode 1)
(electric-pair-mode 1)
(put 'dired-find-alternate-file 'disabled nil)
(put 'set-goal-column 'disabled nil)
(setq-default indent-tabs-mode nil)
(setq set-mark-command-repeat-pop t
      confirm-nonexistent-file-or-buffer nil
      require-final-newline t
      dired-dwim-target t
      split-height-threshold 500)

(autoload 'scratch "scratch" nil t)

;; highlight escape-sequences
(hes-mode)
(global-hl-line-mode)

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward
      uniquify-strip-common-suffix t)

(require 'yasnippet)
(yas-global-mode)

(require 'saveplace)
(setq-default save-place t)
(setq save-place-file "~/.emacs.d/save-place")

(blink-cursor-mode t)
(setq blink-cursor-blinks 3)

(setq-default show-trailing-whitespace t
	      default-indicate-empty-lines t
	      sentence-end-double-space nil
	      fill-column 79)
(setq backup-by-copying t      ; don't clobber symlink
      backup-directory-alist   ; don't litter my fs tree
          `(("." . ,(expand-file-name "~/.emacs.d/tmp/saves")))
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)       ; use versioned backups

(setq custom-safe-themes
      (quote
       ("06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "7b4a6cbd00303fc53c2d486dfdbe76543e1491118eba6adc349205dbf0f7063a" default)))

;(require 'moe-theme)
(require 'powerline)
(require 'spaceline-config)
;(setq moe-theme-highlight-buffer-id nil)
;(moe-dark)
(spaceline-emacs-theme)
(spaceline-helm-mode)
(spaceline-toggle-projectile-root)

;(global-flycheck-mode 1)

(defadvice split-window-right (after split-and-rebalance-windows ())
  "I prefer windows to auto-balance when I open new ones"
  (balance-windows))
(ad-activate 'split-window-right)

(add-to-list 'auto-mode-alist
             '("bashrc" . shell-script-mode))
(add-to-list 'auto-mode-alist
             '("\\.zsh" . shell-script-mode))
(add-to-list 'auto-mode-alist
             '("README\\(.rst\\)?\\'" . rst-mode))
(add-to-list 'auto-mode-alist
             '("gitconfig\\'" . gitconfig-mode))
(add-to-list 'auto-mode-alist
             '("Cheffile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist  ; cloudformation templates
             '("\\.template\\'" . json-mode))
(add-to-list 'auto-mode-alist
             '("Cargo.lock\\'" . toml-mode))
(add-to-list 'auto-mode-alist
             '("\\.fish\\.j2\\'" . fish-mode))
(add-to-list 'auto-mode-alist
             '("/\\(group\\|host\\)_vars/" . yaml-mode))
(add-to-list 'auto-mode-alist
             '("\\.service\\.j2\\'" . systemd-mode))
(add-to-list 'auto-mode-alist
             '("Dockerfile\\(\\.\\w+\\)?\\'" . dockerfile-mode))
(add-to-list 'auto-mode-alist
             '(".sh.j2\\'" . shell-script-mode))
(electric-indent-mode 0)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(setq web-mode-engines-alist '(("django" . "\\.html\\'")))
(add-hook 'web-mode-hook
          (lambda ()
            (set (make-local-variable 'electric-pair-mode) nil)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Reduce modeline polution

;; TODO: switch to rich-minority, since that's used by smart-mode-line
;; minor modes
(when (require 'diminish nil 'noerror)
  (eval-after-load "yasnippet"
    '(diminish 'yas-minor-mode ""))
  (eval-after-load "auto-complete"
    '(diminish 'auto-complete-mode "⦔"))
  (eval-after-load "paredit"
    '(diminish 'paredit-mode ""))
  (eval-after-load "flycheck"
    '(diminish 'flycheck-mode "F✓"))
  (eval-after-load "projectile"
    '(diminish 'projectile-mode ""))
  )
; auto-revert is loaded before this file
(diminish 'auto-revert-mode "")
; fancy colorful modeline
;; (sml/setup)

;; major modes
(add-hook 'python-mode-hook
          (lambda ()
            (setq mode-name "Py")))


(add-hook 'eval-expression-minibuffer-setup-hook
          #'eldoc-mode)

;;; Environment settings
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (replace-regexp-in-string
                          "[ \t\n]*$"
                          ""
                          (shell-command-to-string "JUST_WANT_PATH=yes PATH= /bin/zsh --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq eshell-path-env path-from-shell) ; for eshell users
    (setq exec-path (split-string path-from-shell path-separator))))

(when window-system (set-exec-path-from-shell-PATH))


(setq ring-bell-function
      (lambda ()
	(unless (memq this-command
		      '(isearch-abort abort-recursive-edit exit-minibuffer keyboard-quit))
	  (ding))))

(defun bwm/read-lines (path)
  "Return a list of lines of a file at filePath."
  (with-temp-buffer
    (insert-file-contents path)
    (split-string (buffer-string) "\n" t)))

(defun set-docker-env ()
  (interactive)
  (let ((fname (read-file-name "File with docker env: ")))
    (dolist (line (bwm/read-lines fname))
      (when (string-match "\\(DOCKER[^=]+\\)=\"\\(.*\\)\"" line)
        (setenv (match-string-no-properties 1 line)
                (match-string-no-properties 2 line))))))
