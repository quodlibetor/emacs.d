;;; py-gnitset.el --- Run your Python tests any way you'd like
;;
;; version: 0.1
;; Copyright (C) 2014 Brandon W Maister
;; Author: Brandon W Maister <quodlibetor@gmail.com>
;; URL: https://www.github.com/quodlibetor/py-gnitset
;;
;;; Commentary:
;;
;; Description
;; -----------
;;
;; This mode adds some useful functionality for running Python unittest
;; programs from within Emacs.
;;
;; It allows you to run py.test, nose, or custom test runners within various
;; buffer types.
;;
;; - Compile buffer, via py-gnitset-*: the shortest to type, because it's
;;   generally the most useful.  These buffers have the fancy "click an error
;;   message to go to that line in the file" functionality you expect.

;; - PDB buffer, via py-gnitset-pdb-*: Runs the tests in a `pdb'-buffer, with
;;   the "--pdb" flag appended.  This is particularly useful if you "import pdb;
;;   pdb.set_trace()" within your tests, as the pdb buffer tracks stepping
;;   through code within the associated Emacs code buffer.

;; - Ansi-term buffer, via py-gnitset-term-*: this is a generic escape hatch
;;   for when things aren't working in another buffer type.  I mostly use it for
;;   debugging py-gnitset-mode at this point, although it is also useful if you
;;   prefer ipdb to pdb+emacs pdb mode.
;;
;; In addition to the various buffer types, you can select which funcions to
;; test via the py-gnitset-*-all, py-gnitset-*-module, py-gnitset-*-class, and
;; py-gnitset-*-one functions which all do the obvious things.
;;
;; Additionally, prefixing any command with C-u will allow you to edit it in
;; the minibuffer before creating the buffer that you'll interact with your
;; tests in.  This also gets you M-p/M-n command history navigation for free,
;; which is nice.
;;
;; My goal is to make testing Python in Emacs *obviously* the best way to do
;; it, so if you have ideas for how to improve things please open an issue the
;; github page or send me an email.
;;
;; Setting Up
;; ----------
;;
;; Adding `(py-gnitset-global-mode)' to your .emacs will attempt to turn on
;; py-gnitset-mode in every `python-mode' buffer.
;;
;; You can try py-gnitset without global installation by just calling "M-x
;; py-gnitset-mode" in any Python buffer.  `py-gnitset-mode' just adds
;; some keybindings to the C-c t map, so if you want to do something fancy you
;; could for example do:
;;
;;    (add-hook 'python-mode-hook
;;               (lambda ()
;;                  (local-set-key (kbd "C-c n") py-gnitset-map)))
;;
;; To bind the keys to the C-c n map instead, with no loss of functionality.
;;
;; Default Bindings
;; ----------------
;;
;; key             binding
;; ---             -------
;; C-c t a         py-gnitset-all
;; C-c t c         py-gnitset-class
;; C-c t m         py-gnitset-module
;; C-c t o         py-gnitset-one
;;
;; C-c t p a       py-gnitset-pdb-all
;; C-c t p c       py-gnitset-pdb-class
;; C-c t p m       py-gnitset-pdb-module
;; C-c t p o       py-gnitset-pdb-one
;;
;; C-c t r a       py-gnitset-term-all
;; C-c t r c       py-gnitset-term-class
;; C-c t r m       py-gnitset-term-module
;; C-c t r o       py-gnitset-term-one
;; C-c t r t       py-gnitset-term-again
;;
;; To Do
;; -----
;;
;; - macro-ize the py-gnitset-*-all/class/module/function duplication, so that it's
;;   just a matter of (def-py-gnitset-generic ...) instead of the current quadruple
;;   replication
;; - Add the ability to save custom command formulations (basically hack
;;   py-gnitset-run to look for the function to run based on an alist,
;;   rather than the static cond list)
;; - Add a history of test runs, instead of just clearing out test buffers.
;; - Add a way to run tests associated with the current *non-test* function
;;
;;; Code:

