; see customize/ui, because I make flymake activate everywhere, there and see
; $emacs/packages/flymake-python/flymake-customizations.el for a bunch of ways
; to customize it

(defun python-configure ()
  (apheleia-mode)
  (require 'lsp-pyright)
  (lsp))

(use-package lsp-pyright
  :straight t
  :after lsp-mode
  :hook (python-mode . python-configure))

(add-to-list 'auto-mode-alist
             '("pyflymakerc$" . python-mode))
(add-to-list 'auto-mode-alist
             '("\\.wsgi$" . python-mode))
(add-to-list 'auto-mode-alist
             '("\\.pylintrc\\'" . conf-mode))
(add-to-list 'auto-mode-alist
             '(".pyi\\'" . python-mode))

(require 'python)
(setq python-fill-docstring-style 'django) ;; knewton style

(global-set-key (kbd "C-j") 'bwm:sane-newline)

;; (add-hook 'python-mode-hook
;;           (lambda ()
;;             (when (and (buffer-file-name) (string-match "test.*py" (buffer-file-name)))
;;               (py-gnitset-mode))))

(require 'flycheck)

(setq flycheck-python-mypy-args
      '("--strict-optional"))

(put 'python-symbol 'end-op
     (lambda ()
       (re-search-forward "[[:alnum:]_.]*" nil t)))

(put 'python-symbol 'beginning-op
     (lambda ()
       (re-search-backward "[[:alnum:]_.]*" nil t)
       (forward-char)))
