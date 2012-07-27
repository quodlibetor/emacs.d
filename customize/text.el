(add-hook 'text-mode-hook
	  (lambda ()
	    (when (string-match "e\\.advance\\.net" (buffer-file-name))
	      (setq fill-column 72))))
