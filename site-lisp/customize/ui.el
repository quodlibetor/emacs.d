; use this with a bash script that runs emacsclient -s ~/.emacs.d/server/server
; to avoid macOS temp dir randomization
(setq server-socket-dir (expand-file-name "~/.emacs.d/server"))
(server-start)

(when (require 'edit-server nil t)
  (setq edit-server-new-frame nil)
  (edit-server-start))
(add-hook 'edit-server-start-hook
          (lambda ()
            (when (string-match "github.com" (buffer-name))
              (markdown-mode))))

(use-package tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)
  ;; doesn't work better than the built-in
  ;; https://github.com/emacs-tree-sitter/tree-sitter-langs/pull/97
  ;; (add-to-list 'tree-sitter-major-mode-language-alist '(terraform-mode . hcl))
  ;; (push '(web-mode . tsx) tree-sitter-major-mode-language-alist)
  )

(require 'company)
;(require 'company-lsp)

(use-package apheleia
  :straight t
  :config
  (setf (alist-get 'isort apheleia-formatters)
        '("isort" "--stdout" "-"))
  (setf (alist-get 'python-mode apheleia-mode-alist)
      '(black isort))
  (setf (alist-get 'cue apheleia-formatters)
        '("cue" "fmt" "-"))
  (setf (alist-get 'cue-mode apheleia-mode-alist)
      '(cue))
  :hook
  (cue-mode . apheleia-mode))

(use-package string-inflection)

(use-package helpful
  :straight t
  :bind (("C-h f" . helpful-callable)
         ("C-h v" . helpful-variable)
         ("C-h k" . helpful-key)))

;;(require 'flymake-cursor "packages/emacs-flymake-cursor/flymake-cursor")

(global-company-mode 1)

;(auto-complete-mode)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)
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

; line-wrapping is triggered by visual-line-mode and visual-fill-column-mode

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


(use-package doom-themes
  :straight t
  :init
  (setq
   doom-vibrant-brighter-comments t
   doom-vibrant-brighter-modeline t
   doom-vibrant-padded-modeline t)
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-vibrant t)
  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config)
  )
(require 'powerline)
(require 'spaceline-config)
(spaceline-emacs-theme)
(spaceline-helm-mode)
(spaceline-toggle-projectile-root)

; enable ligatures
(when (fboundp 'mac-auto-operator-composition-mode)
      (mac-auto-operator-composition-mode t)
      (catch 'found
        (dolist (font '("JetBrainsMono Nerd Font"
                        "Hack Nerd Font"
                        "Fira Code Retina Nerd Font Complete"
                        "FiraCode Nerd Font"))
          (if (member font (font-family-list))
              (progn
                (message "setting font %s" font)
                (set-face-attribute 'default nil :font font)
                ;; height is pt * 10
                (set-face-attribute 'default nil :height 120)
                (set-frame-font font nil t)
                (throw 'found font))
            (message "Unable to set up font %s" font)))))

(use-package flycheck
  :bind (:map flycheck-mode-map
              ("M-n" . flycheck-next-error)
              ("M-p" . flycheck-previous-error)))

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
  (eval-after-load "editorconfig"
    '(diminish 'editorconfig-mode "EC"))
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
