(use-package all-the-icons
  :straight t
  :demand)

;; (use-package treemacs-all-the-icons
;;   :straight t)

(use-package lsp
  :bind
  (:map lsp-mode-map
        ("C-." . lsp-ui-peek-find-references)
        ("<C-return>" . helm-lsp-code-actions)
        ("C-h f" . lsp-ui-doc-show))
  ;; This combo of :demand and :config is required:
  ;;
  ;; I think the explanation is: dolist must be a :config because it requires
  ;; the package to have been loaded, but if the package is autoloaded then it
  ;; will try to start the lsp server before the variable is bound, causing it
  ;; to not correctly ignore the given directories. So we need to :demand that
  ;; the rquire happens eagerly
  :demand
  :custom
  (lsp-enable-snippet t)
  :config
  (dolist (name '(".mypy_cache" "__pycache__" "venv"))
    (add-to-list 'lsp-file-watch-ignored-directories (format "[/\\\\]%s\\'" name)))
  (setq lsp-yaml-schemas
        '((https://gitlab\.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci\.json . ["/.gitlab/*.yml" "/.gitlab-ci.yml"]))))

(use-package lsp-ui
  :config
  (progn
    (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
    (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)))

;; https://github.com/emacs-lsp/lsp-mode/issues/2681
;; supposedly a fix for this has already been included in emacs 29 but it still seems necessary.
(advice-add 'json-parse-string :around
            (lambda (orig string &rest rest)
              (apply orig (s-replace "\\u0000" "" string)
                     rest)))
(advice-add 'json-parse-buffer :around
              (lambda (orig &rest rest)
                (while (re-search-forward "\\u0000" nil t)
                  (replace-match ""))
                (apply orig rest)))

(use-package dap-mode
  :straight t)

;; https://github.com/palantir/python-language-server/issues/431#issuecomment-442918906
(defun pyenv-venv-wrapper-act (&optional ARG PRED)
  (setenv "VIRTUAL_ENV" (shell-command-to-string "_pyenv_virtualenv_hook; echo -n $VIRTUAL_ENV")))
  (advice-add 'pyenv-mode-set :after 'pyenv-venv-wrapper-act)
  (defun pyenv-venv-wrapper-deact (&optional ARG PRED)
        (setenv "VIRTUAL_ENV"))
  (advice-add 'pyenv-mode-unset :after 'pyenv-venv-wrapper-deact)

;; (use-package treemacs
;;   :straight t)

(use-package lsp-treemacs
  :straight t
  :config (lsp-treemacs-sync-mode 1))
