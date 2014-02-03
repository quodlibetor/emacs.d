(defun bwm/byte-compile (arg)
  "Either eval the current file, or recompile emacs.d

Yeah I know they're not actually related functions."
  (interactive "P")
  (if arg
      (let ((dir (expand-file-name "~/.emacs.d")))
        (message "recompiling %s" dir)
        (byte-recompile-directory dir 0))
    (eval-buffer)))

(add-hook 'emacs-lisp-mode-hook
	  (lambda ()
            (paredit-mode)
            (local-set-key (kbd "C-c C-c") 'bwm/byte-compile)))
