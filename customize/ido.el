(require 'bookmark)
(require 'ido)

(defun my-ido-bookmark-jump ()
  "Jump to bookmark using ido"
  (interactive)
  (let ((dir (my-ido-get-bookmark-dir)))
    (when dir
      (find-alternate-file dir))))

(defun my-ido-get-bookmark-dir ()
  "Get the directory of a bookmark."
  (let* ((name (ido-completing-read "Use dir of bookmark: " (bookmark-all-names) nil t))
         (bmk (bookmark-get-bookmark name)))
    (when bmk
      (setq bookmark-alist (delete bmk bookmark-alist))
      (push bmk bookmark-alist)
      (let ((filename (bookmark-get-filename bmk)))
        (if (file-directory-p filename)
            filename
          (file-name-directory filename))))))

(defun my-ido-dired-mode-hook ()
  (define-key dired-mode-map "$" 'my-ido-bookmark-jump))

(defun my-ido-use-bookmark-dir ()
  "Get directory of bookmark"
  (interactive)
  (let* ((enable-recursive-minibuffers t)
         (dir (my-ido-get-bookmark-dir)))
    (when dir
      (ido-set-current-directory dir)
      (setq ido-exit 'refresh)
      (exit-minibuffer))))

(add-hook 'ido-minibuffer-setup-hook
          (lambda ()
            (define-key ido-file-dir-completion-map (kbd "$")
              'my-ido-use-bookmark-dir)))
