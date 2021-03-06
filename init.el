;;; bwm-init -- An init file for bwm
;;;
;;; Commentary:
;;;
;;; This .emacs.d is set up as a bunch of mode-specific customization files.
;;;
;;; There are some kinds of customization that don't really fit into
;;; language-specific customization, they are in the special modes section
;;; below.

;; This seems to undefined in emacs 24.4... somehow. Dumb.
(defsubst package-desc-vers (desc)
  "Extract version from a package description vector."
  (aref desc 0))
(setq custom-safe-themes '("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "7b4a6cbd00303fc53c2d486dfdbe76543e1491118eba6adc349205dbf0f7063a" default))

(add-to-list 'load-path (expand-file-name "~/.emacs.d/site-lisp"))
(load "customize/package")
(package-initialize)

(add-to-list 'exec-path (expand-file-name "~/.local/bin"))
(setenv "PATH" (concat (expand-file-name "~/.local/bin:") (getenv "PATH")))
(add-to-list 'exec-path (expand-file-name "~/.cargo/bin"))
(setenv "PATH" (concat (expand-file-name "~/.cargo/bin:") (getenv "PATH")))
(setq load-prefer-newer t)

(load "customize/defuns")

;; language/file modes
;(load "customize/confluence")
(load "customize/csv")
(load "customize/elisp")
;(load "customize/html")
;(load "customize/javascript")
(load "customize/json")
;(load "customize/go")
(load "customize/markdown")
;(load "customize/ocaml")
(load "customize/occur")
(load "customize/org")
(load "customize/plantuml")  ; depends on vars from org
;(load "customize/puppet")
(load "customize/python")
;(load "customize/ruby")
(load "customize/rust")
(load "customize/shell-script")
(load "customize/vc-annotate")
(load "customize/yaml")
(load "customize/prog")
;(load "customize/web")

;; special modes
(load "customize/dired")
(load "customize/helm")
(load "customize/ibuffer")
(load "customize/ido")
(load "customize/projectile")
(load "customize/magit")
;(load "customize/outline")
(load "customize/company")
;; (when (file-exists-p (expand-file-name "~/mail"))
;;   (load "customize/mu4e")
;;   (load "customize/notmuch"))

;; general emacs config
(load "customize/find-file")
(load "customize/keybindings")
(load "customize/ui")
(when (string-equal system-type "darwin")
  (load "customize/osx"))

(prefer-coding-system 'utf-8)

;(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
;(require 'el-get)
;(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
;(el-get 'sync)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#c5c8c6" "#cc6666" "#b5bd68" "#f0c674" "#81a2be" "#b294bb" "#8abeb7" "#373b41"))
 '(custom-safe-themes
   (quote
    ("a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa")))
 '(dired-dwim-target t)
 '(fci-rule-color "#373b41")
 '(flycheck-yamllintrc ".yamllintrc.yml")
 '(helm-grep-ag-command "rg --smart-case --no-heading --line-number %s %s %s")
 '(magit-log-arguments (quote ("--graph" "--color" "--decorate" "-n256")))
 '(magit-pull-arguments (quote "--rebase"))
 '(magit-tag-arguments (quote ("--annotate")))
 '(markdown-command "cmark")
 '(org-agenda-files (quote ("~/org/work.org")))
 '(package-selected-packages
   (quote
    (helm-rg edit-server flymake-shellcheck projectile avy forge py-isort company-go powerline rainbow-mode plantuml-mode smart-mode-line visual-fill-column elpy polymode helm-flycheck scratch expand-region multiple-cursors virtualenvwrapper ansible-doc zencoding-mode yasnippet yaml-mode xml-rpc web-mode toml-mode rust-mode rainbow-delimiters py-gnitset puppet-mode paredit paradox org-plus-contrib markdown-mode lua-mode json-mode jedi ibuffer-tramp httpcode htmlize highlight-escape-sequences highlight helm-swoop helm-git-grep go-mode gitconfig-mode git-rebase-mode git-commit-mode flycheck-rust f dockerfile-mode diminish crontab-mode color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized)))
 '(paradox-automatically-star nil)
 '(safe-local-variable-values
   (quote
    ((flycheck-checker . python-flake8-chain)
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
               (fboundp
                (quote flycheck-mode))
             (flycheck-mode -1))
           (unless
               (featurep
                (quote package-build))
             (let
                 ((load-path
                   (cons ".." load-path)))
               (require
                (quote package-build))))
           (package-build-minor-mode))
     (pytest-compile-runner-format . nose)
     (pytest-compile-runner-format quote nose)
     (virtualenv-default-directory . "/home/bwm/projects/schedaddle/")
     (virtualenv-workon . "schedaddle3")
     (pytest-compile-test-runner . "nosetests")
     (pytest-compile-runner-format . "nose"))))
 '(term-buffer-maximum-size 50000)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#cc6666")
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
     (360 . "#b5bd68"))))
 '(vc-annotate-very-old-color nil))
 '(dired-dwim-target t)
 '(dired-omit-files "^\\.?#\\|^\\.")

 '(max-specpdl-size 13400)
 '(notmuch-saved-searches (quote (("inbox" . "tag:inbox") ("unread" . "tag:unread") ("sent" . "from:bmaister"))))
 '(org-agenda-files (quote ("~/projects/tdd/tdd.org" "~/projects/subman/subman.org" "~/projects/sphinx-server/sphinx.org" "~/projects/requests-ragu/requests.org" "~/projects/ragu.utils/ragu.utils.org" "~/projects/ragu.register/register.org" "~/projects/ragu.ddb/ragu.ddb.org" "~/projects/models/models.org" "~/projects/ingestor/ingestor.org" "~/projects/ingestor/release-outline.org" "~/projects/incinerator/incinerator.org" "~/projects/feed_register/register.org" "~/projects/djeneric/djeneric.org" "~/projects/auth/auth.org")))
 '(safe-local-variable-values (quote ((virtualenv-default-directory . "/home/bwm/projects/ragu.register/") (virtualenv-workon . "ragu.register") (encoding . utf-8) (gud-pdb-command-name "ipdb") (virtualenv-default-directory . "/home/bwm/projects/pacman/") (virtualenv-workon . "pacman") (virtualenv-default-directory . "/home/bwm/projects/adi.proftools/") (virtualenv-workon . "adi.proftools") (virtualenv-default-directory . "/home/bwm/projects/incinerator/") (virtualenv-workon . "incinerator") (org-default-notes-file . "/home/bwm/projects/adi.proftools/adi.proftools.org") (org-default-notes-file . "/home/bwm/projects/subman/subman.org") (virtualenv-default-directory . "/home/bwm/projects/ingestor/") (virtualenv-workon . "ingestor") (org-default-notes-file . "/home/bwm/projects/ingestor/ingestor.org") (virtualenv-default-directory . "/home/bwm/projects/subman") (virtualenv-workon . "subman"))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cursor ((t (:background "dark cyan"))))
 '(ediff-current-diff-B ((t (:background "#222" :foreground "DarkOrchid"))))
 '(ediff-fine-diff-B ((t (:background "#01008c"))))
 '(font-lock-builtin-face ((t (:foreground "#ff83fa"))))
 '(helm-selection ((t (:background "ForestGreen" :foreground "SlateGray1" :underline t))))
 '(highlight ((t (:background "OrangeRed1" :foreground "black" :inverse-video nil))))
 '(hl-line ((t (:background "gray8"))))
 '(magit-item-highlight ((t (:inherit highlight :background "#0A2036" :foreground "deep sky blue"))))
 '(mc/region-face ((t (:inherit highlight))))
 '(org-column ((t (:background "grey10" :strike-through nil :underline nil :slant normal :weight normal :height 105 :family "Ubuntu Mono"))))
 '(org-scheduled ((t (:background "#232323" :foreground "light goldenrod"))))
 '(region ((t (:background "RoyalBlue4" :inverse-video nil))))
 '(rst-level-1-face ((t (:background "grey10"))) t)
 '(rst-level-2-face ((t (:background "grey13"))) t)
 '(rst-level-3-face ((t (:background "grey20"))) t)
 '(rst-level-4-face ((t (:background "grey25"))) t)
 '(rst-level-5-face ((t (:background "grey30"))) t))

(let ((local (expand-file-name "~/.emacs.d/local.el")))
  (when (file-exists-p local)
    (load-file local)))
