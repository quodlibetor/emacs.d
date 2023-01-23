(require 'ibuffer)
(require 'f)

(defun bwm/list-app-dirs ()
  (let ((app-dirs nil)
        (code-dirs (list
		    (expand-file-name "~/repos")
		    )))
    (dolist (code-dir code-dirs)
      (dolist (fname (directory-files code-dir nil "^[^.]"))
        (let ((fullname (concat (file-name-as-directory code-dir) fname)))
          (when (not (member fullname code-dirs))
            (setq app-dirs
                  (cons (list
                         (concat fname " |" (f-base code-dir))
                         (cons 'filename fullname))
                        app-dirs))))))
    (sort app-dirs (lambda (l r) (string< (car l) (car r))))))

(setq ibuffer-show-empty-filter-groups nil)
(defun bwm/reload-ibuffer-filter-groups ()
  "Reload app-dirs"
  (setq ibuffer-saved-filter-groups
        (list
         (cons "verbose"
               (apply #'append
                      '(("Notes" (mode . org-mode))
                        ("Explore" (or (mode . compilation-mode)
                                       (name . "*nosetests*")
                                       (mode . grep-mode))))
                      (bwm/list-app-dirs)
                      '((("Code" (mode . python-mode))
                         ("Wiki" (or (mode . confluence-edit-mode)
                                     (mode . confluence-mode)))
                         ("Emacs" (or (mode . emacs-lisp)
                                      (filename . "emacs.d/")))
                         ("VC" (or (mode . magit-status-mode)
                                   (mode . magit-commit-mode)
                                   (mode . magit-log-mode)
                                   (mode . vc-annotate-mode)))
                         ("Dired" (mode . dired-mode))))))
         '("simple"
           ("Code" (mode . python-mode))
           ("Explore" (or (mode . compilation-mode)
                          (name . "*nosetests*")
                          (mode . grep-mode)))
           ("Wiki" (or (mode . confluence-edit-mode)
                       (mode . confluence-mode)))
           ("Notes" (mode . org-mode))
           ("Emacs" (or (mode . emacs-lisp)
                        (filename . "emacs.d/")))
           ("VC" (or (mode . magit-status-mode)
                     (mode . magit-commit-mode)
                     (mode . magit-log-mode)
                     (mode . vc-annotate-mode)))
           ("Dired" (mode . dired-mode))))))
(bwm/reload-ibuffer-filter-groups)

(defun bwm/ibuffer-update (arg &optional silent)
  (interactive "P")
  (bwm/reload-ibuffer-filter-groups)
  (ibuffer-update arg silent)
  (ibuffer-switch-to-saved-filter-groups "verbose"))

(add-hook 'ibuffer-mode-hook
	  (lambda ()
	    (ibuffer-switch-to-saved-filter-groups "verbose")
            (local-set-key "g" 'bwm/ibuffer-update)))