(require 'term)
(require 'compile)

(defgroup py-gnitset nil
  "Customization options for py-gnitset"
  :prefix 'py-gnitset)

(defcustom py-gnitset-project-root-files
  '("setup.py" "setup.cfg" ".git" ".hg")
  "Files that mark the root of a project for testing.

Used if `virtualenv-default-directory' is not bound."
  :group 'py-gnitset)

(defcustom py-gnitset-test-runner
  "py.test"
  "Test runner to use to run tests.

nil means to try to use py.test from `virtualenv-workon', or if
that's not set to use a global py.test command.

To set this for a project you should use dir-locals, for example, this .dir-locals.el:

    ((nil . ((virtualenv-workon . \"welltestded\")
	     (virtualenv-default-directory . \"/home/user/projects/welltested/\"))))

is equivalent to this one:

    ((nil . ((virtualenv-workon . \"welltestded\")
	     (virtualenv-default-directory . \"/home/user/projects/welltested/\")
             (py-gnitset-test-runner . \"/home/bwm/.virtualenvs/welltested/bin/py.test\"))))

Which is equivalent to the following:

    ((nil . ((virtualenv-workon . \"welltestded\")
	     (virtualenv-default-directory . \"/home/user/projects/welltested/\")
             (py-gnitset-test-runner . \"py.test\"))))

But if you wanted to use nose (which doesn't work for function or
class level things yet) you would probably do something like:

    ((nil . ((virtualenv-workon . \"welltestded\")
	     (virtualenv-default-directory . \"/home/user/projects/welltested/\")
             (py-gnitset-test-runner . \"nosetests\"))))

And if you have a runner script called in
\"/home/user/projects/welltested/runtests\" you could do:

    ((nil . ((py-gnitset-test-runner . \"runtests\"))))"
  :group 'py-gnitset)

(defcustom py-gnitset-runner-format
  'pytest
  "How to format args to `py-gnitset-test-runner'.

This value is used internally to figure out how to format
arguments to the test runner, and is only a separate thing
because you can define your own script as the test runner, and
then how do I know how to format the args?

Use it in directory-local variables like so:

    ((nil . ((py-gnitset-test-runner . \"runtests\")
             (py-gnitset-runner-format . 'nose))))

Valid choices are 'pytest and 'nose"
  :group 'py-gnitset
  :type '(symbol pytest nose)
  :options '(pytest nose))


(defvar py-gnitset-run-history nil)

(let ((anything "[A-Za-z0-9_]"))
  (defconst py-gnitset-def-re (format "def \\(test_%s+\\)" anything))
  (defconst py-gnitset-class-re (format "class \\(%s*[tT]est%s*\\)" anything anything)))

(defun py-gnitset-locate-dominating-file ()
  "Find the project root."
  (cond
   ((boundp 'virtualenv-default-directory)
    virtualenv-default-directory)
   (t
    (let ((py-gnitset-dom-re (mapconcat 'identity py-gnitset-project-root-files "\\|")))
      (locate-dominating-file
       (buffer-file-name)
       (lambda (dir)
         (when (file-directory-p dir)
           (directory-files dir nil py-gnitset-dom-re))))))))

(defun py-gnitset-virtualenv-bin-or-current-dir ()
  "Try to find the virtualenv for the local dir, else local dir."
  (if (boundp 'virtualenv-workon)
      (concat (expand-file-name virtualenv-root)
              "/" virtualenv-workon "/bin")
    "."))

(defun py-gnitset-get-bin ()
  "Try to figure out what file is meant by `py-gnitset-test-runner'.

Look in the current dir, all the ancestors, and the virtualenv."
  (if (file-exists-p py-gnitset-test-runner)
      py-gnitset-test-runner
    (let* ((runner-dir (locate-dominating-file (buffer-file-name)
                                               py-gnitset-test-runner))
           (runner (file-truename (concat runner-dir "/" py-gnitset-test-runner))))
      (if (file-exists-p runner)
          runner
        (concat (py-gnitset-virtualenv-bin-or-current-dir) "/" py-gnitset-test-runner)))))

(defun py-gnitset-local-bufname ()
  "Get the compilation py-gnitset buffer for the currently executing buffer.

Tries to get py-gnitset for the local virtualenv, falling back to global.

Doesn't work in compilation buffers because dir-local variables aren't set"
  (if (boundp 'virtualenv-workon)
      (format "*%s-py-gnitset*" virtualenv-workon)
    "*py-gnitset*"))

(defun py-gnitset-term-sentinel (proc msg)
  "Function to monitor the py-gnitset-term.

PROC is the process created by `py-gnitset-run' with the 'ansi style.
MSG is the message passed by `set-process-sentinel' within
py-gnitset-run."
  (term-sentinel proc msg)
  (when (memq (process-status proc) '(signal exit))
    (with-current-buffer (py-gnitset-local-bufname)
      (setq buffer-read-only t)
      (local-set-key "q" 'quit-window)
      (local-set-key "g" 'py-gnitset-term-again))))

(defun py-gnitset-run (cmdline show-prompt style)
  "The test dispatcher, given a command and a style execute it.

This is the underlying runner used by the py-gnitset-STYLE-SELECTOR
functions.

CMDLINE is the command line string generated by the command.
SHOW-PROMPT t or nil, describes whether to show the CMDLINE in
the minibuffer before executing.
STYLE should be one of 'compile,'ansi, or 'pdb, and descibes the
kind of buffer to run the process in, as well as some extra args
needed by that style."
  (let* ((default-directory (py-gnitset-locate-dominating-file))
         (process-environment (list (format "PWD=%s" default-directory)))
         (full-cmdline cmdline)
         (full-cmdline (if show-prompt
                      (read-shell-command "Run: " full-cmdline
                                          'py-gnitset-run-history)
                    full-cmdline))
         (bufname (py-gnitset-local-bufname)))
    (cond
     ((equal style 'ansi)
      (let ((buffer (get-buffer-create bufname)))
        (if (not (equal (current-buffer) buffer))
            (switch-to-buffer-other-window buffer))
        (if (get-buffer-process (current-buffer))
            (term-kill-subjob))
        (setq buffer-read-only nil)
        (set (make-local-variable 'show-trailing-whitespace) nil)
        (erase-buffer)
        (insert full-cmdline)
        (newline)
        (term-ansi-make-term bufname "/bin/sh" nil "-c" (concat  full-cmdline " -s"))
        (term-char-mode)
        (let ((proc (get-buffer-process buffer)))
          ; override the default sentinel set by term-ansi-make-term
          (set-process-sentinel proc 'py-gnitset-term-sentinel))))
     ((equal style 'compile)
      (compilation-start full-cmdline nil
                         (lambda (mode)
                           (if (boundp 'py-gnitset-source)
                               (with-current-buffer py-gnitset-source
                                 (py-gnitset-local-bufname))
                             (py-gnitset-local-bufname))))
      (let ((buf (current-buffer)))
        (with-current-buffer (py-gnitset-local-bufname)
          (set (make-local-variable 'py-gnitset-source) buf)
          (set (make-local-variable 'show-trailing-whitespace) nil)
          (font-lock-add-keywords nil
                                  '(("\\(^_* ERROR .*_$\\)" . 'compilation-error)
                                    ("\\(^E .*$\\)" . 'compilation-error)
                                    ("\\(FAILED\\)" . 'compilation-error)
                                    ("\\(PASSED\\)" . 'compilation-info)
                                    ("^\\([A-Za-z/_.]+\.py\\) .*F" 1 'compilation-error t)
                                    ("\\(^_* .*_$\\)" . 'compilation-info)))
          (local-set-key "g" 'py-gnitset-recompile))))
     ((equal style 'pdb)
      (pdb (concat cmdline " -s --pdb"))))))

(defun py-gnitset-recompile (show-prompt)
  "Basically just advice `recompile' to use the original source.

This is because recompile creates a new buffer, instead of using
the current one, meaning that buffer-local variables get reset on
every recompilation, meaning that it's hard to know where to go."
  (interactive "P")
  (let* ((source-buffer py-gnitset-source)
         (compile-buffer (with-current-buffer source-buffer
                    (py-gnitset-local-bufname))))
    (recompile show-prompt)
    (with-current-buffer compile-buffer
      (set (make-local-variable 'py-gnitset-source) source-buffer)
      (set (make-local-variable 'show-trailing-whitespace) nil)
      (font-lock-add-keywords nil
                              '(("\\(^_* ERROR .*_$\\)" . 'compilation-error)
                                ("\\(^E .*$\\)" . 'compilation-error)
                                ("\\(FAILED\\)" . 'compilation-error)
                                ("\\(PASSED\\)" . 'compilation-info)
                                ("^\\([A-Za-z/_.]+\.py\\) .*F" 1 'compilation-error t)
                                ("\\(^_* .*_$\\)" . 'compilation-info)))
      (local-set-key "g" 'py-gnitset-recompile))))

;;; Locator functions -- find the thing to test
(defun py-gnitset-arg-from-path (path)
  "Run either the current test file, or the current directory.

If the current file name ends or starts with \"test\" it will be
selected, otherwise we assume that you're in a directory
containing tests (e.g. editing conftest.py) and want all of them
to be run"
  (let ((filename (file-name-nondirectory path)))
    (file-truename
     (if (or (string-match "test_.*\\.py$" filename)
             (string-match ".*_test\\.py$" filename)
             (file-directory-p dir))
         path
       (file-name-directory path)))))

(defun py-gnitset-current-function-name ()
  (save-excursion
    (if (search-backward-regexp py-gnitset-def-re)
        (match-string 1)
      nil)))

(defun py-gnitset-current-class-name ()
  (save-excursion
    (when (search-backward-regexp py-gnitset-class-re)
      (match-string 1))))

(defun py-gnitset-all-command ()
  (format "%s %s "
          (py-gnitset-get-bin)
          (file-truename (py-gnitset-locate-dominating-file))))

(defun py-gnitset-module-command ()
  "Get the command for the current file."
  (format "%s %s "
          (py-gnitset-get-bin)
          (py-gnitset-arg-from-path (buffer-file-name))))

(defun py-gnitset-test-specifier ()
  "Get the correct def/class specifier for different runners.

    * py.test -> 'module -k filter'
    * nose    -> 'module:filter'

This is based on the `py-gnitset-runner-format'"
  (cond ((eq py-gnitset-runner-format
             'pytest)
         "%s -k %s")
        ((eq py-gnitset-runner-format
             'nose)
         "%s:%s")
        (t
         (error "No matching py-gnitset-runner format for format '%s"
                py-gnitset-runner-format))))

(defun py-gnitset-class-command ()
  "Get the command for the current file."
  (format (py-gnitset-test-specifier)
          (py-gnitset-module-command)
          (py-gnitset-current-class-name)))

(defun py-gnitset-function-command ()
  "Get the command for the current function."
  (format (py-gnitset-test-specifier)
          (py-gnitset-module-command)
          (py-gnitset-current-function-name)))

;;; temp
;; (defmacro compile-group (tag)
;;   (let (fun)
;;     (dolist (group ("function" "file" "all"))
;;       `(defun ,(intern (concat "py-gnitset-" tag "-" group) (show-prompt))
;;          (interactive "P")
;;          (py-gnitset-run ,(intern (concat "py-gnitset-" group "-command")) show-prompt ,(intern tag))))))

;;; Actual test functions

(defun py-gnitset-all (show-prompt)
  "Execute all the tests in a `compilation-mode' buffer.

Makes jumping to failures and original files very easy."
  (interactive "P")
  (py-gnitset-run (py-gnitset-all-command) show-prompt 'compile))

(defun py-gnitset-module (show-prompt)
  "Execute this module's tests in a compilation buffer.

See `py-gnitset-all' for details"
  (interactive "P")
  (py-gnitset-run (py-gnitset-module-command) show-prompt 'compile))

(defun py-gnitset-class (show-prompt)
  "Execute the enclosing class's tests in a compilation buffer.

See `py-gnitset-all' for details"
  (interactive "P")
  (py-gnitset-run (py-gnitset-class-command) show-prompt 'compile))

(defun py-gnitset-one (show-prompt)
  "Execute this function in a compilation buffer

See `py-gnitset-all' for details"
  (interactive "P")
  (py-gnitset-run (py-gnitset-function-command) show-prompt 'compile))

(defun py-gnitset-term-all (show-prompt)
  "Run py.test on the current test.

'Run' in this context means 'execute in an ANSI term. This should
work better with things like `import ipdb; ipdb.set_trace()', if
you just to use the --pdb flag use `py-gnitset-pdb-all' and related
functions."
  (interactive "P")
  (py-gnitset-run (py-gnitset-all-command) show-prompt 'ansi))

(defun py-gnitset-term-module (show-prompt)
  "Run py.test on the current file in an interactive test buffer

See `py-gnitset-term-all' for details"
  (interactive "P")
  (py-gnitset-run (py-gnitset-module-command) show-prompt 'ansi))

(defun py-gnitset-term-class (show-prompt)
  "Run py.test on the current file in an interactive test buffer

See `py-gnitset-term-all' for details"
  (interactive "P")
  (py-gnitset-run (py-gnitset-class-command) show-prompt 'ansi))

(defun py-gnitset-term-one (show-prompt)
  "Run py.test on the current test.

See `py-gnitset-term-all' for details"
  (interactive "P")
  (py-gnitset-run (py-gnitset-function-command) show-prompt 'ansi))

(defun py-gnitset-term-again (show-prompt)
  "Re-run the last py.test command.

If prefixed by C-u, it lets you to edit the command in the
minibuffer before executing it."
  (interactive "P")
  (if (not py-gnitset-run-history)
      (message "No preceding py-gnitset commands in history")
    (let ((cmdline (car py-gnitset-run-history)))
      (py-gnitset-run cmdline show-prompt 'ansi))))

(defun py-gnitset-pdb-all (show-prompt)
  "Run all tests in a pdb buffer

This will drop into pdb mode on error, and should give you all
the niceties associated with it (e.g. automatic buffer movement)"

  (interactive "P")
  (py-gnitset-run (py-gnitset-all-command) show-prompt 'pdb))

(defun py-gnitset-pdb-module (show-prompt)
  "Run current module in a pdb buffer

See `py-gnitset-pdb-all' for details"
  (interactive "P")
  (py-gnitset-run (py-gnitset-module-command) show-prompt 'pdb))

(defun py-gnitset-pdb-class (show-prompt)
  "Run current module in a pdb buffer

See `py-gnitset-pdb-all' for details"
  (interactive "P")
  (py-gnitset-run (py-gnitset-class-command) show-prompt 'pdb))

(defun py-gnitset-pdb-one (show-prompt)
  "Run current function in a pdb buffer

See `py-gnitset-pdb-all' for details"
  (interactive "P")
  (py-gnitset-run (py-gnitset-function-command) show-prompt 'pdb))

(defvar py-gnitset-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "o") 'py-gnitset-one)
    (define-key map (kbd "c") 'py-gnitset-class)
    (define-key map (kbd "m") 'py-gnitset-module)
    (define-key map (kbd "a") 'py-gnitset-all)
    (define-key map (kbd "r o") 'py-gnitset-term-one)
    (define-key map (kbd "r c") 'py-gnitset-term-class)
    (define-key map (kbd "r m") 'py-gnitset-term-module)
    (define-key map (kbd "r a") 'py-gnitset-term-all)
    (define-key map (kbd "r t") 'py-gnitset-term-again)
    (define-key map (kbd "p o") 'py-gnitset-pdb-one)
    (define-key map (kbd "p c") 'py-gnitset-pdb-class)
    (define-key map (kbd "p m") 'py-gnitset-pdb-module)
    (define-key map (kbd "p a") 'py-gnitset-pdb-all)
    map)
  "All the specific Python testing commands.")

(define-prefix-command 'py-gnitset-mode-map)
(define-key py-gnitset-mode-map (kbd "C-c t") py-gnitset-map)


(define-minor-mode py-gnitset-mode
  "Add commands to run tests in Python buffers

The primary entry point is `py-gnitset-all', but see also
`py-gnitset-term-all' which runs tests in a an ansi-term buffer,
`py-gnitset-pdb-all' which runs tests in a pdb buffer. Additionally
there are 'py-gnitset-*-module', -class, and -function commands.

\\{py-gnitset-mode-map}"
  :keymap py-gnitset-mode-map
  :group 'py-gnitset)

(defun turn-on-py-gnitset-mode ()
  "Turn on py-gnitset-mode iff this is a `python-mode' buffer."
  (when (eq major-mode 'python-mode)
    (py-gnitset-mode)))

(define-globalized-minor-mode py-gnitset-global-mode
  py-gnitset-mode
  turn-on-py-gnitset-mode
  :group 'py-gnitset)

(provide 'py-gnitset)

;;; py-gnitset.el ends here
