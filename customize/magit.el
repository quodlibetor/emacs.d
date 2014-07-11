(require 'magit-svn)

(add-hook 'magit-mode-hook
	  (lambda ()
	    (when (magit-get "svn-remote" "svn" "url")
	      (magit-svn-mode 1))))

(setq magit-auto-revert-mode-lighter ""
      magit-gitk-executable "/usr/bin/gitk")
