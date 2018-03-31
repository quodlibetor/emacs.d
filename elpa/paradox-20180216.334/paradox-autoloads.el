;;; paradox-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "paradox" "paradox.el" (0 0 0 0))
;;; Generated autoloads from paradox.el

(autoload 'paradox-list-packages "paradox" "\
Improved version of `package-list-packages'.  The heart of Paradox.\nFunction is equivalent to `package-list-packages' (including the\nprefix NO-FETCH), but the resulting Package Menu is improved in\nseveral ways.\n\nAmong them:\n\n1. Uses `paradox-menu-mode', which has more functionality and\nkeybinds than `package-menu-mode'.\n\n2. Uses some font-locking to improve readability.\n\n3. Optionally shows the number GitHub stars and Melpa downloads\nfor packages.\n\n4. Adds useful information in the mode-line.\n\n(fn NO-FETCH)" t nil)

(autoload 'paradox-upgrade-packages "paradox" "\
Upgrade all packages.  No questions asked.\nThis function is equivalent to `list-packages', followed by a\n`package-menu-mark-upgrades' and a `package-menu-execute'.  Except\nthe user isn't asked to confirm deletion of packages.\n\nIf `paradox-execute-asynchronously' is non-nil, part of this\noperation may be performed in the background.\n\nThe NO-FETCH prefix argument is passed to `list-packages'.  It\nprevents re-download of information about new versions.  It does\nnot prevent downloading the actual packages (obviously).\n\n(fn &optional NO-FETCH)" t nil)

(autoload 'paradox-require "paradox" "\
Like `require', but also install FEATURE if it is absent.\nFILENAME is passed to `require'.\nIf NOERROR is non-nil, don't complain if the feature couldn't be\ninstalled, just return nil.\n\n- If FEATURE is present, `require' it and return t.\n\n- If FEATURE is not present, install PACKAGE with `package-install'.\nIf PACKAGE is nil, assume FEATURE is the package name.\nAfter installation, `require' FEATURE.\n\nBy default, the current package database is only updated if it is\nempty.  Passing a non-nil REFRESH argument forces this update.\n\n(fn FEATURE &optional FILENAME NOERROR PACKAGE REFRESH)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "paradox" '("paradox-")))

;;;***

;;;### (autoloads nil "paradox-commit-list" "paradox-commit-list.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from paradox-commit-list.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "paradox-commit-list" '("paradox-")))

;;;***

;;;### (autoloads nil "paradox-core" "paradox-core.el" (0 0 0 0))
;;; Generated autoloads from paradox-core.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "paradox-core" '("paradox-")))

;;;***

;;;### (autoloads nil "paradox-execute" "paradox-execute.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from paradox-execute.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "paradox-execute" '("paradox-")))

;;;***

;;;### (autoloads nil "paradox-github" "paradox-github.el" (0 0 0
;;;;;;  0))
;;; Generated autoloads from paradox-github.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "paradox-github" '("paradox-")))

;;;***

;;;### (autoloads nil "paradox-menu" "paradox-menu.el" (0 0 0 0))
;;; Generated autoloads from paradox-menu.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "paradox-menu" '("paradox-")))

;;;***

;;;### (autoloads nil nil ("paradox-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; paradox-autoloads.el ends here
