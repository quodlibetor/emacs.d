(add-to-list 'auto-mode-alist
	     '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist
	     '("github.com.*txt\\'" . markdown-mode))

(add-hook 'markdown-mode-hook
          (lambda ()
            (setq fill-column 98)
            (visual-fill-column-mode 1)
            (toggle-word-wrap 1)))

(require 'org-table)

(defun cleanup-org-tables ()
  (save-excursion
    (goto-char (point-min))
    (while (search-forward "-+-" nil t) (replace-match "-|-"))
    ))

(add-hook 'markdown-mode-hook 'orgtbl-mode)
(add-hook 'markdown-mode-hook
          (lambda()
            (add-hook 'after-save-hook 'cleanup-org-tables  nil 'make-it-local)))
