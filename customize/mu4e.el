(require 'mu4e)

(setq mu4e-maildir "/home/bwm/Maildir"
      mu4e-update-interval 600
      mu4e-sent-folder   "/Sent"
      mu4e-drafts-folder "/Drafts"
      mu4e-trash-folder  "/Trash"
      mu4e-refile-folder "/Archives.2014"

      mu4e-maildir-shortcuts '(("/archive"     . ?a)
                               ("/inbox"       . ?i)
                               ("/work"        . ?w)
                               ("/sent"        . ?s))

      mu4e-user-mail-address-list '("bmaister@advance.net")

      mu4e-get-mail-command "offlineimap -d maildir -o"

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
 smtpmail-queue-dir  "/home/bwm/Maildir/queue/cur"
 )

;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)


(setq starttls-use-gnutls t)
(setq starttls-gnutls-program "gnutls-cli")
(setq starttls-extra-arguments nil)

;; use imagemagick, if available, for displaying images
;; (when (fboundp 'imagemagick-register-types)
;;   (imagemagick-register-types))
