(server-start)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(show-paren-mode 1)
(column-number-mode 1)
(electric-pair-mode)
(put 'dired-find-alternate-file 'disabled nil)

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward
      uniquify-strip-common-suffix t)


(setq-default show-trailing-whitespace t
	      default-indicate-empty-lines t
	      sentence-end-double-space nil
	      fill-column 79)
(setq backup-by-copying t      ; don't clobber symlink
      backup-directory-alist   ; don't litter my fs tree
          `(("." . ,(expand-file-name "~/.emacs.d/tmp/saves")))
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)       ; use versioned backups

;; set the font to dejavu then ubuntu because it doesn't like setting ubuntu's
;; font with a size
(set-frame-font "DejaVu Sans Mono-10.9")
(set-frame-font "Ubuntu Mono")
(load-theme 'tango-dark)

(add-hook 'find-file-hook 'flymake-find-file-hook)
