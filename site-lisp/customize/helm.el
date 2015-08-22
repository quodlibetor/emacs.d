(require 'helm)
(require 'helm-config)
(require 'helm-swoop)
(require 'helm-git-grep)
(require 'helm-projectile)
(require 'recentf)
(setq recentf-auto-cleanup 'never)
(setq helm-boring-file-regexp-list
      (list
       "\\.la$" "\\.o$" "~$"                           ;; cache files
       "\\.git" "\\.hg" "\\.svn" "\\.CVS" "\\._darcs"  ;; vss
       "\\.tox" "\\.elc$" "\\.pyc$" "virtualenvs" "\\.pip" "\\.pylint\\.d"  ;; python
       "/src/" "/elpa/" "/build/" "/_archive/" "advance-services-svn" ;; source from other packages
       (expand-file-name "~/rpmbuild") (expand-file-name "~/.devpi") (expand-file-name "~/.cache")
       (expand-file-name "~/.local/lib") (expand-file-name "~/.local/share")))

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
(helm-autoresize-mode 1)
(setq helm-autoresize-max-height 40)
(setq helm-autoresize-min-height 40)
(setq helm-split-window-in-side-p t)

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
  (let* ((helm-ff-transformer-show-only-basename nil)
         (sources (append ;; projectile errors out if you're not in a project
                          (if (projectile-project-p) ;; so look before you leap
                              '(helm-source-projectile-recentf-list
                                helm-source-projectile-buffers-list
                                helm-source-projectile-files-list)
                            '(helm-c-source-files-in-current-dir))

                          '(helm-c-source-buffers-list ;; list of all open buffers
                            helm-c-source-buffer-not-found     ;; ask to create a buffer otherwise
                            )))
         (sources (if arg
                      (append '(helm-c-source-recentf     ;; all recent files
                                helm-source-locate        ;; file anywhere
                                )
                              sources
                              '(helm-c-source-bookmarks)) ;; bookmarks too
                    sources))
         (helm-boring-file-regexp-list (if (and arg (> (car arg) 4))
                                           (remove "/src/"
                                                 (remove "virtualenvs"
                                                       helm-boring-file-regexp-list))
                                         helm-boring-file-regexp-list)))
    (helm-other-buffer sources
                       "*helm-find-files*")))
(defun hgrep (arg)
  "Run helm-git-grep, defaulting to nothing

With prefix arg, use the thing at point"
  (interactive "P")
  (if arg
      (helm-git-grep-at-point)
    (helm-git-grep)))

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
