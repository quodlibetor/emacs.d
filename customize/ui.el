(server-start)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(show-paren-mode 1)
(column-number-mode 1)
(electric-pair-mode)
(put 'dired-find-alternate-file 'disabled nil)
(put 'set-goal-column 'disabled nil)
(setq-default indent-tabs-mode nil)
(setq set-mark-command-repeat-pop t
      confirm-nonexistent-file-or-buffer nil
      dired-dwim-target t)

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward
      uniquify-strip-common-suffix t)

(require 'yasnippet)
(yas-global-mode)

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
(load-theme 'deeper-blue)

(add-hook 'find-file-hook 'flymake-find-file-hook)

(defadvice split-window-right (after split-and-rebalance-windows ())
  "I prefer windows to auto-balance when I open new ones"
  (balance-windows))
(ad-activate 'split-window-right)

(add-to-list 'auto-mode-alist
             '("bashrc" . shell-script-mode))
(add-to-list 'auto-mode-alist
             '("\\.zsh" . shell-script-mode))
(add-to-list 'auto-mode-alist
             '("README\\(.rst\\)?" . rst-mode))
(add-to-list 'auto-mode-alist
             '("gitconfig\\'" . gitconfig-mode))

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(setq web-mode-engines-alist '(("django" . "\\.html\\'")))
(add-hook 'web-mode-hook
          (lambda ()
            (set (make-local-variable 'electric-pair-mode) nil)))

(which-func-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Reduce modeline polution
;; minor modes
(when (require 'diminish nil 'noerror)
  (eval-after-load "yasnippet"
    '(diminish 'yas-minor-mode " Y"))
  (eval-after-load "auto-complete"
    '(diminish 'auto-complete-mode ""))
  ;; Diminishing flymake's thing doesn't play well with its error count
  ;; (eval-after-load "flymake"
  ;;   '(diminish 'flymake-mode " Fly"))
  )
;; major modes
(add-hook 'python-mode-hook
          (lambda ()
            (setq mode-name "Py")))
