(global-set-key (kbd "<f2>") 'flymake-start-syntax-check)
(global-set-key (kbd "<f3>") 'flymake-display-err-menu-for-current-line)
(global-set-key (kbd "<f4>") 'flymake-goto-next-error)
(global-set-key (kbd "C-c w") 'fixup-whitespace)
(global-set-key (kbd "C-c g") 'magit-status)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; misc commands
(substitute-key-definition   'move-beginning-of-line 'beginning-of-line+ global-map)
(substitute-key-definition   'move-end-of-line 'end-of-line+ global-map)
(substitute-key-definition   'back-to-indentation 'beginning-or-indentation global-map)

;; org-mode
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)

;; confluence wiki
(global-set-key (kbd "C-c cf") 'confluence-get-page)
(global-set-key (kbd "C-c cc") 'confluence-create-page)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)

; easy moving-around windows
(require 'windmove)
(windmove-default-keybindings)

;; make fonts resizable!
;; prefix arg of 0 resets to default
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(defun pull-line ()
  "Pull the next line that contains anything up to the end of this one"
  (interactive)
  (save-excursion
    (end-of-line)
    (while (looking-at "[ \n\r\t]")
      (delete-char 1))
    (if (looking-back "^[[:blank:]]*[[:punct:][:alnum:]].*")
	(fixup-whitespace)
      (indent-according-to-mode))))
(global-set-key (kbd "C-c p") 'pull-line)

(defun rotate-windows ()
  "Rotate your windows"
  (interactive)
  (cond
   ((not (> (count-windows) 1))
    (message "You can't rotate a single window!"))
   (t
    (let ((i 1)
          (num-windows (count-windows)))
      (while  (< i num-windows)
        (let* ((w1 (elt (window-list) i))
               (w2 (elt (window-list) (+ (% i num-windows) 1)))
               (b1 (window-buffer w1))
               (b2 (window-buffer w2))
               (s1 (window-start w1))
               (s2 (window-start w2)))
          (set-window-buffer w1 b2)
          (set-window-buffer w2 b1)
          (set-window-start w1 s2)
          (set-window-start w2 s1)
          (setq i (1+ i))))))))

(global-set-key (kbd "C-c o") 'rotate-windows)

(defun find-alternative-file-with-sudo ()
  (interactive)
  (let ((fname (or buffer-file-name
		   dired-directory)))
    (when fname
      (if (string-match "^/sudo:root@localhost:" fname)
	  (setq fname (replace-regexp-in-string
		       "^/sudo:root@localhost:" ""
		       fname))
	(setq fname (concat "/sudo:root@localhost:" fname)))
      (find-alternate-file fname))))
(global-set-key (kbd "C-c r") 'find-alternative-file-with-sudo)
