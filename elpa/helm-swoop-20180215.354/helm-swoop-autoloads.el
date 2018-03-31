;;; helm-swoop-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "helm-swoop" "helm-swoop.el" (0 0 0 0))
;;; Generated autoloads from helm-swoop.el

(autoload 'helm-swoop-back-to-last-point "helm-swoop" "\
Go back to last position where `helm-swoop' was called\n\n(fn &optional $CANCEL)" t nil)

(autoload 'helm-swoop "helm-swoop" "\
List the all lines to another buffer, which is able to squeeze by\n any words you input. At the same time, the original buffer's cursor\n is jumping line to line according to moving up and down the list.\n\n(fn &key $QUERY $SOURCE ($MULTILINE current-prefix-arg))" t nil)

(autoload 'helm-swoop-from-isearch "helm-swoop" "\
Invoke `helm-swoop' from isearch.\n\n(fn)" t nil)

(autoload 'helm-multi-swoop "helm-swoop" "\
Usage:\nM-x helm-multi-swoop\n1. Select any buffers by [C-SPC] or [M-SPC]\n2. Press [RET] to start helm-multi-swoop\n\nC-u M-x helm-multi-swoop\nIf you have done helm-multi-swoop before, you can skip select buffers step.\nLast selected buffers will be applied to helm-multi-swoop.\n\n(fn &optional $QUERY $BUFLIST)" t nil)

(autoload 'helm-multi-swoop-all "helm-swoop" "\
Apply all buffers to helm-multi-swoop\n\n(fn &optional $QUERY)" t nil)

(autoload 'helm-multi-swoop-org "helm-swoop" "\
Applies all org-mode buffers to helm-multi-swoop\n\n(fn &optional $QUERY)" t nil)

(autoload 'helm-multi-swoop-current-mode "helm-swoop" "\
Applies all buffers of the same mode as the current buffer to helm-multi-swoop\n\n(fn &optional $QUERY)" t nil)

(autoload 'helm-multi-swoop-projectile "helm-swoop" "\
Apply all opened buffers of the current project to helm-multi-swoop\n\n(fn &optional $QUERY)" t nil)

(autoload 'helm-swoop-without-pre-input "helm-swoop" "\
Start helm-swoop without pre input query.\n\n(fn)" t nil)

(autoload 'helm-swoop-symble-pre-input "helm-swoop" "\
Start helm-swoop without pre input query.\n\n(fn)" t nil)

(autoload 'helm-multi-swoop-edit "helm-swoop" "\
\n\n(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "helm-swoop" '("helm-" "get-buffers-matching-mode")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; helm-swoop-autoloads.el ends here
