;;; paredit-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "paredit" "paredit.el" (0 0 0 0))
;;; Generated autoloads from paredit.el

(autoload 'paredit-mode "paredit" "\
Minor mode for pseudo-structurally editing Lisp code.\nWith a prefix argument, enable Paredit Mode even if there are\n  unbalanced parentheses in the buffer.\nParedit behaves badly if parentheses are unbalanced, so exercise\n  caution when forcing Paredit Mode to be enabled, and consider\n  fixing unbalanced parentheses instead.\n\\<paredit-mode-map>\n\n(fn &optional ARG)" t nil)

(autoload 'enable-paredit-mode "paredit" "\
Turn on pseudo-structural editing of Lisp code.\n\n(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "paredit" '("paredit-" "?\\" "disable-paredit-mode")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; paredit-autoloads.el ends here
