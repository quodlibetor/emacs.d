; see customize/ui, because I make flymake activate everywhere, there and see
; $emacs/packages/flymake-python/flymake-customizations.el for a bunch of ways
; to customize it

;; (add-hook 'python-mode-hook 'lsp)
(setq elpy-modules
      '(elpy-module-sane-defaults
        elpy-module-company
        elpy-module-eldoc
        elpy-module-pyvenv
        elpy-module-yasnippet))

(use-package elpy
  :ensure t
  :init
  (elpy-enable)
  :hook
  (elpy-mode . (lambda ()
                 ; flake8 automatically runs mypy after it finishes
                 (setq-local flycheck-checker 'python-flake8)
                 ; (flycheck-add-next-checker 'python-mypy 'python-flake8)
                 (flycheck-mode)
                 )
             )
  )

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

(add-hook 'python-mode-hook
          (lambda ()
            (when (and (buffer-file-name) (string-match "test_.*py" (buffer-file-name)))
              (py-gnitset-mode))))

;; (require 'flymake)

;; (defun flymake-mypy-init ()
;;   "Init mypy."
;;   (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                      'flymake-create-temp-inplace))
;;          (local-file (file-relative-name
;;                       temp-file
;;                       (file-name-directory buffer-file-name))))
;;     (message "mypy initialized")
;;     (list "mypy" (list local-file "-s"))))


;; (when (load "flymake" t)
;;   (add-to-list 'flymake-allowed-file-name-masks '("\\.py\\'" flymake-mypy-init))
;;   )

(require 'flycheck)
;; (use-package flycheck-mypy
;;   :ensure t)
;(require 'flycheck-mypy)

(setq flycheck-python-mypy-args
      '("--strict-optional"))

;; if possible, set this in dir-locals:
;; ((python-mode . ((flycheck-python-mypy-args . ("--disallow-untyped-defs"
;;                                                "--strict-optional"
;;                                                "--ignore-missing-imports"
;;                                                )))))

;; (flycheck-define-checker python-my-chain
;;   "Run mypy, pep8, pylint"
;;   :command ("pycodestyle" "--max-line-length=100" source-original)
;;   :error-patterns
;;   ((warning line-start (file-name) ":" line ":" column ": "
;;             (id (one-or-more (any alpha)) (one-or-more digit))
;;             (message (one-or-more not-newline)
;;                      line-end)))
;;   :next-checkers ((t . python-mypy)
;;                   (t . python-pylint))
;;   :modes python-mode)

;; ;; replace flake8 with new chaining one from above
;; ;(setq flycheck-checkers (cons 'python-flake8-chain (delq 'python-flake8 flycheck-checkers)))
;; (setq flycheck-checkers (cons 'python-my-chain flycheck-checkers))
;(setq flycheck-checkers (cons 'python-mypy flycheck-checkers))

(add-hook 'python-mode-hook
          (lambda ()
            ;; (setq flycheck-checker 'python-my-chain)
            (blacken-mode 1)
            (py-gnitset-mode)))

(put 'python-symbol 'end-op
     (lambda ()
       (re-search-forward "[[:alnum:]_.]*" nil t)))

(put 'python-symbol 'beginning-op
     (lambda ()
       (re-search-backward "[[:alnum:]_.]*" nil t)
       (forward-char)))

;;;;;;;;;;;;;;;;;;;;
;; This is commented out because I prefer my smaller chain, it's a bit faster

;; run flake8 and pylint, the defaults don't work that well
;; https://github.com/flycheck/flycheck/issues/185#issuecomment-213989845

;; (defun fix-flake8 (errors)
;;   (let ((errors (flycheck-sanitize-errors errors)))
;;     (seq-do #'flycheck-flake8-fix-error-level errors)
;;     errors))

;; (flycheck-define-checker python-flake8-chain
;;   "A Python syntax and style checker using Flake8.

;; Requires Flake8 3.0 or newer. See URL
;; `https://flake8.readthedocs.io/'."
;;   :command ("flake8"
;;             "--format=default"
;;             "--stdin-display-name" source-original
;;             (config-file "--config" flycheck-flake8rc)
;;             (option "--max-complexity" flycheck-flake8-maximum-complexity nil
;;                     flycheck-option-int)
;;             (option "--max-line-length" flycheck-flake8-maximum-line-length nil
;;                     flycheck-option-int)
;;             "-")
;;   :standard-input t
;;   :error-filter (lambda (errors)
;;                   (let ((errors (flycheck-sanitize-errors errors)))
;;                     (seq-do #'flycheck-flake8-fix-error-level errors)
;;                     errors))
;;   :error-patterns
;;   ((warning line-start
;;             (file-name) ":" line ":" (optional column ":") " "
;;             (id (one-or-more (any alpha)) (one-or-more digit)) " "
;;             (message (one-or-more not-newline))
;;             line-end))
;;   :next-checkers ((t . python-mypy)
;;                   (t . python-pylint))
;;   :modes python-mode)
