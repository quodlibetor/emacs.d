(add-to-list 'load-path "~/.emacs.d/packages/org-8.2/lisp")
(add-to-list 'load-path "~/.emacs.d/packages/org-8.2/contrib/lisp" t)
(require 'org)
(require 'ox-latex)
(require 'ox-s5)

(setq org-hide-leading-stars t
      org-columns-default-format "%35ITEM(Task) %17Effort(Estimated Effort){:} %CLOCKSUM(Time Spent) %TODO %3PRIORITY %TAGS"
      org-clock-into-drawer t
      org-todo-keywords '((sequence "TODO(t)" "IN-PROGRESS(i)" "|" "DONE(d)")
			  (sequence "NEXT(n)" "|")
			  (sequence "BUG(b)" "|" "FIXED(f)" "WONTFIX(w)"))
      org-log-done 'time
      org-use-speed-commands t
      org-clock-out-remove-zero-time-clocks t
      org-html-head "<style type=\"text/css\">\n <!--/*--><![CDATA[/*><!--*/\n  html { font-family: Times, serif; font-size: 12pt; }\n  .title  { text-align: center; }\n  .todo   { color: red; }\n  .done   { color: green; }\n  .tag    { background-color: #add8e6; font-weight:normal }\n  .target { }\n  .timestamp { color: #bebebe; }\n  .timestamp-kwd { color: #5f9ea0; }\n  p.verse { margin-left: 3% }\n  pre {\nborder: 1pt solid #AEBDCC;\nbackground-color: #F3F5F7;\npadding: 5pt;\nfont-family: courier, monospace;\n        font-size: 90%;\n        overflow:auto;\n  }\n.slide pre{\nfont-size: 65%\n}\n.src {\n          background-color: #110000;\n          color: #4682b4;\n          font-family: \"DejaVu Sans Mono\", \"Inconsolata\", \"Consolas\", monospace;\n }\n  table { border-collapse: collapse; }\n  td, th { vertical-align: top; }\n  dt { font-weight: bold; }\n  div#content { max-width: 800px; margin: auto; }\n  div.figure { padding: 0.5em; }\n  div.figure p { text-align: center; }\n  .mono { font-family: \"DejaVu Sans Mono\", \"Inconsolata\", \"Consolas\", monospace; font-size: 10pt; }\n  code { background-color: #dfdfdf; font-size: 85%; padding: 0.1em; border-radius: 0.2em;}\n  .linenr { font-size:smaller }\n  .code-highlighted {background-color:#ffff00;}\n  .org-info-js_info-navigation { border-style:none; }\n  #org-info-js_console-label { font-size:10px; font-weight:bold;\n                               white-space:nowrap; }\n  .org-info-js_search-highlight {background-color:#ffff00; color:#000000;\n                                 font-weight:bold; }\n  /*]]>*/-->\n</style>\n"
      org-default-notes-file "/home/bwm/work.org"
      org-latex-pdf-process '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
                              "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
                              "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f")
      org-latex-minted-options '(("frame" "lines")
                                 ("fontsize" "\\scriptsize")
                                 ("linenos" ""))
      org-latex-listings 'minted
      )

(defun set-agenda-files ()
  (setq org-agenda-files
        (append '("~/work.org" "~/life.org" "~/SVC.org")
                ;; elisp doesn't have filter? daaaaaamn
                (delq nil
                      (mapcar (lambda (filename)
                                (and (not (string-match "/\.#" filename)) filename))
                              (file-expand-wildcards "~/projects/*/*.org")))))
  (message "Agenda files set to %s" org-agenda-files))

(defadvice org-agenda (before refresh-agenda-files activate)
  "make sure that all agenda files are included"
  (set-agenda-files))

;(setq jiralib-url "https://jira2.advance.net/")

;; (let ((load-path (cons ".emacs.d/packages/org-jira" load-path)))
;;   (require 'org-jira "packages/org-jira/org-jira"))

(add-hook 'org-mode-hook
	  (lambda ()
	    (set (make-local-variable 'fill-column) 80)))

(add-to-list 'org-latex-classes
             '("beamer"
               "\\documentclass\[presentation\]\{beamer\}"
               ("\\section\{%s\}" . "\\section*\{%s\}")
               ("\\subsection\{%s\}" . "\\subsection*\{%s\}")
               ("\\subsubsection\{%s\}" . "\\subsubsection*\{%s\}")))
(add-to-list 'org-latex-packages-alist '("" "minted"))
