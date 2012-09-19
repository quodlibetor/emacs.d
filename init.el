(require 'package)
(package-initialize)

(add-to-list 'load-path "/home/bwm/.emacs.d")
(add-to-list 'load-path "/home/bwm/.emacs.d/packages")

(load "customize/defuns")

;; language/file modes
(load "customize/elisp")
(load "customize/org")
(load "customize/python")
(load "customize/markdown")
(load "customize/confluence")
(load "customize/text")
(load "customize/yaml")

;; special modes
(load "customize/magit")
(load "customize/ibuffer")
(load "customize/dired")

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

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ediff-current-diff-B ((t (:background "#222" :foreground "DarkOrchid"))))
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
