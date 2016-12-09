(require 'org "./org")
(setq puml-plantuml-jar-path org-plantuml-jar-path)
(require 'puml-mode)
(add-to-list 'auto-mode-alist '("\\.puml\\'" . puml-mode))
(add-hook 'puml-mode-hook (lambda ()
                            (rainbow-mode t)))
