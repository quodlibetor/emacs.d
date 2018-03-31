;;; pydoc-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "pydoc" "pydoc.el" (0 0 0 0))
;;; Generated autoloads from pydoc.el

(autoload 'pydoc-mode "pydoc" "\
Major mode for viewing pydoc output.\nCommands:\n\\{pydoc-mode-map}\n\n(fn)" t nil)

(autoload 'pydoc "pydoc" "\
Display pydoc information for NAME in `pydoc-buffer'.\nCompletion is provided with candidates from `pydoc-all-modules'.\nThis is cached for speed. Use a prefix arg to refresh it.\n\n(fn NAME)" t nil)

(autoload 'pydoc-at-point "pydoc" "\
Try to get help for thing at point.\nRequires the python package jedi to be installed.\n\nThere is no way right now to get to the full module path. This is a known limitation in jedi.\n\n(fn)" t nil)

(autoload 'pydoc-browse "pydoc" "\
Open a browser to pydoc.\nAttempts to find an open port, and to reuse the process.\n\n(fn)" t nil)

(autoload 'pydoc-browse-kill "pydoc" "\
Kill the pydoc browser.\n\n(fn)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "pydoc" '("*pydoc-" "pydoc-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; pydoc-autoloads.el ends here
