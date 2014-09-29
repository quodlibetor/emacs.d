;;; Customizations to get emacs to work right on Apple products
(add-to-list 'exec-path "/usr/local/opt/coreutils/libexec/gnubin")
(setq locate-command "mdfind")
(setq helm-locate-command "mdfind %s %s")
(global-set-key (kbd "s-w") 'kill-ring-save)
(setenv "TMPDIR" "/tmp")  ; /var/folders/hh/30-byte-hex/90-byte-hex really?
(setq mac-command-modifier 'meta)
(dolist (path '("/usr/local/Library/ENV/4.3"
                "/usr/local/opt/autoconf/bin"
                "/usr/local/opt/automake/bin"
                "/usr/local/opt/pkg-config/bin"
                "/usr/local/opt/libtasn1/bin"
                "/usr/local/opt/nettle/bin"
                "/usr/local/opt/gnutls/bin"
                "/usr/local/opt/git/bin"
                "/usr/bin"
                "/bin"
                "/usr/sbin"
                "/sbin"
                "/private/tmp/emacs-51yb/lib-src"
                "/usr/local/Cellar/emacs/HEAD/libexec/emacs/24.4.50/x86_64-apple-darwin13.3.0"
                "/usr/local/bin"))
        (add-to-list 'exec-path path))
(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
