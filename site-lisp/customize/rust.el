(defun bwm:rust-find-definition (prefix)
  (interactive "p")
  (if (eq prefix 1)
      (lsp-ui-peek-find-definitions)
    (lsp-ui-peek-find-implementation)))

(defun bwm:rustic-cargo-materialize-check (prefix)
  "Run 'cargo check' for the current project.

Prefix arguments affect what is checked:

* No arguments check the current crate
* One prefix arg checks all of materialized
* Two prefix args runs bin/check to trigger the materialize clippy lints
* Three prefix args runs `bin/check --fix' to auto-fix the materialize clippy lints
"
  (interactive "p")
  (let ((wdir (string-trim-right (rustic-buffer-workspace) "/"))
        (current-crate (file-name-nondirectory (string-trim-right (rustic-buffer-crate) "/"))))
    (cond
     ((< prefix 16)
      (let ((package (if (= prefix 1) current-crate
                       "materialized")))
        (rustic-run-cargo-command
         (format "cargo check -p %s" package)
         (list :directory wdir))))
     ((= prefix 16)
      (rustic-run-cargo-command (concat wdir "/bin/check") (list :directory wdir)))
     ((= prefix 64)
      (rustic-run-cargo-command (concat wdir "/bin/check --fix") (list :directory wdir)))
     (t (message "at most 3 prefix calls are recognized. prefix: %s" prefix)))))

;; Speed up rust compilation, using the same flags as elsewhere
;; enabling these causes trait-resolution compilation errors
;; (setenv "CARGO_PROFILE_DEV_DEBUG" "1")
;; (setenv "RUSTFLAGS" " -Csplit-debuginfo=unpacked -Clink-arg=-fuse-ld=lld")

(setenv "PATH" (concat (getenv "HOME") "/.local/clang/bin" ":"
                       (getenv "PATH")))

(defun bwm:configure-rust-before-save-hook ()
  (add-hook 'before-save-hook
            (defun bwm:rustfmt-on-save ()
              (when (eq 'rustic-mode major-mode)
                (lsp-format-buffer)))
            nil t))

(use-package rustic
  :bind (:map rustic-mode-map
              ("M-n" . flycheck-next-error)
              ("M-p" . flycheck-previous-error)
              ("M-." . bwm:rust-find-definition)
              ("C-." . lsp-ui-peek-find-references)
              ("<C-return>" . helm-lsp-code-actions)
              ("C-h f" . lsp-ui-doc-show)
              ("C-c C-c C-k" . bwm:rustic-cargo-materialize-check)
              ("C-c C-k" . bwm:rustic-cargo-materialize-check)
              ("C-c C-c d" . dap-hydra))
  :hook (rustic-mode . bwm:configure-rust-before-save-hook)
  :custom
  (rustic-format-trigger nil "use lsp format")
  (rustic-lsp-format t "use the lsp server instead of cargo fmt")
  (lsp-ui-doc-show-with-cursor nil "Use `C-h f' for a doc view")
  (lsp-rust-analyzer-proc-macro-enable t)
  (lsp-rust-analyzer-import-merge-behaviour "last")
  (lsp-rust-analyzer-import-prefix "by_crate"))

;; Debugging

;; troubleshooting in https://github.com/emacs-lsp/dap-mode/issues/try The
;; command defined by `dap-gdb-lldb-debug-program' should work I needed to
;; manually download
;; https://marketplace.visualstudio.com/items?itemName=webfreak.debug copy it into
;; ~/.emacs.d/.extension/vscode/webfreak.debug/ and unzip it

;; (use-package dap-mode
;;   :ensure t
;;   :config
;;   (dap-auto-configure-mode)

;;   (require 'dap-lldb)
;;   (require 'dap-gdb-lldb)
;;   ;; installs .extension/vscode
;;   (dap-gdb-lldb-setup)
;;   (setenv "MZ_DEV" "1")
;;   (dap-register-debug-template
;;    "Rust::LLDB Run Configuration"
;;    (list :type "lldb"
;;          :request "launch"
;;          :name "LLDB::Run"
;; 	 :gdbpath "rust-lldb"
;;          :target nil
;;          :cwd nil))
;;   (dap-register-debug-template
;;    "materialize"
;;    (list :type "lldb"
;;          :request "launch"
;;          :name "LLDB::Run"
;; 	 :gdbpath "rust-lldb"
;;          :target nil
;;          :cwd "/Users/bwm/github/materialize"))
;;   (add-hook 'dap-stopped-hook
;;             (lambda (arg) (call-interactively #'dap-hydra))))
