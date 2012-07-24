(setq ibuffer-saved-filter-groups
      '(("default"
	 ("code" (mode . python-mode))
	 ("wiki" (or
		  (mode . confluence-edit-mode)
		  (mode . confluence-mode)))
	 ("notes" (mode . org-mode))
	 ("emacs" (or
		   (mode . emacs-lisp)
		   (filename . "emacs.d/"))))))
(add-hook 'ibuffer-mode-hook
	  (lambda ()
	    (ibuffer-switch-to-saved-filter-groups "default")))
