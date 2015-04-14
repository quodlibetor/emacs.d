(add-hook 'text-mode-hook
	  (lambda ()
	    (when (and (buffer-file-name)
		       (string-match "e\\.advance\\.net" (buffer-file-name)))
	      (setq fill-column 72))))
