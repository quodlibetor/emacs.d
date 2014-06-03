(require 'notmuch)

(add-hook 'notmuch-show-hook
          (lambda ()
            (setq show-trailing-whitespace nil)))

(defun bwm:change-widget-color ()
  ;;; doesn't actually work
  ;; (set (make-local-variable widget-button-face) '(t (:foreground "dark blue")))
  ;; (set (make-local-variable link) '(t (:foreground "dark blue")))
  )

(defun bwm:notmuch-jump-to-inbox ()
  (run-at-time 0.1 nil (lambda ()
                         (re-search-forward "inbox")
                         (backward-word))))

(add-hook 'notmuch-hello-mode-hook
          #'bwm:notmuch-jump-to-inbox)

;; (add-hook 'notmuch-show-hook
;;           ;#'bwm:change-widget-color
;;           )

(setq notmuch-search-oldest-first nil)

(define-key notmuch-show-mode-map "d"
      (lambda ()
        "notmuch delete message"
        (interactive)
        (notmuch-show-tag-message "+trash" "-inbox")))

(define-key notmuch-show-mode-map "D"
      (lambda ()
        "notmuch hard delete message"
        (interactive)
        (notmuch-show-tag-message "+deleted" "-inbox")))


(define-key notmuch-search-mode-map "d"
  (lambda (&optional beg end)
    "Delete thread"
    (interactive (notmuch-search-interactive-region))
    (notmuch-search-tag '("+trash" "-inbox") beg end)
    (forward-line)))

(define-key notmuch-search-mode-map "D"
  (lambda (&optional beg end)
    "Hard Delete thread"
    (interactive (notmuch-search-interactive-region))
    (notmuch-search-tag '("+deleted" "-inbox") beg end)
    (forward-line)))


(define-key notmuch-tree-mode-map "d"
  (lambda (&optional beg end)
    "Delete thread"
    (interactive)
    (notmuch-tree-tag '("+trash" "-inbox"))
    (forward-line)))


(define-key notmuch-tree-mode-map "D"
  (lambda (&optional beg end)
    "Hard Delete thread"
    (interactive)
    (notmuch-tree-tag '("+deleted" "-inbox"))
    (forward-line)))


(defun bwm:notmuch-really-actually-delete-deleted ()
  (interactive)
  (start-process-shell-command
   "notmuch-delete" nil
   "notmuch search --output=files tag:deleted | xargs -l rm && notmuch new"))

;;; notmuch.el ends here
