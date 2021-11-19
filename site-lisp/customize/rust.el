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

(defun bwm-rustic-cargo-materialize-check (prefix)
  "Run 'cargo check' for the current project.

Prefix arguments affect what is checked:

* No arguments check the current crate
* One prefix arg checks all of materialized
* Two prefix args runs bin/check to trigger the materialized clippy lints
"
  (interactive "p")
  (if (> prefix 4)
      (let ((wdir (f-dirname (rustic-buffer-workspace))))
        (rustic-run-cargo-command (concat wdir "/bin/check") (list :directory wdir)))
    (let ((package (if (> prefix 1)
                       "materialized"
                     (file-name-nondirectory (string-trim-right (rustic-buffer-crate) "/")))))
      (rustic-run-cargo-command
       (format "cargo check -p %s" package)
       (list :directory (string-trim-right (file-name-directory (rustic-buffer-workspace)) "/"))))))

;; Speed up rust compilation, using the same flags as elsewhere
;; enabling these causes trait-resolution compilation errors
;; (setenv "CARGO_PROFILE_DEV_DEBUG" "1")
;; (setenv "RUSTFLAGS" " -Csplit-debuginfo=unpacked -Clink-arg=-fuse-ld=lld")

(setenv "PATH" (concat (getenv "HOME") "/.local/clang/bin" ":"
                       (getenv "PATH")))

;; Debugging

;; troubleshooting in https://github.com/emacs-lsp/dap-mode/issues/try The
;; command defined by `dap-gdb-lldb-debug-program' should work I needed to
;; manually download
;; https://marketplace.visualstudio.com/items?itemName=webfreak.debug copy it into
;; ~/.emacs.d/.extension/vscode/webfreak.debug/ and unzip it

(use-package dap-mode
  :ensure
  :config
  (dap-auto-configure-mode)

  (require 'dap-lldb)
  (require 'dap-gdb-lldb)
  ;; installs .extension/vscode
  (dap-gdb-lldb-setup)
  (setenv "MZ_DEV" "1")
  (dap-register-debug-template
   "Rust::LLDB Run Configuration"
   (list :type "lldb"
         :request "launch"
         :name "LLDB::Run"
	 :gdbpath "rust-lldb"
         :target nil
         :cwd nil))
  (dap-register-debug-template
   "materialize"
   (list :type "lldb"
         :request "launch"
         :name "LLDB::Run"
	 :gdbpath "rust-lldb"
         :target nil
         :cwd "/Users/bwm/github/materialize"))
  (add-hook 'dap-stopped-hook
            (lambda (arg) (call-interactively #'dap-hydra))))

(use-package rustic
  ;:hook (rust-mode . rustic-mode)
  :bind (:map rustic-mode-map
              ("M-n" . flycheck-next-error)
              ("M-p" . flycheck-previous-error)
              ("M-." . bwm:rust-find-definition)
              ("C-." . lsp-ui-peek-find-references)
              ("<C-return>" . helm-lsp-code-actions)
              ("C-h f" . lsp-ui-doc-show)
              ("C-c C-c j" . rust-check)
              ("C-c C-c C-k" . bwm-rustic-cargo-materialize-check)
              ("C-c C-k" . bwm-rustic-cargo-materialize-check)
              ("C-c C-c d" . dap-hydra))
  :custom
  (rustic-format-trigger nil "use lsp format")
  (rustic-lsp-format t "use the lsp server instead of cargo fmt")
  (lsp-ui-doc-show-with-cursor nil "Use `C-h f' for a doc view"))

(add-hook 'before-save-hook
          (lambda ()
            (when (eq major-mode 'rustic-mode)
              (lsp-format-buffer))))

;; one of the two of these should be enabled
(setq lsp-rust-analyzer-proc-macro-enable t)  ; get access to proc macros, will eventually be on by default
(setq lsp-rust-analyzer-import-merge-behaviour "last") ; materialize import style
(setq lsp-rust-analyzer-import-prefix "by_crate")
; (setq lsp-rust-analyzer-diagnostics-disabled '("unresolved-proc-macro"))
