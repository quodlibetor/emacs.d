; see customize/ui, because I make flymake activate everywhere, there and see
; $emacs/packages/flymake-python/flymake-customizations.el for a bunch of ways
; to customize it

(setq elpy-modules
      '(elpy-module-sane-defaults
        elpy-module-company
        elpy-module-eldoc
        elpy-module-pyvenv
        elpy-module-yasnippet))

(elpy-enable)
(add-to-list 'auto-mode-alist
             '("pyflymakerc$" . python-mode))
(add-to-list 'auto-mode-alist
             '("\\.wsgi$" . python-mode))
(add-to-list 'auto-mode-alist
             '("\\.pylintrc\\'" . conf-mode))

(require 'python)
(setq python-fill-docstring-style 'django) ;; knewton style

(global-set-key (kbd "C-j") 'bwm:sane-newline)

(require 'pydoc)
(eval-after-load 'python-mode
  (define-key python-mode-map (kbd "C-h f") 'pydoc-at-point))

(require 'virtualenvwrapper)
(venv-initialize-interactive-shells)

;; (add-hook 'python-mode-hook
;;           (lambda ()
;;             (when (and (buffer-file-name) (string-match "test_.*py" (buffer-file-name)))
;;               (py-gnitset-mode))))

(add-hook 'python-mode-hook
          #'py-gnitset-mode)


(put 'python-symbol 'end-op
     (lambda ()
       (re-search-forward "[[:alnum:]_.]*" nil t)))

(put 'python-symbol 'beginning-op
     (lambda ()
       (re-search-backward "[[:alnum:]_.]*" nil t)
       (forward-char)))

;(setq pylookup-dir "~/.emacs.d/packages/pylookup")
;(add-to-list 'load-path pylookup-dir)
;;; load pylookup when compile time
;(eval-when-compile (require 'pylookup))
;
;;; set executable file and db file
;(setq pylookup-program (concat pylookup-dir "/pylookup.py"))
;(setq pylookup-db-file (concat pylookup-dir "/pylookup.db"))
;
;;; to speedup, just load it on demand
;(autoload 'pylookup-lookup "pylookup"
;  "Lookup SEARCH-TERM in the Python HTML indexes." t)
;(autoload 'pylookup-update "pylookup" 
;  "Run pylookup-update and create the database at `pylookup-db-file'." t)


;; run both flake8 and flycheck
;; https://github.com/flycheck/flycheck/issues/185#issuecomment-213989845
(require 'flycheck)

(defun fix-flake8 (errors)
  (let ((errors (flycheck-sanitize-errors errors)))
    (seq-do #'flycheck-flake8-fix-error-level errors)
    errors))

(flycheck-define-checker python-flake8-chain
  "A Python syntax and style checker using Flake8.

Requires Flake8 3.0 or newer. See URL
`https://flake8.readthedocs.io/'."
  :command ("flake8"
            "--format=default"
            "--stdin-display-name" source-original
            (config-file "--config" flycheck-flake8rc)
            (option "--max-complexity" flycheck-flake8-maximum-complexity nil
                    flycheck-option-int)
            (option "--max-line-length" flycheck-flake8-maximum-line-length nil
                    flycheck-option-int)
            "-")
  :standard-input t
  :error-filter (lambda (errors)
                  (let ((errors (flycheck-sanitize-errors errors)))
                    (seq-do #'flycheck-flake8-fix-error-level errors)
                    errors))
  :error-patterns
  ((warning line-start
            (file-name) ":" line ":" (optional column ":") " "
            (id (one-or-more (any alpha)) (one-or-more digit)) " "
            (message (one-or-more not-newline))
            line-end))
  :next-checkers ((t . python-pylint))
  :modes python-mode)

;; replace flake8 with new chaining one from above
(setq flycheck-checkers (cons 'python-flake8-chain (delq 'python-flake8 flycheck-checkers)))
