(require 'rust-mode)

(defun bwm:sane-newline (point)
  "Newline and indent and indent closing brace"
  (interactive "d")
  (when (member (and (not (= point (point-max)))
                     (buffer-substring point (+ point 1))) '("}" "]"))
    (save-excursion (insert "\n")
                    (forward-char)
                    (indent-according-to-mode)))
  (electric-newline-and-maybe-indent))

(define-key rust-mode-map (kbd "C-j") 'bwm:sane-newline)
(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
