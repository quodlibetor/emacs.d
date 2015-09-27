; see customize/ui, because I make flymake activate everywhere, there and see
; $emacs/packages/flymake-python/flymake-customizations.el for a bunch of ways
; to customize it

(setq elpy-modules
      '(elpy-module-sane-defaults
        elpy-module-company
        elpy-module-eldoc
        elpy-module-flymake
        elpy-module-highlight-indentation
        elpy-module-pyvenv
        elpy-module-yasnippet))

(elpy-enable)
(add-to-list 'auto-mode-alist
             '("pyflymakerc$" . python-mode))
(add-to-list 'auto-mode-alist
             '("\\.wsgi$" . python-mode))
(require 'python)
(setq python-fill-docstring-style 'django) ;; knewton style

;(setq pylookup-dir "~/.emacs.d/packages/pylookup")
;(add-to-list 'load-path pylookup-dir)
;;; load pylookup when compile time
;(eval-when-compile (require 'pylookup))
;
;;; set executable file and db file
;(setq pylookup-program (concat pylookup-dir "/pylookup.py"))
;(setq pylookup-db-file (concat pylookup-dir "/pylookup.db"))
;
;;; to speedup, just load it on demand
;(autoload 'pylookup-lookup "pylookup"
;  "Lookup SEARCH-TERM in the Python HTML indexes." t)
;(autoload 'pylookup-update "pylookup" 
;  "Run pylookup-update and create the database at `pylookup-db-file'." t)
