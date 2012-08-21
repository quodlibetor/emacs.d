; see customize/ui, because I make flymake activate everywhere, there and see
; $emacs/packages/flymake-python/flymake-customizations.el for a bunch of ways
; to customize it

; the pyflakes stuff is all from https://github.com/akaihola/flymake-python

(add-hook 'python-mode-hook
          (lambda ()
            (require 'virtualenv)
            (require 'nose)
            (set (make-local-variable 'nose-use-verbose) nil)
            (local-set-key (kbd "C-c n a") 'nosetests-all)
            (local-set-key (kbd "C-c n m") 'nosetests-module)
            (local-set-key (kbd "C-c n o") 'nosetests-one)
            (local-set-key (kbd "C-c n p a") 'nosetests-pdb-all)
            (local-set-key (kbd "C-c n p m") 'nosetests-pdb-module)
            (local-set-key (kbd "C-c n p o") 'nosetests-pdb-one)
            ))

(when (load "flymake" t)
  (defun flymake-pylint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-intemp))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      ;;     check path
      (list "~/.local/bin/pyflymake.py" (list "--source-file" buffer-file-name
                                              local-file))))

  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pylint-init)))

