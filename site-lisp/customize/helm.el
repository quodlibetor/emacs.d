(require 'helm)
(require 'helm-mode) ; required or helm-find-file to work
(require 'helm-config)
(require 'helm-swoop)
(require 'compile)
(require 'helm-git-grep)
(require 'helm-projectile)
(require 'recentf)
(helm-autoresize-mode 1)
(setq recentf-auto-cleanup 'never
      helm-boring-file-regexp-list (list
                                    "\\.la$" "\\.o$" "~$"                           ;; cache files
                                    "\\.git" "\\.hg" "\\.svn" "\\.CVS" "\\._darcs"  ;; vss
                                    "\\.tox" "\\.elc$" "\\.pyc$" "virtualenvs" "\\.pip" "\\.pylint\\.d"  ;; python
                                    ;; source from other packages
                                    "/src/" "/elpa/" "/build/" "/_archive/" "advance-services-svn"
                                    (expand-file-name "~/rpmbuild")
                                    (expand-file-name "~/.devpi")
                                    (expand-file-name "~/.cache")
                                    (expand-file-name "~/.local/lib")
                                    (expand-file-name "~/.local/share"))
      helm-always-two-windows nil
      helm-split-window-in-side-p t
      helm-split-window-default-side 'below
      helm-autoresize-max-height 40
      helm-autoresize-min-height 40)

(use-package helm-dash
  :straight t
  :config
  (progn
    (setq helm-dash-browser-func 'eww)
    ;; constantly says "cannot open ''"
    (setq dash-docs-enable-debugging nil)
    (setq helm-dash-common-docsets (dash-docs-installed-docsets)))
  )

(setq helm-display-header-line nil)
(defun helm-toggle-header-line ()
  "Show the source header if there is more than one source, otherwise don't"
  (if (> (length helm-sources) 1)
      (set-face-attribute 'helm-source-header
                          nil
                          :foreground helm-source-header-default-foreground
                          :background helm-source-header-default-background
                          :box helm-source-header-default-box
                          :height 1.0)
    (set-face-attribute 'helm-source-header
                        nil
                        :foreground (face-attribute 'helm-selection :background)
                        :background (face-attribute 'helm-selection :background)
                        :box nil
                        :height 0.1)))

;(use-package helm-fd :bind (:map helm-command-map ("/" . helm-fd)))

(defun bwm:helm-find-files (arg)
  "Find files kinda related to current work

Look for:

    * recent files
    * current buffers
    * projectile files
    * files in current dir

Increasing prefixes expand the number of files to look at:

* C-u also add locate and bookmarks, but ignore src/ and virtualenv folders
* C-u C-u means locate, including src and virtualenv folders

based off of http://stackoverflow.com/a/19284509/25616"
  ;; just in case someone decides to pass an argument, helm-omni won't fail.
  (interactive "P")
  (let* (                   ;(helm-ff-transformer-show-only-basename nil)
         (sources (append   ;; projectile errors out if you're not in a project
                   (if (projectile-project-p) ;; so look before you leap
                       '(               ;helm-source-projectile-recentf-list
                                        ;helm-source-projectile-buffers-list
                         helm-source-projectile-files-list)
                     '(helm-c-source-files-in-current-dir))

                   '(helm-source-buffers-list ;; list of all open buffers
                                        ;helm-source-buffer-not-found     ;; ask to create a buffer otherwise
                     )))
         (sources (if arg
                      (append '(helm-c-source-recentf ;; all recent files
                                helm-source-locate    ;; file anywhere
                                )
                              sources
                              '(helm-c-source-bookmarks)) ;; bookmarks too
                    sources))
         (helm-boring-file-regexp-list (if (and arg (> (car arg) 4))
                                           (remove "/src/"
                                                   (remove "virtualenvs"
                                                           helm-boring-file-regexp-list))
                                         helm-boring-file-regexp-list)))
    (helm-other-buffer (if (projectile-project-p) ;; so look before you leap
                           '(           ;helm-source-projectile-recentf-list
                                        ;helm-source-projectile-buffers-list
                             helm-source-projectile-files-list)
                         '(helm-c-source-files-in-current-dir)) ; sources
                       "*helm-find-files*")))

(defun hgrep (arg)
  "Run helm-git-grep, defaulting to nothing

With prefix arg, use the thing at point"
  (interactive "P")
  (if arg
      (helm-git-grep-at-point)
    (helm-git-grep)))


;; TODO: use ripgrep
;; (defun helm-git-grep-rg-process ()
;;   "Retrieve candidates from result of git grep."
;;   (helm-aif (helm-attr 'base-directory)
;;       (let ((default-directory it))
;;         (apply 'start-process "git-grep-rg-process" nil "rg" (helm-git-grep-rg-args))) '()))

;; (defun helm-git-grep-rg-args ()
;;   "Create arguments of `helm-git-grep-process' in `helm-git-grep'."
;;   (delq nil
;;         (append
;;          (list "--null" "--no-color"
;;                (if helm-git-grep-ignore-case "-i" nil)
;;                (if helm-git-grep-wordgrep "-w" nil)
;;                (helm-git-grep-showing-leading-and-trailing-lines-option))
;;          (nbutlast
;;           (apply 'append
;;                  (mapcar
;;                   (lambda (x) (list "-e" x "--and"))
;;                   (split-string helm-pattern " +" t))))
;;          (helm-git-grep-pathspec-args))))

;; (defvar helm-git-grep-rg-source
;;   (helm-make-source "Git ripgrep" 'helm-git-grep-class
;;     :candidates-process 'helm-git-grep-rg-process))

;; (setq helm-git-grep-source '(helm-git-grep-source))


;; When doing isearch, hand the word over to helm-swoop
(define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
(define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)
(define-key helm-git-grep-map (kbd "C-c C-n") 'helm-goto-next-file)
(define-key helm-git-grep-map (kbd "C-c C-p") 'helm-goto-precedent-file)

(defun bwm:helm-swoop-only-exact-match ()
  "Surround the selected text with word-delimiters"
  (concat "\\b" (thing-at-point 'symbol) "\\b"))
(defun bwm:helm-swoop-liberal-match ()
  "This is the original helm-swoop function"
  (thing-at-point 'symbol))

(defun bwm:toggle-helm-swoop-matcher ()
  (interactive)
  (if (eq helm-swoop-pre-input-function #'bwm:helm-swoop-only-exact-match)
      (setq helm-swoop-pre-input-function #'bwm:helm-swoop-liberal-match)
    (setq helm-swoop-pre-input-function #'bwm:helm-swoop-only-exact-match)))
