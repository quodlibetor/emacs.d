(require 'flycheck)
(require 'web-mode)
(add-to-list 'auto-mode-alist
             '(".jsx?\\'" . web-mode)
             '(".tsx?\\'" . web-mode))

;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(javascript-jshint)))

;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)


;; (add-to-list 'load-path "~/.emacs.d/site-lisp/packages/tern/emacs")
;; (autoload 'tern-mode "tern.el" nil t)
(add-hook 'web-mode-hook
          (lambda ()
            (setq web-mode-markup-indent-offset 2
                  web-mode-code-indent-offset 2)
            (prettier-js-mode)
            (tern-mode)))

(setenv "PATH" (concat "/Users/bwm/.nvm/versions/node/v6.3.0/bin:" (getenv "PATH")))
(setq exec-path (append '("/Users/bwm/.nvm/versions/node/v6.3.0/bin") exec-path ))

;; from https://github.com/ananthakumaran/tide
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

(require 'company)
;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
;(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))
