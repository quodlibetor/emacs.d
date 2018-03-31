(require 'company)
(add-hook 'go-mode-hook
          (lambda ()
            (setq tab-width 4)
            (setq-local compile-command "go build")
            (add-hook 'before-save-hook 'gofmt-before-save)
            (set (make-local-variable 'company-backends) '(company-go))
            (company-mode)
            (setq-local company-minimum-prefix-length 0)
            (local-set-key (kbd "M-.") 'godef-jump)
            (if (not (string-match "go" compile-command))
                (set (make-local-variable 'compile-command)
                     "go build -v && go vet && go test -v"))))
(require 'go-mode)

(setenv "GOPATH" "/Users/bwm/go")
; exec-path is configured to include ~/go/bin via customize/ui's handling of path-from-shell
