;; (require 'racer)

;; (define-key rust-mode-map (kbd "C-j") 'bwm:sane-newline)
;; (define-key rust-mode-map (kbd "C-c h") 'racer-describe)
;; (define-key rust-mode-map (kbd "C-h f") 'racer-describe)
;; (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
;; (add-hook 'rust-mode-hook #'racer-mode)
;; (add-hook 'racer-mode-hook #'eldoc-mode)
;; (add-hook 'racer-mode-hook #'company-mode)
;; (setq rust-format-on-save t)
;; (add-hook 'rust-mode-hook
;;           (lambda ()
;;             ;; (setq-local company-minimum-prefix-length 0)
;;             ;; (setq-local compile-command "cargo check")
;;                                         ;(cargo-minor-mode 1)
;;                                         ;(flycheck-mode)
;;             (lsp)))

;;(setenv "RUSTC_WRAPPER" "/Users/bwm/.cargo/bin/sccache")

;; (add-hook 'before-save-hook
;;           (lambda ()
;;             ("rustup run nightly rustfmt")))
;; (add-hook 'rust-mode-hook #'rustfmt-enable-on-save)
;(setq racer-rust-src-path (concat (getenv "HOME") "/src/rust/src"))
;; (setq racer-cmd (concat (getenv "HOME") "/.cargo/bin/racer"))
;; (setq racer-rust-src-path
;;       (concat (getenv "HOME")
;;               "/.rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src"))
;; (define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
;; (setq company-tooltip-align-annotations t)

;; ;; override the cargo error message face to draw more attention to parts of the
;; ;; buffer used for testing
;; (require 'compile)
;; (add-to-list 'compilation-error-regexp-alist-alist
;;              '(cargo "thread '\\([^']+\\)' panicked at \\('[^']+'\\), \\([^:]+\\):\\([0-9]+\\)"
;;                     3 4 nil nil 2 (1 'compilation-info)))

(defun bwm:rust-find-definition (prefix)
  (interactive "p")
  (if (eq prefix 1)
      (lsp-find-definition)
    (lsp-ui-peek-find-definitions)))

(use-package rust-mode)
(use-package rustic
  :hook (rust-mode . rustic-mode)
  :bind (:map rustic-mode-map
              ("M-n" . flycheck-next-error)
              ("M-p" . flycheck-previous-error)
              ("M-." . bwm:rust-find-definition)
              ("C-." . lsp-ui-peek-find-references)
              ("<C-return>" . helm-lsp-code-actions)
              ("C-h f" . lsp-ui-doc-show))
  :custom
  (rustic-format-trigger nil "use lsp format")
  (rustic-lsp-format t "use the lsp server instead of cargo fmt")
  (lsp-ui-doc-show-with-cursor nil "Use `C-h f' for a doc view"))

;; one of the two of these should be enabled
(setq lsp-rust-analyzer-proc-macro-enable t)
(setq lsp-rust-analyzer-import-merge-behaviour "last")
(setq lsp-rust-analyzer-cargo-load-out-dirs-from-check t)
; (setq lsp-rust-analyzer-diagnostics-disabled '("unresolved-proc-macro"))

(add-hook 'before-save-hook
          (lambda ()
            (when (eq major-mode 'rustic-mode)
              (lsp-format-buffer))))


;; Debugging

(use-package dap-mode
  :ensure
  :config
  (dap-ui-mode)
  (dap-ui-controls-mode 1)

  (require 'dap-lldb)
  (require 'dap-gdb-lldb)
  ;; installs .extension/vscode
  (dap-gdb-lldb-setup)
  (dap-register-debug-template
   "Rust::LLDB Run Configuration"
   (list :type "lldb"
         :request "launch"
         :name "LLDB::Run"
	 :gdbpath "rust-lldb"
         :target nil
         :cwd nil)))
