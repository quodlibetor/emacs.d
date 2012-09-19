(setq org-hide-leading-stars t
      org-columns-default-format "%35ITEM(Task) %17Effort(Estimated Effort){:} %CLOCKSUM(Time Spent) %TODO %3PRIORITY %TAGS"
      org-clock-into-drawer t
      org-todo-keywords '((sequence "TODO(t)" "IN-PROGRESS(i)" "|" "DONE(d)")
			  (sequence "NEXT(n)" "|")
			  (sequence "BUG(b)" "|" "FIXED(f)" "WONTFIX(w)"))
      org-log-done 'time
      org-use-speed-commands t
      org-clock-out-remove-zero-time-clocks t
      )

(defun set-agenda-files ()
  (setq org-agenda-files (append '("~/work.org" "~/life.org") (file-expand-wildcards "~/projects/*/*.org")))
  (message "Agenda files set to %s" org-agenda-files))

(defadvice org-agenda (before refresh-agenda-files activate)
  "make sure that all agenda files are included"
  (set-agenda-files))

(add-hook 'org-mode-hook
	  (lambda ()
	    (set (make-local-variable 'fill-column) 80)))
