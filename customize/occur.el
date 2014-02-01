(require 'highlight)

(defun bwm:show-word ()
  (save-excursion
    (hlt-unhighlight-region)
    (push-mark)
    (setq mark-active t)
    (forward-word)
    (hlt-highlight-region)
    (setq mark-active nil)
    (recenter)))

(defun bwm:next-occurence ()
  "Show the occurence on the next line"
  (interactive)
  (let ((occ (current-buffer)))
    (next-line)
    (occur-mode-goto-occurrence-other-window)
    (bwm:show-word)
    (switch-to-buffer-other-window occ)))

(defun bwm:prev-occurence ()
  "Show the occurence on the previous line"
  (interactive)
  (let ((occ (current-buffer)))
    (previous-line)
    (occur-mode-goto-occurrence-other-window)
    (bwm:show-word)
    (switch-to-buffer-other-window occ)))

(defun bwm:occur-goto-occurence ()
  (interactive)
  (occur-mode-goto-occurrence)
  (hlt-unhighlight-region))

(when (fboundp 'occur)
  (define-key occur-mode-map (kbd "n") 'bwm:next-occurence)
  (define-key occur-mode-map (kbd "p") 'bwm:prev-occurence)
  (define-key occur-mode-map (kbd "<return>") 'bwm:occur-goto-occurence)
  (define-key occur-mode-map (kbd "RET") 'bwm:occur-goto-occurence))
