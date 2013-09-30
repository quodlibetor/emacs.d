(require 'package)
(package-initialize)

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

;; special modes
(load "customize/magit")
(load "customize/ibuffer")
(load "customize/dired")
(load "customize/outline")

;; general emacs config
(load "customize/package")
(load "customize/find-file")
(load "customize/ui")
(load "customize/ido")
(load "customize/keybindings")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("7b4a6cbd00303fc53c2d486dfdbe76543e1491118eba6adc349205dbf0f7063a" default))))
 '(dired-omit-files "^\\.?#\\|^\\.")
 '(exec-path (quote ("/home/bwm/.local/bin" "/home/bwm/bin" "/usr/lib/lightdm/lightdm" "/usr/local/sbin" "/usr/local/bin" "/usr/sbin" "/usr/bin" "/sbin" "/bin" "/usr/games" "/usr/local/games" "/home/bwm/.local/libexec/emacs/24.3/x86_64-unknown-linux-gnu")))
 '(safe-local-variable-values (quote ((gud-pdb-command-name "ipdb") (virtualenv-default-directory . "/home/bwm/projects/pacman/") (virtualenv-workon . "pacman") (virtualenv-default-directory . "/home/bwm/projects/adi.proftools/") (virtualenv-workon . "adi.proftools") (virtualenv-default-directory . "/home/bwm/projects/incinerator/") (virtualenv-workon . "incinerator") (org-default-notes-file . "/home/bwm/projects/adi.proftools/adi.proftools.org") (org-default-notes-file . "/home/bwm/projects/subman/subman.org") (virtualenv-default-directory . "/home/bwm/projects/ingestor/") (virtualenv-workon . "ingestor") (org-default-notes-file . "/home/bwm/projects/ingestor/ingestor.org") (virtualenv-default-directory . "/home/bwm/projects/subman") (virtualenv-workon . "subman"))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ediff-current-diff-B ((t (:background "#222" :foreground "DarkOrchid"))))
 '(ediff-fine-diff-B ((t (:background "#023D2C"))))
 '(font-lock-builtin-face ((t (:foreground "#ff83fa"))))
 '(helm-selection ((t (:background "ForestGreen" :foreground "SlateGray1" :underline t))) t)
 '(magit-diff-add ((t (:inherit diff-added :foreground "forest green"))))
 '(magit-diff-del ((t (:inherit diff-removed :foreground "IndianRed1"))))
 '(magit-item-highlight ((t (:inherit highlight :background "#232323" :foreground "light sea green"))))
 '(org-column ((t (:background "grey10" :strike-through nil :underline nil :slant normal :weight normal :height 105 :family "Ubuntu Mono"))))
 '(org-scheduled ((t (:background "#232323" :foreground "light goldenrod"))))
 '(rst-level-1-face ((t (:background "grey10"))) t)
 '(rst-level-2-face ((t (:background "grey13"))) t)
 '(rst-level-3-face ((t (:background "grey20"))) t)
 '(rst-level-4-face ((t (:background "grey25"))) t)
 '(rst-level-5-face ((t (:background "grey30"))) t))
