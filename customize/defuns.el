(defalias 'nuke 'delete-trailing-whitespace)
(defalias 'll 'longlines-mode)
(defalias 'mkdir 'make-directory)
(defalias 'deactivate 'virtualenv-deactivate)
(defalias 'workon 'virtualenv-workon)

(defun unfly ()
  (interactive)
  (flymake-mode 0))

(defun dont-show-trailing-whitespace ()
  (interactive)
  (set (make-local-variable 'show-trailing-whitespace) nil))

(require 'git-tools "packages/git-tools/git-tools.el")
(defalias 'ggrep 'git-tools-grep)

; from http://blog.urth.org/2011/06/flymake-versus-the-catalyst-restarter.html
(defun flymake-create-temp-intemp (file-name prefix)
  "Return file name in temporary directory for checking
   FILE-NAME. This is a replacement for
   `flymake-create-temp-inplace'. The difference is that it gives
   a file name in `temporary-file-directory' instead of the same
   directory as FILE-NAME.

   For the use of PREFIX see that function.

   Note that not making the temporary file in another directory
   \(like here) will not if the file you are checking depends on
   relative paths to other files \(for the type of checks flymake
   makes)."
  (unless (stringp file-name)
    (error "Invalid file-name"))
  (or prefix
      (setq prefix "flymake"))
  (let* ((name (concat
                (file-name-nondirectory
                 (file-name-sans-extension file-name))
                "_" prefix))
         (ext  (concat "." (file-name-extension file-name)))
         (temp-name (make-temp-file name nil ext))
         )
    (flymake-log 3 "create-temp-intemp: file=%s temp=%s" file-name temp-name)
    temp-name))

;;; from http://emacswiki.org/emacs/misc-cmds.el (thanks drew)
(defun read-shell-file-command (command)
  "Prompt for shell COMMAND, using current buffer's file as default arg.
If buffer is not associated with a file, you are prompted for a file.
COMMAND is a symbol."
  (let ((file (or (buffer-file-name) (read-file-name "File: "))))
    (setq file     (and file (file-name-nondirectory file))
          command  (format "%s  " command)) ; Convert to string.
    (read-from-minibuffer
     "" (cons (concat command (and file (concat " " file)))  (length command)))))

;;;###autoload
(defun chmod (cmd)
  "Execute Unix command `chmod'.  Current buffer's file is default arg.
CMD is the command to execute (interactively, `chmod')."
  (interactive (list (read-shell-file-command 'chmod)))
  (shell-command cmd))

;;;###autoload
(defun chgrp (cmd)
  "Execute Unix command `chgrp'.  Current buffer's file is default arg.
CMD is the command to execute (interactively, `chgrp')."
  (interactive (list (read-shell-file-command 'chgrp)))
  (shell-command cmd))

;;;###autoload
(defun chown (cmd)
  "Execute Unix command `chown'.  Current buffer's file is default arg.
CMD is the command to execute (interactively, `chown')."
  (interactive (list (read-shell-file-command 'chown)))
  (shell-command cmd))

(defun end-of-line+ (&optional n)
  "Move cursor to end of current line or end of next line if repeated.
This is similar to `end-of-line', but:
  If called interactively with no prefix arg:
     If the previous command was also `end-of-line+', then move to the
     end of the next line.  Else, move to the end of the current line.
  Otherwise, move to the end of the Nth next line (Nth previous line
     if N<0).  Command `end-of-line', by contrast, moves to the end of
     the (N-1)th next line."
  (interactive
   (list (if current-prefix-arg (prefix-numeric-value current-prefix-arg) 0)))
  (unless n (setq n 0))                 ; non-interactive with no arg
  (if (and (eq this-command last-command) (not current-prefix-arg))
      (forward-line 1)
    (forward-line n))
  (let ((inhibit-field-text-motion  t))  (end-of-line)))

(defun beginning-of-line+ (&optional n)
  "Move cursor to beginning of current line or next line if repeated.
This is the similar to `beginning-of-line', but:
1. With arg N, the direction is the opposite: this command moves
   backward, not forward, N lines.
2. If called interactively with no prefix arg:
      If the previous command was also `beginning-of-line+', then move
      to the beginning of the previous line.  Else, move to the
      beginning of the current line.
   Otherwise, move to the beginning of the Nth previous line (Nth next
      line if N<0).  Command `beginning-of-line', by contrast, moves to
      the beginning of the (N-1)th next line."
  (interactive
   (list (if current-prefix-arg (prefix-numeric-value current-prefix-arg) 0)))
  (unless n (setq n 0))                 ; non-interactive with no arg
  (if (and (eq this-command last-command) (not current-prefix-arg))
      (forward-line -1)
    (forward-line (- n))))

(defun beginning-or-indentation (&optional n)
  "Move cursor to beginning of this line or to its indentation.
If at indentation position of this line, move to beginning of line.
If at beginning of line, move to indentaion.

This is modified from Drew's version to just bounce back and forth"
  (interactive "P")
  (cond ((bolp)
         (back-to-indentation))
        ((save-excursion (skip-chars-backward " \t") (bolp)) ; At indentation.
         (forward-line 0))
        (t (back-to-indentation))))
;;; end misc-cmds
