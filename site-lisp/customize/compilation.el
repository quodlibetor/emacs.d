(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region (point-min) (point-max))))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)
(add-hook 'compilation-mode-hook 'dont-show-trailing-whitespace)

(require 'cl)
(eval-after-load "compile"
  (lambda ()
    (pushnew '(whatchow-check "^    \\(\\([^ >:]+\\):\\([0-9]+\\):\\([0-9]+\\)?\\)" 2 3 4 1) compilation-error-regexp-alist-alist)))
