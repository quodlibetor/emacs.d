;;; helm-fd-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "helm-fd" "helm-fd.el" (0 0 0 0))
;;; Generated autoloads from helm-fd.el

(autoload 'helm-fd-project "helm-fd" "\
Preconfigured `helm-fd' for search within the current project.

If the current file isn't part of a VCS project,
`default-directory' will be the location where the current Emacs
process was started.

Also note that the displayed paths are relative to project root.

\(fn)" t nil)

(autoload 'helm-fd "helm-fd" "\
Preconfigured `helm' for the fd shell command.

Recursively find files whose names are matched by all specified
globbing PATTERNs under the current directory using the external
program \"fd\" specified in `helm-fd-cmd'.  Input PATTERNs are
interleaved with \".*?\".

With prefix argument ARG, prompt for a directory to search.

The list of globbing PATTERNs can be followed by the separator
\"*\" plus any number of additional arguments that are passed to
\"fd\" literally.

\(fn ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "helm-fd" '("helm-fd-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; helm-fd-autoloads.el ends here
