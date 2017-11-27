;;; py-gnitset-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "py-gnitset" "py-gnitset.el" (0 0 0 0))
;;; Generated autoloads from py-gnitset.el

(autoload 'py-gnitset-recompile "py-gnitset" "\
Basically just advice `recompile' to use the original source.

This is because recompile creates a new buffer, instead of using
the current one, meaning that buffer-local variables get reset on
every recompilation, meaning that it's hard to know where to go.

\(fn)" t nil)

(autoload 'py-gnitset-compile-all "py-gnitset" "\
Execute all the tests in a `compilation-mode' buffer.

Makes jumping to failures and original files very easy.

SHOW-PROMPT, when t, means to show the command for editing in the
minibuffer before it is executed.

\(fn SHOW-PROMPT)" t nil)

(autoload 'py-gnitset-compile-module "py-gnitset" "\
Execute this module's tests in a compilation buffer.

See `py-gnitset-compile-all' for details about usage and
SHOW-PROMPT

\(fn SHOW-PROMPT)" t nil)

(autoload 'py-gnitset-compile-class "py-gnitset" "\
Execute the enclosing class's tests in a compilation buffer.

See `py-gnitset-compile-all' for details about usage and
SHOW-PROMPT

\(fn SHOW-PROMPT)" t nil)

(autoload 'py-gnitset-compile-one "py-gnitset" "\
Run this function as a test in a compilation buffer.

See `py-gnitset-compile-all' for details about usage and
SHOW-PROMPT

\(fn SHOW-PROMPT)" t nil)

(autoload 'py-gnitset-term-all "py-gnitset" "\
Run py.test on the current test.

'Run' in this context means 'execute in an ANSI term.  This should
work better with things like `import ipdb; ipdb.set_trace()', if
you just to use the --pdb flag use `py-gnitset-pdb-all' and related
functions.

SHOW-PROMPT, when t, means to show the command for editing in the
minibuffer before it is executed.

\(fn SHOW-PROMPT)" t nil)

(autoload 'py-gnitset-term-module "py-gnitset" "\
Run py.test on the current file in an interactive test buffer.

See `py-gnitset-term-all' for details about usage and
SHOW-PROMPT

\(fn SHOW-PROMPT)" t nil)

(autoload 'py-gnitset-term-class "py-gnitset" "\
Run py.test on the current file in an interactive test buffer

See `py-gnitset-term-all' for details

\(fn SHOW-PROMPT)" t nil)

(autoload 'py-gnitset-term-one "py-gnitset" "\
Run py.test on the current test.

See `py-gnitset-term-all' for details about usage and
SHOW-PROMPT

\(fn SHOW-PROMPT)" t nil)

(autoload 'py-gnitset-term-again "py-gnitset" "\
Re-run the last py.test command.

If prefixed by C-u SHOW-PROMPT is true, and this function lets
you edit the command in the minibuffer before executing it.

\(fn SHOW-PROMPT)" t nil)

(autoload 'py-gnitset-pdb-all "py-gnitset" "\
Run all every test in a pdb buffer.

This will drop into pdb mode on error, and should give you all
the niceties associated with it (e.g. automatic buffer movement
when you step into new functions).

SHOW-PROMPT, set by C-u, means to show the command that will be
executed within the minibuffer for editing before running.

\(fn SHOW-PROMPT)" t nil)

(autoload 'py-gnitset-pdb-module "py-gnitset" "\
Run current module in a pdb buffer.

See `py-gnitset-pdb-all' for details about usage and
SHOW-PROMPT

\(fn SHOW-PROMPT)" t nil)

(autoload 'py-gnitset-pdb-class "py-gnitset" "\
Run current module in a pdb buffer.

See `py-gnitset-pdb-all' for details about usage and
SHOW-PROMPT

\(fn SHOW-PROMPT)" t nil)

(autoload 'py-gnitset-pdb-one "py-gnitset" "\
Run current function in a pdb buffer.

See `py-gnitset-pdb-all' for details about usage and
SHOW-PROMPT

\(fn SHOW-PROMPT)" t nil)

(autoload 'py-gnitset-mode "py-gnitset" "\
Add commands to run tests in Python buffers

The primary entry point is `py-gnitset-all', but see also
`py-gnitset-term-all' which runs tests in a an ansi-term buffer,
`py-gnitset-pdb-all' which runs tests in a pdb buffer. Additionally
there are 'py-gnitset-*-module', -class, and -function commands.

\\{py-gnitset-mode-map}

\(fn &optional ARG)" t nil)

(defvar py-gnitset-compilation-mode-map (let ((map (make-sparse-keymap))) (define-key map (kbd "g") 'py-gnitset-recompile) (define-key map (kbd "q") 'quit-window) map))

(autoload 'turn-on-py-gnitset-mode "py-gnitset" "\
Turn on py-gnitset-mode iff this is a `python-mode' buffer.

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "py-gnitset" '("py-gnitset-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; py-gnitset-autoloads.el ends here
