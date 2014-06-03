(require 'package)
(package-initialize)
(setq package-enable-at-startup nil)

(add-to-list 'load-path (expand-file-name "~/.emacs.d"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/packages"))
(add-to-list 'exec-path (expand-file-name "~/.local/bin"))
(setenv "PATH" (concat (expand-file-name "~/.local/bin:") (getenv "PATH")))

(load "customize/defuns")

;; language/file modes
(load "customize/elisp")
(load "customize/org")
(load "customize/python")
(load "customize/markdown")
(load "customize/confluence")
(load "customize/text")
(load "customize/yaml")
(load "customize/html")
(load "customize/vc-annotate")
(load "customize/puppet")
(load "customize/occur")

;; special modes
(load "customize/magit")
(load "customize/ibuffer")
(load "customize/dired")
(load "customize/outline")
(load "customize/helm")
(load "customize/ido")
(load "customize/mu4e")
(load "customize/notmuch")

;; general emacs config
(load "customize/package")
(load "customize/find-file")
(load "customize/ui")
(load "customize/keybindings")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "7b4a6cbd00303fc53c2d486dfdbe76543e1491118eba6adc349205dbf0f7063a" default)))
 '(dired-dwim-target t)
 '(dired-omit-files "^\\.?#\\|^\\.")
 '(exec-path (quote ("/home/bwm/.local/bin" "/home/bwm/bin" "/usr/lib/lightdm/lightdm" "/usr/local/sbin" "/usr/local/bin" "/usr/sbin" "/usr/bin" "/sbin" "/bin" "/usr/games" "/usr/local/games" "/home/bwm/.local/libexec/emacs/24.3/x86_64-unknown-linux-gnu")))
 '(max-specpdl-size 13400)
 '(notmuch-saved-searches (quote (("inbox" . "tag:inbox") ("unread" . "tag:unread") ("sent" . "from:bmaister"))))
 '(org-agenda-files (quote ("~/projects/tdd/tdd.org" "~/projects/subman/subman.org" "~/projects/sphinx-server/sphinx.org" "~/projects/requests-ragu/requests.org" "~/projects/ragu.utils/ragu.utils.org" "~/projects/ragu.register/register.org" "~/projects/ragu.ddb/ragu.ddb.org" "~/projects/models/models.org" "~/projects/ingestor/ingestor.org" "~/projects/ingestor/release-outline.org" "~/projects/incinerator/incinerator.org" "~/projects/feed_register/register.org" "~/projects/djeneric/djeneric.org" "~/projects/auth/auth.org")))
 '(safe-local-variable-values (quote ((virtualenv-default-directory . "/home/bwm/projects/ragu.register/") (virtualenv-workon . "ragu.register") (encoding . utf-8) (gud-pdb-command-name "ipdb") (virtualenv-default-directory . "/home/bwm/projects/pacman/") (virtualenv-workon . "pacman") (virtualenv-default-directory . "/home/bwm/projects/adi.proftools/") (virtualenv-workon . "adi.proftools") (virtualenv-default-directory . "/home/bwm/projects/incinerator/") (virtualenv-workon . "incinerator") (org-default-notes-file . "/home/bwm/projects/adi.proftools/adi.proftools.org") (org-default-notes-file . "/home/bwm/projects/subman/subman.org") (virtualenv-default-directory . "/home/bwm/projects/ingestor/") (virtualenv-workon . "ingestor") (org-default-notes-file . "/home/bwm/projects/ingestor/ingestor.org") (virtualenv-default-directory . "/home/bwm/projects/subman") (virtualenv-workon . "subman")))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ediff-current-diff-B ((t (:background "color-233" :foreground "DarkOrchid"))))
 '(ediff-fine-diff-B ((t (:background "#023D2C"))))
 '(font-lock-builtin-face ((t (:foreground "#ff83fa"))))
 '(helm-selection ((t (:background "ForestGreen" :foreground "SlateGray1" :underline t))))
 '(magit-diff-add ((t (:inherit diff-added))))
 '(org-column ((t (:background "grey10" :strike-through nil :underline nil :slant normal :weight normal :height 105 :family "Ubuntu Mono"))))
 '(org-scheduled ((t (:background "#232323" :foreground "light goldenrod"))))
 '(rst-level-1-face ((t (:background "grey10"))) t)
 '(rst-level-2-face ((t (:background "grey13"))) t)
 '(rst-level-3-face ((t (:background "grey20"))) t)
 '(rst-level-4-face ((t (:background "grey25"))) t)
 '(rst-level-5-face ((t (:background "grey30"))) t))
