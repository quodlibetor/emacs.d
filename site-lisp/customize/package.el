(require 'package)

(setq package-enable-at-startup nil)

(setq package-archives '(("melpa" . "http://melpa.org/packages/")
                         ("melpa-stable" . "http://stable.melpa.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("elpy" . "http://jorgenschaefer.github.io/packages/")
                         ;("gnu" . "https://elpa.gnu.org/packages/")
                         ))

(defun package-menu-find-marks ()
  "Find packages marked for action in *Packages*."
  (interactive)
  (occur "^[A-Z]"))

;; Only in Emacs 25.1+
(defun package-menu-filter-by-status (status)
  "Filter the *Packages* buffer by status."
  (interactive
   (list (completing-read
          "Status: " '("new" "installed" "dependency" "obsolete"))))
  (package-menu-filter-by-keyword (concat "status:" status)))

(define-key package-menu-mode-map "s" #'package-menu-filter-by-status)
(define-key package-menu-mode-map "a" #'package-menu-find-marks)
