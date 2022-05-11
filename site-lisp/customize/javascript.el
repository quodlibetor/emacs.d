(defun configure-typescript ()
  (lsp)
  (setq-local helm-dash-common-docsets '("React" "TypeScript" "Redux" "JavaScript" "AWS_JavaScript")))

(use-package typescript-mode
  :straight t
  :mode "\\.tsx?$"
  :hook
  ;; LSP will auto-install ts-ls mode, but it's worth also installing eslint
  ;; lsp which will auto run in parallel
  (typescript-mode . configure-typescript)
  :custom
  (typescript-indent-level 2))

(use-package prettier
  :straight t
  :hook ((typescript-tsx-mode . prettier-mode)
         (typescript-mode . prettier-mode)
         (web-mode . prettier-mode)
         (js-mode . prettier-mode)
         (json-mode . prettier-mode)
         (css-mode . prettier-mode)
         (scss-mode . prettier-mode)))

;; (defun disable-tree-sitter-font-lock ()
;;   (setq-local tree-sitter-hl-use-font-lock-keywords nil))

;; (use-package web-mode
;;   :straight t
;;   :mode "\\.tsx?$"
;;   :hook
;;   (web-mode . lsp)
;;   ;; https://github.com/emacs-tree-sitter/tree-sitter-langs/issues/23#issuecomment-832815710
;;   (web-mode . disable-tree-sitter-font-lock)
;;   :custom
;;   (web-mode-markup-indent-offset 2)
;;   (web-mode-code-indent-offset 2))

;; ;; use eslint with web-mode for jsx files
;; (flycheck-add-mode 'javascript-eslint 'web-mode)

;; ;; from https://github.com/ananthakumaran/tide
;; (defun setup-tide-mode ()
;;   (interactive)
;;   (tide-setup)
;;   (flycheck-mode +1)
;;   (setq flycheck-check-syntax-automatically '(save mode-enabled))
;;   (eldoc-mode +1)
;;   (tide-hl-identifier-mode +1)
;;   ;; company is an optional dependency. You have to
;;   ;; install it separately via package-install
;;   ;; `M-x package-install [ret] company`
;;   (company-mode +1))

;; (require 'company)
;; ;; aligns annotation to the right hand side
;; (setq company-tooltip-align-annotations t)

;; (add-hook 'typescript-mode-hook #'setup-tide-mode)
;; (add-hook 'web-mode-hook
;;           (lambda ()
;;             (when (string-equal "tsx" (file-name-extension buffer-file-name))
;;               (setup-tide-mode))))
