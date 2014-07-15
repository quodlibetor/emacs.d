(require 'mu4e)

(defun bwm:sprint-mail ()
  (interactive)
  (let* ((today (calendar-current-date))
         (first-day-of-week (- (cadr today) (calendar-day-of-week today)))
         (begin-string (format (format-time-string "%Y/%m/%%s") first-day-of-week))
         (end-string (format (format-time-string "%Y/%m/%%s") (cadr today))))
    (goto-char (point-min))
    (re-search-forward "To: ")
    (insert "Mozam Hosein <mhosein@advance.net>")
    (re-search-forward "Subject: ")
    (insert (format (format-time-string "Weekly Status for w%U (%%s - %%s)")
                    begin-string end-string))

    (forward-line 3)
    (let ((start (point)))
      (kill-region start (point-max)))
    (insert (concat "Hi Mozam,

This week I [killed some bugz].


\[killed some bugz]: https://jira2.advance.net/issues/?jql=project%20%3D%20%22Services%20Development%22%20AND%20assignee%20%3D%20bmaister%20AND%20updatedDate%20%3E%3D%20" (replace-regexp-in-string "/" "-" begin-string) "%20AND%20updatedDate%20%3C%3D%20" (replace-regexp-in-string "/" "-" end-string) "%20AND%20status%20in%20%28Closed%2C%20Resolved%29%20ORDER%20BY%20updatedDate%20DESC

bwm
"))

    ;; put the url in the clipboard
    (re-search-backward "https")
    (kill-line)
    (yank)

    (re-search-backward end-string)
    (forward-word 2)))

(setq mu4e-maildir (expand-file-name "~/mail")
      mu4e-update-interval 240
      mu4e-sent-folder   "/Sent"
      mu4e-drafts-folder "/Drafts"
      mu4e-trash-folder  "/Trash"
      mu4e-refile-folder "/Archives.2014"

      mu4e-maildir-shortcuts '(("/archive"     . ?a)
                               ("/inbox"       . ?i)
                               ("/work"        . ?w)
                               ("/sent"        . ?s))
      mu4e-change-filenames-when-moving t

      mu4e-user-mail-address-list '("bmaister@advance.net")

      mu4e-get-mail-command "true" ; "mbsync advance"

      user-mail-address "bmaister@advance.net"
      user-full-name  "Brandon W Maister"
      mu4e-view-show-images nil
      mu4e-html2text-command "html2text | grep -v '&nbsp_place_holder;'"
      )

(add-hook 'mu4e-view-mode-hook
          (lambda () (dont-show-trailing-whitespace)))
(add-hook 'mu4e-headers-mode-hook
          (lambda () (dont-show-trailing-whitespace)))

;; include in message with C-c C-w
(setq message-signature
      "bwm\n")

(setq
 message-send-mail-function 'smtpmail-send-it
 smtpmail-default-smtp-server "localhost"
 smtpmail-smtp-server "localhost"
;; smtpmail-smtp-port 1025
 smtpmail-smtp-service 1025
 smtpmail-local-domain "ailocal"
 smtpmail-sendto-domain "ailocal"
 ;smtpmail-starttls-credentials '(("localhost" 1025 nil nil))
 smtpmail-auth-credentials (expand-file-name "~/.authinfo")
 ;; if you need offline mode, set these -- and create the queue dir
 ;; with 'mu mkdir', i.e.. mu mkdir /home/user/Maildir/queue
 ;smtpmail-queue-mail  nil
 smtpmail-queue-dir  (expand-file-name "~/Maildir/queue/cur")
 )

;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)


(setq starttls-use-gnutls t)
(setq starttls-gnutls-program "gnutls-cli")
(setq starttls-extra-arguments nil)

;; use imagemagick, if available, for displaying images
;; (when (fboundp 'imagemagick-register-types)
;;   (imagemagick-register-types))
