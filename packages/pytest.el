;;; pytest.el --- integration with py.test
;;; version: 0.1

;; Copyright (C) 2011 Antonio Cuni
;; Author: Antonio Cuni <anto.cuni@gmail.com>

;; Description
;; -----------
;;
;; This file contains some useful functions to run py.test from within emacs.
;;
;; If you are editing a test file (i.e., a file named test_*.py), you can run
;; pytest-run-file to start py.test on that file.  You will be able to edit
;; the actual py.test command to run in the minibuffer, so you can add all the
;; flags you want (e.g., -s or --pdb).
;;
;; If you are editing a non-test file, pytest-run-file by default will start
;; py.test on the directory where the file is in.
;;
;; If you are editing a test file and want to run the very specific test you
;; are editing, you can run pytest-run-method, which will add the
;; corresponding "-k" option to py.test.  You can still edit the command in
;; the minibuffer before running it.
;;
;; If you want to re-run the last py.test command, you can use
;; pytest-run-again.  By default, pytest-run-again does not ask you to edit
;; the minibuffer, but you can still do it by prefixing pytest-run-again with
;; C-u.
;;
;; The py.test process is run inside an ansi term provided by term.el: this
;; means that if you use --pdb or explicitly have a pdb.set_trace() in your
;; code, the (Pdb) prompt will "just work", including the colored output and
;; the TAB-completion provided by e.g. pdb++.
;;
;; Default keybindings
;; -------------------
;;
;; By default, the functions are bound to the "C-x t" map, which is unused in
;; the default emacs settings.
;;
;; key             binding
;; ---             -------
;; C-x t f         pytest-run-file
;; C-x t m         pytest-run-method
;; C-x t t         pytest-run-again
;; C-u C-x t t     pytest-run-again (after editing in the minibuffer)


