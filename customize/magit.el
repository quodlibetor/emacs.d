(add-hook 'magit-log-edit-mode-hook
	  (lambda ()
	    (set (make-local-variable 'fill-column) 72)
	    (font-lock-add-keywords nil
	     '(("\\`[^\n]\\{50\\}\\(.*\\)$" 1 font-lock-warning-face t)
	       ("^[^\n]\\{72\\}\\(.*\\)$" 1 font-lock-warning-face t)))))
