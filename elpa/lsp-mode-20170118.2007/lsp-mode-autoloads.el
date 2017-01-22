;;; lsp-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "lsp-common" "lsp-common.el" (0 0 0 0))
;;; Generated autoloads from lsp-common.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-common" '("lsp--")))

;;;***

;;;### (autoloads nil "lsp-methods" "lsp-methods.el" (0 0 0 0))
;;; Generated autoloads from lsp-methods.el

(let ((loads (get 'lsp-mode 'custom-loads))) (if (member '"lsp-methods" loads) nil (put 'lsp-mode 'custom-loads (cons '"lsp-methods" loads))))

(defvar lsp-document-sync-method 'full "\
How to sync the document with the language server.")

(custom-autoload 'lsp-document-sync-method "lsp-methods" t)

(defvar lsp-ask-before-initializing t "\
Always ask before initializing a new project.")

(custom-autoload 'lsp-ask-before-initializing "lsp-methods" t)

(defvar lsp-enable-eldoc t "\
Enable `eldoc-mode' integration.")

(custom-autoload 'lsp-enable-eldoc "lsp-methods" t)

(defvar lsp-enable-completion-at-point t "\
Enable `completion-at-point' integration.")

(custom-autoload 'lsp-enable-completion-at-point "lsp-methods" t)

(defvar lsp-enable-xref t "\
Enable xref integration.")

(custom-autoload 'lsp-enable-xref "lsp-methods" t)

(defvar lsp-change-idle-delay 0.5 "\
Number of seconds of idle timer to wait before sending file changes to the server.")

(custom-autoload 'lsp-change-idle-delay "lsp-methods" t)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-methods" '("lsp-")))

;;;***

;;;### (autoloads nil "lsp-mode" "lsp-mode.el" (0 0 0 0))
;;; Generated autoloads from lsp-mode.el

(defvar global-lsp-mode nil "\
Non-nil if Global Lsp mode is enabled.
See the `global-lsp-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-lsp-mode'.")

(custom-autoload 'global-lsp-mode "lsp-mode" nil)

(autoload 'global-lsp-mode "lsp-mode" "\


\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-mode" '("lsp-")))

;;;***

;;;### (autoloads nil "lsp-notifications" "lsp-notifications.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from lsp-notifications.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-notifications" '("lsp--")))

;;;***

;;;### (autoloads nil "lsp-receive" "lsp-receive.el" (0 0 0 0))
;;; Generated autoloads from lsp-receive.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-receive" '("lsp-")))

;;;***

;;;### (autoloads nil "lsp-send" "lsp-send.el" (0 0 0 0))
;;; Generated autoloads from lsp-send.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lsp-send" '("lsp--stdio-send-")))

;;;***

;;;### (autoloads nil nil ("lsp-mode-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; lsp-mode-autoloads.el ends here
