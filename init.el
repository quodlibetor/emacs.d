;;; bwm-init -- An init file for bwm
;;;
;;; Commentary:
;;;
;;; This .emacs.d is set up as a bunch of mode-specific customization files.
;;;
;;; There are some kinds of customization that don't really fit into
;;; language-specific customization, they are in the special modes section
;;; below.

(setq custom-safe-themes '("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "7b4a6cbd00303fc53c2d486dfdbe76543e1491118eba6adc349205dbf0f7063a" default))

(add-to-list 'load-path (expand-file-name "~/.emacs.d/site-lisp"))
(load "customize/package")

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))


(dolist
    (package
     '(avy
       bind-key
       blacken
       browse-at-remote                 ; open current file in github/bb
       cider
       clojure-mode
       company-go
       company-terraform
       crontab-mode
       deadgrep
       diminish
       dockerfile-mode
       edit-server
       elpy
       f
       flycheck-mypy
       flycheck-rust
       flymake-shellcheck
       forge
       git-modes
       go-mode
       helm-dash
       helm-flycheck
       helm-git-grep
       helm-lsp
       helm-projectile
       helm-rg
       helm-swoop
       highlight
       highlight-escape-sequences
       htmlize
       httpcode
       json-mode
       literate-calc-mode
       lsp-ui
       magit
       markdown-mode
       multiple-cursors
       paredit
       plantuml-mode
       polymode
       powerline
       projectile
       protobuf-mode
       rainbow-delimiters
       rainbow-mode
       rust-mode
       rustic
       selectrum
       selectrum-prescient
       smart-mode-line
       spaceline
       string-inflection
       toml-mode
       tree-sitter
       tree-sitter-langs
       use-package
       virtualenvwrapper
       visual-fill-column
       vterm
       web-mode
       yaml-mode
       yasnippet
       ))
  (straight-use-package package))

;; (straight-use-package
;;  '(mz-testdrive :type git :depth 1 :host github :repo "MaterializeInc/materialize"
;;                 :files ("misc/editor/emacs/mz-testdrive.el")))
;; (mz-testdrive-enable)
;; (add-hook 'mz-testdrive-mode-hook
;;     (lambda ()
;;         (flymake-mode 0)))


