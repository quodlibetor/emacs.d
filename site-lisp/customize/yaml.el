(add-to-list 'auto-mode-alist
             '("\\.ya?ml$" . yaml-mode))
;; TODO: make this go to the previous line with less indentation
(defun yaml-next-field ()
  "Jump to next yaml field"
  (interactive)
  (end-of-line)
  (search-forward-regexp ":\\( \\|$\\)")
  (backward-char)
  (search-backward-regexp " ")
  (forward-char))
(defun yaml-prev-field ()
  "Jump to next yaml field"
  (interactive)
  (search-backward-regexp ":\\( \\|$\\)")
  (backward-char)
  (search-backward-regexp " ")
  (forward-char))

(defun yaml-prev-section ()
  (interactive)
  (search-backward-regexp "- [-a-zA-Z]+:\\( \\|$\\)")
  (forward-char 2))

(defun yaml-next-section ()
  (interactive)
  (end-of-line)
  (search-forward-regexp "- [-a-zA-Z]+:\\( \\|$\\)")
  (search-backward-regexp "- ")
  (forward-char 2))

(require 'yaml-mode)
(define-key yaml-mode-map (kbd "M-n") 'yaml-next-field)
(define-key yaml-mode-map (kbd "M-p") 'yaml-prev-field)
(define-key yaml-mode-map (kbd "C-M-a") 'yaml-prev-section)
(define-key yaml-mode-map (kbd "C-M-e") 'yaml-next-section)

(add-hook 'yaml-mode-hook
          (lambda ()
            (hack-local-variables)
            (when (boundp 'project-venv-name)
              (venv-workon project-venv-name)
              (ansible-doc-mode))))
