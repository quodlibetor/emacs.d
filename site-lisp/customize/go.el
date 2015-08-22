(add-hook 'go-mode-hook
          (lambda ()
            (setq tab-width 4)
            (setq-local compile-command "go build")))

(setenv "GOPATH" "/Users/bwm/go")