(require 'bind-key) ; one of my packages depends on use-package, so use-package should happen first?

;; things that didn't install or seem unnecessary
;; helm-fd org-plus-contrib jedi py-gnitset
;; color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized
;; gitconfig-mode git-rebase-mode git-commit-mode
;; does this even exist flymake-mypy

(add-to-list 'exec-path (expand-file-name "~/.local/bin"))
(setenv "PATH" (concat (expand-file-name "~/.local/bin:") (getenv "PATH")))
(add-to-list 'exec-path (expand-file-name "~/.cargo/bin"))
(setenv "PATH" (concat (expand-file-name "~/.cargo/bin:") (getenv "PATH")))
(setq load-prefer-newer t)

(eval-when-compile
  (require 'use-package))
(require 'use-package)

(load "customize/defuns")

;; language/file modes
(load "customize/ansible")
(load "customize/csv")
(load "customize/cue")
(load "customize/dotenv")
(load "customize/elisp")
(load "customize/earthly")
(load "customize/nginx")
(load "customize/compilation")
;(load "customize/html")
(load "customize/javascript")
(load "customize/json")
(load "customize/go")
(load "customize/markdown")
;(load "customize/ocaml")
(load "customize/occur")
(load "customize/org")
(load "customize/plantuml")  ; depends on vars from org
;(load "customize/puppet")
(load "customize/python")
(load "customize/tramp")
;(load "customize/ruby")
(load "customize/rust")
(load "customize/clojure")
(load "customize/shell-script")
(load "customize/terraform")
(load "customize/vc-annotate")
(load "customize/yaml")
;(load "customize/web")

;; special modes
(load "customize/completions")
(load "customize/dired")
(load "customize/helm")
(load "customize/ibuffer")
(load "customize/projectile")
(load "customize/magit")
;(load "customize/outline")
(load "customize/company")
;; (when (file-exists-p (expand-file-name "~/mail"))
;;   (load "customize/mu4e")
;;   (load "customize/notmuch"))

;; general emacs config
(load "customize/keybindings")
(load "customize/ui")
(load "customize/lsp")
(when (string-equal system-type "darwin")
  (load "customize/osx"))
(load "customize/prog")

(use-package vterm
  :hook
  (vterm-mode . dont-show-trailing-whitespace)
  :custom
  ; (vterm-clear-scrollback t "when true, don't clear scrollback?!")
  (vterm-shell "zsh")
  (term-prompt-regex "❯")
  (vterm-kill-buffer-on-exit t)
  (vterm-max-scrollback 100000)
  )

(prefer-coding-system 'utf-8)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#c5c8c6" "#cc6666" "#b5bd68" "#f0c674" "#81a2be" "#b294bb" "#8abeb7" "#373b41"))
 '(compilation-scroll-output 'first-error)
 '(custom-safe-themes
   '("a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa"))
 '(dired-dwim-target t)
 '(fci-rule-color "#373b41")
 '(flycheck-yamllintrc ".yamllintrc.yml")
 '(helm-grep-ag-command "rg --smart-case --no-heading --line-number %s %s %s")
 '(lsp-go-env '((GOOS . "linux")))
 '(lsp-headerline-breadcrumb-segments '(project path-up-to-project file symbols))
 '(lsp-rust-analyzer-import-granularity "module")
 '(magit-diff-refine-hunk 'all)
 '(magit-log-arguments '("--graph" "--color" "--decorate" "-n256"))
 '(magit-pull-arguments '"--rebase")
 '(magit-tag-arguments '("--annotate"))
 '(markdown-command "cmark")
 '(mini-frame-ignore-commands
   '(eval-expression "edebug-eval-expression" debugger-eval-expression "helm" "bwm:arbitrary-search" projectile-switch-project))
 '(mini-frame-mode nil)
 '(mini-frame-show-parameters '((top . 30) (width . 0.7) (left . 0.5)))
 '(org-agenda-files nil)
 '(paradox-automatically-star nil)
 '(rustic-ansi-faces
   ["black" "OrangeRed1" "green3" "yellow2" "DodgerBlue1" "magenta2" "cyan3" "white"])
 '(safe-local-variable-values
   '((eval setenv "HUSKY" "0")
     (lsp-rust-analyzer-import-merge-behaviour . "last")
     (rustic-lsp-server . "rust-analyzer")
     (lsp-rust-server . "rust-analyzer")
     (lsp-rust-target-dir . "/Users/bwm/github/materialize/target/rls")
     (rustic-format-on-save)
     (flymake-shellcheck-args
      ("-f" "gcc" "-x" "-P" "/Users/bwm/github/infra/"))
     (flymake-shellcheck-args
      ("-f" "gcc" "-P" "/Users/bwm/github/infra/" "--check-sourced"))
     (eval progn
           (put 'defendpoint 'clojure-doc-string-elt 3)
           (put 'defendpoint-async 'clojure-doc-string-elt 3)
           (put 'api/defendpoint 'clojure-doc-string-elt 3)
           (put 'api/defendpoint-async 'clojure-doc-string-elt 3)
           (put 'defsetting 'clojure-doc-string-elt 2)
           (put 'setting/defsetting 'clojure-doc-string-elt 2)
           (put 's/defn 'clojure-doc-string-elt 2)
           (put 'p\.types/defprotocol+ 'clojure-doc-string-elt 2)
           (define-clojure-indent
             (assert 1)
             (ex-info 1)
             (expect 0)
             (let-404 1)
             (match 1)
             (merge-with 1)
             (p\.types/defprotocol+
              '(1
                (:defn)))
             (p\.types/def-abstract-type
              '(1
                (:defn)))
             (p\.types/deftype+
              '(2 nil nil
                  (:defn)))
             (p\.types/defrecord+
              '(2 nil nil
                  (:defn)))))
     (rustic-workspace-dir)
     (rustic-workspace-dir . "/Users/bwm/github/rust-postgres")
     (rustic-format-trigger)
     (cljr-favor-prefix-notation . t)
     (eval progn
           (put 'defendpoint 'clojure-doc-string-elt 3)
           (put 'defendpoint-async 'clojure-doc-string-elt 3)
           (put 'api/defendpoint 'clojure-doc-string-elt 3)
           (put 'api/defendpoint-async 'clojure-doc-string-elt 3)
           (put 'defsetting 'clojure-doc-string-elt 2)
           (put 'setting/defsetting 'clojure-doc-string-elt 2)
           (put 's/defn 'clojure-doc-string-elt 2)
           (put 'p\.types/defprotocol+ 'clojure-doc-string-elt 2)
           (define-clojure-indent
             (assert 1)
             (ex-info 1)
             (expect 0)
             (let-404 1)
             (match 1)
             (merge-with 1)
             (with-redefs-fn 1)
             (p\.types/defprotocol+
              '(1
                (:defn)))
             (p\.types/def-abstract-type
              '(1
                (:defn)))
             (p\.types/deftype+
              '(2 nil nil
                  (:defn)))
             (p\.types/defrecord+
              '(2 nil nil
                  (:defn)))))
     (flycheck-checker . python-flake8-chain)
     (venv-name . "consumer")
     (venv-current-dir . "/Users/bwm/.virtualenvs/consumer")
     (flycheck-python-mypy-args "--strict-optional" "--ignore-missing-imports" "--fast-parser")
     (flycheck-python-mypy-args "--disallow-untyped-defs" "--strict-optional" "--ignore-missing-imports" "--fast-parser")
     (virtualenv-default-directory . "/Users/bwm/.virtualenvs/consumer")
     (virtualenv-workon . "consumer")
     (project-venv-name . "ansible")
     (encoding . utf-8)
     (virtualenv-default-directory . "/Users/bwm/.virtualenvs/metahack")
     (virtualenv-workon . "metahack")
     (eval when
           (and
            (buffer-file-name)
            (file-regular-p
             (buffer-file-name))
            (string-match-p "^[^.]"
                            (buffer-file-name)))
           (emacs-lisp-mode)
           (when
               (fboundp 'flycheck-mode)
             (flycheck-mode -1))
           (unless
               (featurep 'package-build)
             (let
                 ((load-path
                   (cons ".." load-path)))
               (require 'package-build)))
           (package-build-minor-mode))
     (pytest-compile-runner-format . nose)
     (pytest-compile-runner-format quote nose)
     (pytest-compile-test-runner . "nosetests")
     (pytest-compile-runner-format . "nose")))
 '(term-buffer-maximum-size 50000)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   '((20 . "#cc6666")
     (40 . "#de935f")
     (60 . "#f0c674")
     (80 . "#b5bd68")
     (100 . "#8abeb7")
     (120 . "#81a2be")
     (140 . "#b294bb")
     (160 . "#cc6666")
     (180 . "#de935f")
     (200 . "#f0c674")
     (220 . "#b5bd68")
     (240 . "#8abeb7")
     (260 . "#81a2be")
     (280 . "#b294bb")
     (300 . "#cc6666")
     (320 . "#de935f")
     (340 . "#f0c674")
     (360 . "#b5bd68")))
 '(vc-annotate-very-old-color nil)
 '(warning-suppress-types '((comp))))
 '(dired-dwim-target t)
 '(dired-omit-files "^\\.?#\\|^\\.")

 '(max-specpdl-size 13400)
 '(notmuch-saved-searches (quote (("inbox" . "tag:inbox") ("unread" . "tag:unread") ("sent" . "from:bmaister"))))
 '(safe-local-variable-values (quote ((virtualenv-default-directory . "/home/bwm/projects/ragu.register/") (virtualenv-workon . "ragu.register") (encoding . utf-8) (gud-pdb-command-name "ipdb") (virtualenv-default-directory . "/home/bwm/projects/pacman/") (virtualenv-workon . "pacman") (virtualenv-default-directory . "/home/bwm/projects/adi.proftools/") (virtualenv-workon . "adi.proftools") (virtualenv-default-directory . "/home/bwm/projects/incinerator/") (virtualenv-workon . "incinerator") (org-default-notes-file . "/home/bwm/projects/adi.proftools/adi.proftools.org") (org-default-notes-file . "/home/bwm/projects/subman/subman.org") (virtualenv-default-directory . "/home/bwm/projects/ingestor/") (virtualenv-workon . "ingestor") (org-default-notes-file . "/home/bwm/projects/ingestor/ingestor.org") (virtualenv-default-directory . "/home/bwm/projects/subman") (virtualenv-workon . "subman"))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(let ((local (expand-file-name "~/.emacs.d/local.el")))
  (when (file-exists-p local)
    (load-file local)))
