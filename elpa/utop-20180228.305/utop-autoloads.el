;;; utop-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "utop" "utop.el" (0 0 0 0))
;;; Generated autoloads from utop.el

(autoload 'utop-minor-mode "utop" "\
Minor mode for utop.\n\n(fn &optional ARG)" t nil)

(autoload 'utop-mode "utop" "\
Set the buffer mode to utop.\n\n(fn)" t nil)

(autoload 'utop "utop" "\
A universal toplevel for OCaml.\n\nurl: https://forge.ocamlcore.org/projects/utop/\n\nutop is a enhanced toplevel for OCaml with many features,\nincluding context sensitive completion.\n\nThis is the emacs frontend for utop. You can use the utop buffer\nas a standard OCaml toplevel.\n\nTo complete an identifier, simply press TAB.\n\nSpecial keys for utop:\n\\{utop-mode-map}\n\n(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "utop" '("utop-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; utop-autoloads.el ends here
