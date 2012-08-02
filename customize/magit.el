(require 'magit-svn)

(add-hook 'magit-log-edit-mode-hook
	  (lambda ()
	    (set (make-local-variable 'fill-column) 72)
	    (font-lock-add-keywords nil
	     '(;; first line is 50 chars
	       ("\\`[^\n]\\{50\\}\\(.*\\)$" 1 font-lock-warning-face t)
	       ;; second line is off limits-- this doesn't work because
	       ;; font-lock regexps only work for single lines. It should be
	       ;; possible to do with a matcher function, though
	       ;;; ("\\`[^\n]*\n\\([^\n]+\\)" 1 font-lock-warning-face t)
	       ;; all others are 72 chars
	       ("^[^\n]\\{72\\}\\(.*\\)$" 1 font-lock-warning-face t))
	     )))

(add-hook 'magit-mode-hook
	  (lambda ()
	    (when (magit-get "svn-remote" "svn" "url")
	      (magit-svn-mode 1))))
