;;; Customizations to get emacs to work right on Apple products
(add-to-list 'exec-path "/usr/local/opt/coreutils/libexec/gnubin")
(setq locate-command "mdfind")
(setq helm-locate-command "mdfind %s %s")
