(require 'flycheck)
(add-to-list 'auto-mode-alist
             '(".jsx\\'" . web-mode))

;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(javascript-jshint)))

;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)


;; (add-to-list 'load-path "~/.emacs.d/site-lisp/packages/tern/emacs")
;; (autoload 'tern-mode "tern.el" nil t)
(add-hook 'web-mode-hook #'tern-mode)

(setenv "PATH" (concat "/Users/bwm/.nvm/versions/node/v6.3.0/bin:" (getenv "PATH")))
(setq exec-path (append '("/Users/bwm/.nvm/versions/node/v6.3.0/bin") exec-path ))
