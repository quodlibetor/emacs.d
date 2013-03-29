(let ((load-path (cons "~/.emacs.d/packages/confluence-1.6beta" load-path)))
  (require 'xml-rpc)
  (require 'confluence))
(setq confluence-url "https://wiki.advance.net/rpc/xmlrpc"
      confluence-save-credentials t
      confluence-default-space-alist (list
				      (cons confluence-url "services")
				      (cons confluence-url "~bmaister")
				      (cons confluence-url "tech"))
      confluence-auto-save-dir temporary-file-directory
      )

(add-hook 'confluence-mode-hook
          (lambda ()
	    (local-set-key (kbd "\C-c") confluence-prefix-map)
	    (local-set-key "\M-j" 'confluence-newline-and-indent)
	    (local-set-key "\M-;" 'confluence-list-indent-dwim)
	    (longlines-mode)))

(eval-after-load "confluence"
  '(progn
     (require 'longlines)
     (progn
       (add-hook 'confluence-before-save-hook 'longlines-before-revert-hook)
       (add-hook 'confluence-before-revert-hook 'longlines-before-revert-hook))))

(eval-after-load "longlines"
  '(progn
     (defvar longlines-mode-was-active nil)
     (make-variable-buffer-local 'longlines-mode-was-active)

     (defun longlines-suspend ()
       (if longlines-mode
           (progn
             (setq longlines-mode-was-active t)
             (longlines-mode 0))))

     (defun longlines-restore ()
       (if longlines-mode-was-active
           (progn
             (setq longlines-mode-was-active nil)
             (longlines-mode 1))))

     ;; longlines doesn't play well with ediff, so suspend it during diffs
     (defadvice ediff-make-temp-file (before make-temp-file-suspend-ll
                                             activate compile preactivate)
       "Suspend longlines when running ediff."
       (with-current-buffer (ad-get-arg 0)
         (longlines-suspend)))


     (add-hook 'ediff-cleanup-hook
               '(lambda ()
                  (dolist (tmp-buf (list ediff-buffer-A
                                         ediff-buffer-B
                                         ediff-buffer-C))
                    (if (buffer-live-p tmp-buf)
                        (with-current-buffer tmp-buf
                          (longlines-restore))))))))

(add-to-list 'auto-mode-alist
             '(".c\(on\)?fl\(uen\)?ce?\\'" . confluence-edit-mode))
(add-to-list 'auto-mode-alist
	     '("jira.*txt\\'" . confluence-edit-mode))
