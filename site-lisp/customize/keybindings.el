(when (boundp 'mac-option-modifier) (setq mac-option-modifier 'super))

(global-set-key (kbd "<f2>") 'flycheck-next-error)
(global-set-key (kbd "M-<f2>") 'flycheck-previous-error)
(define-key flymake-mode-map (kbd "M-n") 'flymake-goto-next-error)
(define-key flymake-mode-map (kbd "M-p") 'flymake-goto-prev-error)
(global-set-key (kbd "<f3>") 'flycheck-explain-error-at-point)
(global-set-key (kbd "<f4>") 'flycheck-buffer)
(global-set-key (kbd "C-c w") 'fixup-whitespace)
(global-set-key (kbd "C-c g") 'magit-status)
(global-set-key (kbd "C-c b") 'magit-blame)
(global-set-key (kbd "C-c p p") 'projectile-switch-project)
(global-set-key (kbd "C-c p r") 'projectile-replace-regexp)
(global-set-key (kbd "C-c f") 'bwm:helm-find-files)
(global-set-key (kbd "M-s o") 'helm-swoop)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-s") 'bwm:arbitrary-search)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "M-%") 'query-replace-regexp)
(global-set-key (kbd "C-c O") 'rotate-windows)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-;") 'mc/mark-all-like-this-dwim)
(global-set-key (kbd "C-'") 'er/expand-region)
(global-set-key (kbd "M-i") 'company-complete)
(global-set-key (kbd "M-z") 'zzz-to-char)
(global-set-key (kbd "M-g w") 'avy-goto-word-1)
(global-set-key (kbd "M-g h") 'avy-goto-word-1)
(global-set-key (kbd "M-g M-h") 'avy-goto-word-1)
(global-set-key (kbd "M-g M-w") 'avy-goto-word-1)
(global-set-key (kbd "M-g M-g") 'avy-goto-line)
(global-set-key (kbd "M-g g") 'avy-goto-line)
(global-set-key (kbd "C-c C-;") 'endless/comment-line-or-region)
(global-set-key (kbd "C-h a") 'helm-apropos)
(global-set-key (kbd "C-z") 'repeat)
(global-set-key (kbd "C-c ! h") 'helm-flycheck)
(global-set-key (kbd "C-x C-j") 'dired-jump)


(defhydra bwm-multiple-cursors-hydra (:hint nil)
  "
     ^Up^            ^Down^        ^Miscellaneous^
----------------------------------------------
[_p_]   Next    [_n_]   Next    [_l_] Edit lines
[_P_]   Skip    [_N_]   Skip    [_a_] Mark all    [_m_] Mark All DWIM
[_M-p_] Unmark  [_M-n_] Unmark  [_q_] Quit"
  ("l" mc/edit-lines :exit t)
  ("m" mc/mark-all-like-this-dwim :exit t)
  ("a" mc/mark-all-like-this :exit t)
  ("n" mc/mark-next-like-this)
  ("N" mc/skip-to-next-like-this)
  ("M-n" mc/unmark-next-like-this)
  ("p" mc/mark-previous-like-this)
  ("P" mc/skip-to-previous-like-this)
  ("M-p" mc/unmark-previous-like-this)
  ("q" nil))
(global-set-key (kbd "C-c m") 'bwm-multiple-cursors-hydra/body)

(winner-mode 1) ;; enable "C-c →" and "C-c ←" to switch between previous window
                ;; layouts

;; misc commands
(substitute-key-definition   'move-beginning-of-line 'beginning-of-line+ global-map)
(substitute-key-definition   'move-end-of-line 'end-of-line+ global-map)
(substitute-key-definition   'back-to-indentation 'beginning-or-indentation global-map)

;; org-mode
(global-set-key (kbd "C-c ol") 'org-store-link)
(global-set-key (kbd "C-c oa") 'org-agenda)
(global-set-key (kbd "C-c oc") 'org-capture)
(global-set-key (kbd "C-c oj") 'org-clock-goto)
(global-set-key (kbd "C-c ob") 'org-iswitchb)
(require 'helm-org)
(global-set-key (kbd "C-c os") 'helm-org-agenda-files-headings)

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
    (if (looking-back "^[[:blank:]]*[[:punct:][:alnum:]].*" 1)
	(fixup-whitespace)
      (indent-according-to-mode))))
(global-set-key (kbd "C-c j") 'pull-line)

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
(defalias 'sudo-reopen 'find-alternative-file-with-sudo)
