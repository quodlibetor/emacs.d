;;; rustic-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "rustic" "rustic.el" (0 0 0 0))
;;; Generated autoloads from rustic.el

(autoload 'rustic-mode "rustic" "\
Major mode for Rust code.

\\{rustic-mode-map}

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.rs\\'" . rustic-mode))

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "rustic" '("rust")))

;;;***

;;;### (autoloads nil "rustic-babel" "rustic-babel.el" (0 0 0 0))
;;; Generated autoloads from rustic-babel.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "rustic-babel" '("org-babel-execute:rustic" "rustic-babel-")))

;;;***

;;;### (autoloads nil "rustic-cargo" "rustic-cargo.el" (0 0 0 0))
;;; Generated autoloads from rustic-cargo.el

(autoload 'rustic-cargo-clippy "rustic-cargo" "\
Run `cargo clippy'.

\(fn)" t nil)

(autoload 'rustic-cargo-test "rustic-cargo" "\
Run 'cargo test'.

If ARG is not nil, use value as argument and store it in `rustic-test-arguments'

\(fn &optional ARG)" t nil)

(autoload 'rustic-cargo-current-test "rustic-cargo" "\
Run 'cargo test' for the test near point.

\(fn)" t nil)

(autoload 'rustic-cargo-new "rustic-cargo" "\
Run 'cargo new' to start a new package in the path specified by PROJECT-PATH.
If BIN is not nil, create a binary application, otherwise a library.

\(fn PROJECT-PATH &optional BIN)" t nil)

(autoload 'rustic-cargo-build "rustic-cargo" "\
Run 'cargo build' for the current project.

\(fn)" t nil)

(autoload 'rustic-cargo-run "rustic-cargo" "\
Run 'cargo run' for the current project.

\(fn)" t nil)

(autoload 'rustic-cargo-clean "rustic-cargo" "\
Run 'cargo clean' for the current project.

\(fn)" t nil)

(autoload 'rustic-cargo-check "rustic-cargo" "\
Run 'cargo check' for the current project.

\(fn)" t nil)

(autoload 'rustic-cargo-bench "rustic-cargo" "\
Run 'cargo bench' for the current project.

\(fn)" t nil)

(autoload 'rustic-cargo-build-doc "rustic-cargo" "\
Build the documentation for the current project.

\(fn)" t nil)

(autoload 'rustic-cargo-doc "rustic-cargo" "\
Open the documentation for the current project in a browser.
The documentation is built if necessary.

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "rustic-cargo" '("rustic-")))

;;;***

;;;### (autoloads nil "rustic-compile" "rustic-compile.el" (0 0 0
;;;;;;  0))
;;; Generated autoloads from rustic-compile.el

(autoload 'rustic-compile "rustic-compile" "\
Compile rust project.
If called without arguments use `rustic-compile-command'.

Otherwise use provided argument ARG and store it in
`compilation-arguments'.

\(fn &optional ARG)" t nil)

(autoload 'rustic-recompile "rustic-compile" "\
Re-compile the program using `compilation-arguments'.

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "rustic-compile" '("rust")))

;;;***

;;;### (autoloads nil "rustic-flycheck" "rustic-flycheck.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from rustic-flycheck.el

(autoload 'rustic-flycheck-setup "rustic-flycheck" "\
Setup Rust in Flycheck.

If the current file is part of a Cargo project, configure
Flycheck according to the Cargo project layout.

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "rustic-flycheck" '("rustic-flycheck-")))

;;;***

;;;### (autoloads nil "rustic-interaction" "rustic-interaction.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from rustic-interaction.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "rustic-interaction" '("rustic-")))

;;;***

;;;### (autoloads nil "rustic-lsp" "rustic-lsp.el" (0 0 0 0))
;;; Generated autoloads from rustic-lsp.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "rustic-lsp" '("rustic-analyzer-")))

;;;***

;;;### (autoloads nil "rustic-popup" "rustic-popup.el" (0 0 0 0))
;;; Generated autoloads from rustic-popup.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "rustic-popup" '("rustic-popup")))

;;;***

;;;### (autoloads nil "rustic-racer" "rustic-racer.el" (0 0 0 0))
;;; Generated autoloads from rustic-racer.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "rustic-racer" '("racer-src-button" "rustic-racer-")))

;;;***

;;;### (autoloads nil "rustic-util" "rustic-util.el" (0 0 0 0))
;;; Generated autoloads from rustic-util.el

(autoload 'rustic-cargo-fmt "rustic-util" "\
Use rustfmt via cargo.

\(fn)" t nil)

(autoload 'rustic-rustfix "rustic-util" "\
Run 'cargo fix'.

\(fn)" t nil)

(autoload 'rustic-playpen "rustic-util" "\
Create a shareable URL for the contents of the current region,
src-block or buffer on the Rust playpen.

\(fn BEGIN END)" t nil)

(autoload 'rustic-open-dependency-file "rustic-util" "\
Open the 'Cargo.toml' file at the project root if the current buffer is
visiting a project.

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "rustic-util" '("rustic-")))

;;;***

;;;### (autoloads nil nil ("rustic-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; rustic-autoloads.el ends here
