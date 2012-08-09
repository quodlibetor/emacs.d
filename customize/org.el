(setq org-hide-leading-stars t
      org-agenda-files (append '("~/work.org" "~/life.org") (file-expand-wildcards "~/projects/*/*.org"))
      org-columns-default-format "%35ITEM(Task) %17Effort(Estimated Effort){:} %CLOCKSUM(Time Spent) %TODO %3PRIORITY %TAGS"
      org-clock-into-drawer t
      org-todo-keywords '((sequence "TODO(t)" "IN-PROGRESS(i)" "|" "DONE")
			  (sequence "|" "NEXT(n)" "|")
			  (sequence "BUG(b)" "|" "FIXED" "WONTFIX"))
      org-use-speed-commands t
      org-clock-out-remove-zero-time-clocks t
      )

(add-hook 'org-mode-hook
	  (lambda ()
	    (set (make-local-variable 'fill-column) 80)))
