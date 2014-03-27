(defun bwm/byte-compile (arg)
  "Either eval the current file, compile the file, or recompile emacs.d

Yeah I know they're not actually related functions."
  (interactive "P")
  (cond ((and arg (> 4 (car arg)))
         (let ((dir (expand-file-name "~/.emacs.d")))
           (message "recompiling %s" dir)
           (byte-recompile-directory dir 0)))
        (arg
         (byte-compile-file (buffer-file-name)))
        (t
         (eval-buffer)
         (message "eval'd %s" (buffer-file-name)))))

(add-hook 'emacs-lisp-mode-hook
	  (lambda ()
            (paredit-mode)
            (local-set-key (kbd "C-c C-c") 'bwm/byte-compile)))