(require 'term)

(defvar ctl-c-t-map (make-sparse-keymap)
  "Keymap for subcommands of C-x t.")
;(define-key ctl-c-map "t" ctl-c-t-map)
(define-key ctl-c-t-map "t" 'pytest-run-again)
(define-key ctl-c-t-map "f" 'pytest-run-file)
(define-key ctl-c-t-map "m" 'pytest-run-method)
(add-hook 'python-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c t o") 'pytest-compile-function)
            (local-set-key (kbd "C-c t m") 'pytest-compile-file)
            (local-set-key (kbd "C-c t a") 'pytest-compile-all)
            (local-set-key (kbd "C-c t r o") 'pytest-run-function)
            (local-set-key (kbd "C-c t r m") 'pytest-run-file)
            (local-set-key (kbd "C-c t r m") 'pytest-run-all)
            (local-set-key (kbd "C-c t r t") 'pytest-run-again)
            (local-set-key (kbd "C-c t p o") 'pytest-pdb-function)
            (local-set-key (kbd "C-c t p o") 'pytest-pdb-file)
            (local-set-key (kbd "C-c t p o") 'pytest-pdb-all)))

(defvar pytest-run-history nil)

(defconst pytest-def-re "def \\(test_[A-Za-z0-9_]+\\)")

(defcustom pytest-project-root-files
  '("setup.py" ".git" ".hg")
  "Files that mark the root of a project for testing

Used if `virtualenv-default-directory' is not bound.
"
  :group 'pytest)

(defcustom pytest-test-runner
  nil
  "Test runner to use to run tests

`nil' means to try to use py.test from `virtualenv-workon', or if
that's not set to use a global py.test command"
  :group 'pytest)

(defun pytest-locate-dominating-file ()
  (cond
   ((boundp 'virtualenv-default-directory)
    virtualenv-default-directory)
   (t
    (let ((pytest-dom-re (mapconcat 'identity pytest-project-root-files "\\|")))
      (locate-dominating-file
       (buffer-file-name)
       (lambda (dir)
         (when (file-directory-p dir)
           (directory-files dir nil pytest-dom-re))))))))

(defun get-pytest-bin ()
  (if pytest-test-runner
      (let ((runner-dir (locate-dominating-file (buffer-file-name)
                                                 pytest-test-runner)))
        (file-truename (concat runner-dir "/" pytest-test-runner)))
    (let ((virtualenv (if (boundp 'virtualenv-workon)
                          (concat (expand-file-name virtualenv-root)
                                  "/"
                                  virtualenv-workon
                                  "/bin")
                        ".")))
      (concat virtualenv "/py.test"))))

(defun local-pytest-bufname ()
  "Get the appropriate pytest buffer for the current buffer

Tries to get pytest for the local virtualenv, falling back to global"
  (if (boundp 'virtualenv-workon)
      (format "*%s-pytest*" virtualenv-workon)
    "*pytest*"))

(defun pytest-term-sentinel (proc msg)
  (term-sentinel proc msg)
  (when (memq (process-status proc) '(signal exit))
    (with-current-buffer (local-pytest-bufname)
      (setq buffer-read-only t)
      (local-set-key "q" 'quit-window)
      (local-set-key "g" 'pytest-run-again))))

(defun pytest-run (cmdline show-prompt style)
  (let* ((full-cmdline (format "cd %s; %s"
                      (pytest-locate-dominating-file)
                      cmdline))
         (full-cmdline (if show-prompt
                      (read-shell-command "Run: " full-cmdline
                                          'pytest-run-history)
                    full-cmdline))
         (bufname (local-pytest-bufname)))
    (cond
     ((equal style 'ansi)
      (let ((buffer (get-buffer-create bufname)))
        (if (not (equal (current-buffer) buffer))
            (switch-to-buffer-other-window buffer))
        (if (get-buffer-process (current-buffer))
            (term-kill-subjob))
        (setq buffer-read-only nil)
        (erase-buffer)
        (insert full-cmdline)
        (newline)
        (term-ansi-make-term bufname "/bin/sh" nil "-c" full-cmdline)
        (term-char-mode)
        (let ((proc (get-buffer-process buffer)))
          ; override the default sentinel set by term-ansi-make-term
          (set-process-sentinel proc 'pytest-term-sentinel))))
     ((equal style 'compile)
      (compilation-start full-cmdline nil
                         (lambda (mode)
                           (if (boundp 'pytest-compile-source)
                               (progn
                                 (with-current-buffer pytest-compile-source
                                   (local-pytest-bufname)))
                             (local-pytest-bufname))))
      (let ((buf (current-buffer)))
        (with-current-buffer (local-pytest-bufname)
          (set (make-local-variable 'pytest-compile-source) buf)
          (local-set-key "g" 'pytest-recompile))))
     ((equal style 'pdb)
      (pdb (concat cmdline " --pdb"))))))

(defun pytest-recompile ()
  "Basically just advice `recompile' to use the original source

This is because recompile creates a new buffer, instead of using
the current one, meaning that buffer-local variables get reset on
every recompilation, meaning that it's hard to know where to go."
  (interactive)
  (let* ((source-buffer pytest-compile-source)
         (compile-buffer (with-current-buffer source-buffer
                    (local-pytest-bufname))))
    (recompile)
    (with-current-buffer compile-buffer
      (set (make-local-variable 'pytest-compile-source) source-buffer)
      (local-set-key "g" 'pytest-recompile))))

(defun pytest-arg-from-path (path)
  (let ((filename (file-name-nondirectory path)))
    (file-truename
     (if (or (string-match "test_.*\\.py$" filename)
             (string-match ".*_test\\.py$" filename))
         path
       (file-name-directory path)))))

(defun pytest-current-function-name ()
  (save-excursion
    (if (search-backward-regexp pytest-def-re)
        (match-string 1)
      nil)))

(defun pytest-all-command ()
  (format "%s %s "
          (get-pytest-bin)
          (file-truename (pytest-locate-dominating-file))))

(defun pytest-file-command ()
  "Get the command for the current file"
  (format "%s %s "
          (get-pytest-bin)
          (pytest-arg-from-path (buffer-file-name))))

(defun pytest-function-command ()
  (format "%s -k %s "
          (pytest-file-command)
          (pytest-current-function-name)))

(defun pytest-compile-all (show-prompt)
  (interactive "P")
  (pytest-run (pytest-all-command) show-prompt 'compile))

(defun pytest-compile-file (show-prompt)
  (interactive "P")
  (pytest-run (pytest-file-command) show-prompt 'compile))

(defun pytest-compile-function (show-prompt)
  (interactive "P")
  (pytest-run (pytest-function-command) show-prompt 'compile))

(defun pytest-run-file (show-prompt)
  "Run py.test on the current file or directory.

If the name of the current file matches test_*.py, run py.test on
it. Else, run py.test on the directory where the current file is in.
"
  (interactive "P")
  (pytest-run (pytest-file-command)) show-prompt 'ansi)

(defun pytest-run-function (show-prompt)
  "Run py.test on the current test.

If invokes py.test by adding \"-k funcname\", where funcname is the
name of the test_* function you are editing.
"
  (interactive "P")
  (pytest-run (pytest-function-command) show-prompt 'ansi))

(defun pytest-run-again (show-prompt)
  "Re-run the last py.test command.

If prefixed by C-u, it lets you to edit the command in the
minibuffer before executing it.
"
  (interactive "P")
  (if (not pytest-run-history)
      (message "No preceding pytest commands in history")
    (let ((cmdline (car pytest-run-history)))
      (pytest-run cmdline show-prompt 'ansi))))

(defun pytest-pdb-function (show-prompt)
  (interactive "P")
  (pytest-run (pytest-function-command) show-prompt 'pdb))

(defun pytest-pdb-file (show-prompt)
  (interactive "P")
  (pytest-run (pytest-file-command) show-prompt 'pdb))

(defun pytest-pdb-all (show-prompt)
  (interactive "P")
  (pytest-run (pytest-all-command) show-prompt 'pdb))


(provide 'pytest-compile)

;;; pytest.el ends here
