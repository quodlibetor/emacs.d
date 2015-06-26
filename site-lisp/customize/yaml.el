(add-to-list 'auto-mode-alist
             '("\\.ya?ml$" . yaml-mode))
;; TODO: make this go to the previous line with less indentation
(defun ansible-next-field ()
  "Jump to next yaml field"
  (interactive)
  (end-of-line)
  (search-forward-regexp ":\\( \\|$\\)")
  (backward-char)
  (search-backward-regexp " ")
  (backward-char))

(defun ansible-prev-field ()
  "Jump to next yaml field"
  (interactive)
  (search-backward-regexp ":\\( \\|$\\)")
  (backward-char)
  (search-backward-regexp " ")
  (backward-char))

(defun ansible-prev-section ()
  (interactive)
  (search-backward-regexp "- [-a-zA-Z]+:\\( \\|$\\)"))

(defun ansible-next-section ()
  (interactive)
  (end-of-line)
  (search-forward-regexp "- [-a-zA-Z]+:\\( \\|$\\)")
  (search-backward-regexp "- "))

(require 'yaml-mode)
(define-key yaml-mode-map (kbd "M-n") 'ansible-next-field)
(define-key yaml-mode-map (kbd "M-p") 'ansible-prev-field)
(define-key yaml-mode-map (kbd "C-M-a") 'ansible-prev-section)
(define-key yaml-mode-map (kbd "C-M-e") 'ansible-next-section)

(add-hook 'yaml-mode-hook
          (lambda ()
            (hack-local-variables)
            (when (boundp 'project-venv-name)
              (venv-workon project-venv-name)
              (ansible-doc-mode))))
