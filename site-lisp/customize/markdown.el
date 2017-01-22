(add-to-list 'auto-mode-alist
	     '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist
	     '("github.com.*txt\\'" . markdown-mode))

(add-hook 'markdown-mode-hook
          (lambda ()
            (visual-fill-column-mode 1)
            (toggle-word-wrap 1)))
