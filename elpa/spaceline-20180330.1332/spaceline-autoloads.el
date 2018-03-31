;;; spaceline-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "spaceline" "spaceline.el" (0 0 0 0))
;;; Generated autoloads from spaceline.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "spaceline" '("spaceline-")))

;;;***

;;;### (autoloads nil "spaceline-config" "spaceline-config.el" (0
;;;;;;  0 0 0))
;;; Generated autoloads from spaceline-config.el

(autoload 'spaceline-spacemacs-theme "spaceline-config" "\
Install the modeline used by Spacemacs.\n\nADDITIONAL-SEGMENTS are inserted on the right, between `global' and\n`buffer-position'.\n\n(fn &rest ADDITIONAL-SEGMENTS)" nil nil)

(autoload 'spaceline-emacs-theme "spaceline-config" "\
Install a modeline close to the one used by Spacemacs, but which\nlooks better without third-party dependencies.\n\nADDITIONAL-SEGMENTS are inserted on the right, between `global' and\n`buffer-position'.\n\n(fn &rest ADDITIONAL-SEGMENTS)" nil nil)

(defvar spaceline-helm-mode nil "\
Non-nil if Spaceline-Helm mode is enabled.\nSee the `spaceline-helm-mode' command\nfor a description of this minor mode.\nSetting this variable directly does not take effect;\neither customize it (see the info node `Easy Customization')\nor call the function `spaceline-helm-mode'.")

(custom-autoload 'spaceline-helm-mode "spaceline-config" nil)

(autoload 'spaceline-helm-mode "spaceline-config" "\
Customize the mode-line in helm.\n\n(fn &optional ARG)" t nil)

(defvar spaceline-info-mode nil "\
Non-nil if Spaceline-Info mode is enabled.\nSee the `spaceline-info-mode' command\nfor a description of this minor mode.\nSetting this variable directly does not take effect;\neither customize it (see the info node `Easy Customization')\nor call the function `spaceline-info-mode'.")

(custom-autoload 'spaceline-info-mode "spaceline-config" nil)

(autoload 'spaceline-info-mode "spaceline-config" "\
Customize the mode-line in info.\nThis minor mode requires info+.\n\n(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "spaceline-config" '("spaceline--")))

;;;***

;;;### (autoloads nil "spaceline-segments" "spaceline-segments.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from spaceline-segments.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "spaceline-segments" '("spaceline-")))

;;;***

;;;### (autoloads nil nil ("spaceline-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; spaceline-autoloads.el ends here
