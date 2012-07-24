(setq org-hide-leading-stars t
      org-agenda-files '("~/work.org" "~/projects/subman/subman.org")
      org-columns-default-format "%35ITEM(Task) %17Effort(Estimated Effort){:} %CLOCKSUM(Time Spent) %TODO %3PRIORITY %TAGS"
      org-clock-into-drawer t
      org-todo-keywords '((sequence "TODO(t)" "IN-PROGRESS(i)" "|" "DONE")
			  (sequence "|" "NEXT(n)" "|")
			  (sequence "BUG(b)" "|" "FIXED" "WONTFIX")))

(add-hook 'org-mode-hook
	  (lambda ()
	    (set (make-local-variable 'fill-column) 80)))
