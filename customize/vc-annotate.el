(defun bwm/magit-show-annotated-commit ()
  (interactive)
  (save-excursion
    (beginning-of-line)
    (let ((hash-start (point)))
      (forward-word)
      (magit-show-commit (buffer-substring-no-properties hash-start (point))))))

(add-hook 'vc-annotate-mode-hook
          (lambda ()
            (local-set-key (kbd "m s") 'bwm/magit-show-annotated-commit)
            (local-set-key (kbd "m <RET>") 'bwm/magit-show-annotated-commit)))
