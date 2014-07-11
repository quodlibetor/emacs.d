; see customize/ui, because I make flymake activate everywhere, there and see
; $emacs/packages/flymake-python/flymake-customizations.el for a bunch of ways
; to customize it

; the pyflakes stuff is all from https://github.com/akaihola/flymake-python

(add-to-list 'auto-mode-alist
             '("pyflymakerc$" . python-mode))
(add-to-list 'auto-mode-alist
             '("\\.wsgi$" . python-mode))
(require 'python)
(setq python-fill-docstring-style 'pep-257-nn)

(add-hook 'python-mode-hook
          (lambda ()
            (require 'virtualenv)
            (require 'nose)
            (add-to-list 'nose-project-names ".emacsruntests")
            (add-to-list 'nose-project-names "runtests")
            (set (make-local-variable 'nose-use-verbose) nil)
            (local-set-key (kbd "C-c n a") 'nosetests-all)
            (local-set-key (kbd "C-c n m") 'nosetests-module)
            (local-set-key (kbd "C-c n o") 'nosetests-one)
            (local-set-key (kbd "C-c n e") 'nosetests-with-extra-args)
            (local-set-key (kbd "C-c n f") 'nosetests-failed)
            (local-set-key (kbd "C-c n p a") 'nosetests-pdb-all)
            (local-set-key (kbd "C-c n p m") 'nosetests-pdb-module)
            (local-set-key (kbd "C-c n p o") 'nosetests-pdb-one)
            (local-set-key (kbd "C-c h") 'pylookup-lookup)
            (if (boundp 'org-src-mode)
                (local-set-key (kbd "C-c C-'") 'org-edit-src-exit)))
            )

(setq jedi:setup-keys t)
(setq jedi:complete-on-dot t)
;;; many of these bwm:-defuns would probably be done better using a real
;;; projects framework
(defun bwm:get-local-python-version (virtualenv-dir)
  (with-temp-buffer
    (call-process (concat virtualenv-dir "/bin/python")
                  nil (current-buffer) nil
                  "-c" "import sys; sys.stdout.write(sys.version[:3])")
    (buffer-substring (point-min) (point-max))))

(defun bwm:locate-python-dominating-file ()
  (let ((fname (expand-file-name (file-name-directory (buffer-file-name)))))
    (locate-dominating-file
     fname
     (lambda (dirname)
       (directory-files dirname nil "^\\(setup.\\(py\\|cfg\\)\\|.git\\|.hg\\)\\'")))))

(defun bwm:setup-jedi-with-virtualenv ()
  (when (and (equal major-mode 'python-mode)
             ; some (e.g. diff) buffers are put in python-mode
             (buffer-file-name))
    (message "setting up jedi; mode: %s bufname: %s" major-mode (buffer-file-name))
    (if (and (boundp 'virtualenv-workon)
             virtualenv-workon)
        (let* ((virtualenv-dir (concat (expand-file-name "~/.virtualenvs/") virtualenv-workon))
               (python-version (bwm:get-local-python-version virtualenv-dir))
               (args (list "--virtual-env" virtualenv-dir
                           "--sys-path" (concat virtualenv-dir "/lib/python" python-version "/site-packages")
                           "--sys-path" virtualenv-default-directory)))
          (set (make-local-variable 'jedi:server-args) args))
      (let ((project-root (bwm:locate-python-dominating-file)))
        ;; if we're not in a virtualenv just set the sys path to include the
        ;; project base
        (if project-root
            (progn
              (message "%s" "bwm:jedi: not using full virtualenv settings")
              (set (make-local-variable 'jedi:server-args)
                   (list "--sys-path" project-root)))
          (message "%s" "bwm:jedi: no sys path manipulation at all"))))
    (jedi:setup)))
(add-hook 'hack-local-variables-hook #'bwm:setup-jedi-with-virtualenv)

;; add pylookup to your loadpath, ex) "~/.lisp/addons/pylookup"
(setq pylookup-dir "~/.emacs.d/packages/pylookup")
(add-to-list 'load-path pylookup-dir)
;; load pylookup when compile time
(eval-when-compile (require 'pylookup))

;; set executable file and db file
(setq pylookup-program (concat pylookup-dir "/pylookup.py"))
(setq pylookup-db-file (concat pylookup-dir "/pylookup.db"))

;; to speedup, just load it on demand
(autoload 'pylookup-lookup "pylookup"
  "Lookup SEARCH-TERM in the Python HTML indexes." t)
(autoload 'pylookup-update "pylookup" 
  "Run pylookup-update and create the database at `pylookup-db-file'." t)


(require 'nose)
;; overwrite run-nose to include a runner that runs tests and tests/integration
(defun run-nose (&optional tests debug failed extra-args)
  "run nosetests"
  (let* ((nose (nose-find-test-runner))
         (where (nose-find-project-root))
         (args (concat (if debug " --pdb" "")
                       (if failed " --failed" "")
                       (if extra-args extra-args "")))
         (tnames (or tests "")))
    (if (not where)
        (error
         (format (concat "abort: nosemacs couldn't find a project root, "
                         "looked for any of %S") nose-project-root-files)))
    (funcall (if debug
                 'pdb
               '(lambda (command)
                  (compilation-start command
                                     nil
                                     (lambda (mode) (concat "*nosetests*")))))
             (format
              (concat "%s "
                      (if nose-use-verbose "-v " "")
                      "%s -w %s %s")
              nose args where tnames)))
  )

(defun nosetests-with-extra-args (extra-args &optional debug failed)
  "run tests in tests and tests/integration"
  (interactive "Mnose args: ")
  (run-nose nil nil nil extra-args))


;;pdb setup, note the python version
(setq pdb-path (if (boundp 'virtualenv-default-directory)
                   (if (file-exists-p (concat virtualenv-default-directory "ipdb.py"))
                       "ipdb"
                     "pdb"))
      gud-pdb-command-name pdb-path)
(defadvice pdb (before gud-query-cmdline activate)
  "Provide a better default command line when called interactively."
  (interactive
   (let* ((pdb-path (if (boundp 'virtualenv-default-directory)
                        (if (file-exists-p (concat virtualenv-default-directory "ipdb.py"))
                            "ipdb"
                          "pdb")))
          (gud-pdb-command-name pdb-path))
     (list (gud-query-cmdline pdb-path
                              (file-name-nondirectory buffer-file-name))))))
