;;; helm-projectile-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "helm-projectile" "helm-projectile.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from helm-projectile.el

(defvar helm-projectile-fuzzy-match t "\
Enable fuzzy matching for Helm Projectile commands.\nThis needs to be set before loading helm-projectile.el.")

(custom-autoload 'helm-projectile-fuzzy-match "helm-projectile" t)

(autoload 'helm-projectile-find-file-dwim "helm-projectile" "\
Find file at point based on context.\n\n(fn)" t nil)

(autoload 'helm-projectile-find-other-file "helm-projectile" "\
Switch between files with the same name but different extensions using Helm.\nWith FLEX-MATCHING, match any file that contains the base name of current file.\nOther file extensions can be customized with the variable `projectile-other-file-alist'.\n\n(fn &optional FLEX-MATCHING)" t nil)

(autoload 'helm-projectile-on "helm-projectile" "\
Turn on `helm-projectile' key bindings.\n\n(fn)" t nil)

(autoload 'helm-projectile-off "helm-projectile" "\
Turn off `helm-projectile' key bindings.\n\n(fn)" t nil)

(autoload 'helm-projectile-grep "helm-projectile" "\
Helm version of `projectile-grep'.\nDIR is the project root, if not set then current directory is used\n\n(fn &optional DIR)" t nil)

(autoload 'helm-projectile-ack "helm-projectile" "\
Helm version of projectile-ack.\n\n(fn &optional DIR)" t nil)

(autoload 'helm-projectile-ag "helm-projectile" "\
Helm version of `projectile-ag'.\n\n(fn &optional OPTIONS)" t nil)

(autoload 'helm-projectile-toggle "helm-projectile" "\
Toggle Helm version of Projectile commands.\n\n(fn TOGGLE)" nil nil)

(autoload 'helm-projectile "helm-projectile" "\
Use projectile with Helm instead of ido.\n\nWith a prefix ARG invalidates the cache first.\nIf invoked outside of a project, displays a list of known projects to jump.\n\n(fn &optional ARG)" t nil)

(eval-after-load 'projectile '(progn (define-key projectile-command-map (kbd "h") #'helm-projectile)))

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "helm-projectile" '("helm-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; helm-projectile-autoloads.el ends here
