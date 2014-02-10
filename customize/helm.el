(require 'helm)
(require 'helm-config)
(require 'helm-swoop)
(require 'helm-projectile)
(require 'recentf)
(setq recentf-auto-cleanup 'never)
(setq helm-boring-file-regexp-list
      '("\\.la$" "\\.o$" "~$"                           ;; cache files
        "\\.git" "\\.hg" "\\.svn" "\\.CVS" "\\._darcs"  ;; vss
        "\\.tox" "\\.elc$" "\\.pyc$" "\\.virtualenvs"   ;; python
        "/src/" "/elpa/" "advance-services-svn")) ;; source from other packages
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
  (interactive "p")
  (let* ((helm-ff-transformer-show-only-basename nil)
         (sources (append ;; projectile errors out if you're not in a project
                          (if (projectile-project-p) ;; so look before you leap
                              '(helm-source-projectile-files-list
                                helm-source-projectile-recentf-list
                                helm-source-projectile-buffers-list)
                            '(helm-c-source-files-in-current-dir))

                          '(helm-c-source-buffers-list ;; list of all open buffers
                            helm-c-source-buffer-not-found     ;; ask to create a buffer otherwise
                            )))
         (sources (if arg
                      (append '(helm-c-source-recentf) ;; all recent files
                              sources
                              '(helm-c-source-locate      ;; file anywhere
                                helm-c-source-bookmarks)) ;; bookmarks too
                    sources))
         (helm-boring-file-regexp-list (if (> arg 4)
                                           (remove "/src/"
                                                 (remove "\\.virtualenvs"
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
