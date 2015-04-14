(require 'dash)

(require 'org)
(require 'ox-latex)
(require 'ox-s5)
(require 'org-capture)

;; active Org-babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '(;; other Babel languages
   (plantuml . t)))

;; set plantuml jar path for linux or homebrew
(let* ((maybe-jars (-map 'expand-file-name
                         '("~/.local/lib/plantuml.jar"
                           "/usr/local/Cellar/plantuml/7999/plantuml.7999.jar")))
      (jars (-filter 'file-exists-p maybe-jars)))
  (if jars
      (setq org-plantuml-jar-path
            (car jars))
    (warn "plantuml is not installed [%s do not exist]" maybe-jars)))

(setq org-hide-leading-stars t
      org-columns-default-format "%35ITEM(Task) %17Effort(Estimated Effort){:} %CLOCKSUM(Time Spent) %TODO %3PRIORITY %TAGS"
      org-clock-into-drawer t
      org-todo-keywords '((sequence "TODO(t)" "IN-PROGRESS(i)" "|" "DONE(d)")
			  (sequence "NEXT(n)" "|")
			  (sequence "BUG(b)" "|" "FIXED(f)" "WONTFIX(w)")
                          (sequence "TO-SCHEDULE(s)" "|" "JIRAd(j)")
                          )
      org-log-done 'time
      org-use-speed-commands t
      org-clock-out-remove-zero-time-clocks t
      org-html-head "<style type=\"text/css\">\n <!--/*--><![CDATA[/*><!--*/\n  html { font-family: Times, serif; font-size: 12pt; }\n  .title  { text-align: center; }\n  .todo   { color: red; }\n  .done   { color: green; }\n  .tag    { background-color: #add8e6; font-weight:normal }\n  .target { }\n  .timestamp { color: #bebebe; }\n  .timestamp-kwd { color: #5f9ea0; }\n  p.verse { margin-left: 3% }\n  pre {\nborder: 1pt solid #AEBDCC;\nbackground-color: #F3F5F7;\npadding: 5pt;\nfont-family: courier, monospace;\n        font-size: 90%;\n        overflow:auto;\n  }\n.slide pre{\nfont-size: 65%\n}\n.src {\n          background-color: #110000;\n          color: #4682b4;\n          font-family: \"DejaVu Sans Mono\", \"Inconsolata\", \"Consolas\", monospace;\n }\n  table { border-collapse: collapse; }\n  td, th { vertical-align: top; }\n  dt { font-weight: bold; }\n  div#content { max-width: 800px; margin: auto; }\n  div.figure { padding: 0.5em; }\n  div.figure p { text-align: center; }\n  .mono { font-family: \"DejaVu Sans Mono\", \"Inconsolata\", \"Consolas\", monospace; font-size: 10pt; }\n  code { background-color: #dfdfdf; font-size: 85%; padding: 0.1em; border-radius: 0.2em;}\n  .linenr { font-size:smaller }\n  .code-highlighted {background-color:#ffff00;}\n  .org-info-js_info-navigation { border-style:none; }\n  table tbody tr:nth-child(even) { background-color: #f0f0f9; }                            white-space:nowrap; }\n  .org-info-js_search-highlight {background-color:#ffff00; color:#000000;\n                                 font-weight:bold; }\n  /*]]>*/-->\n</style>\n"
      org-default-notes-file (expand-file-name "~/bwm/org/work.org")
      org-latex-pdf-process '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
                              "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
                              "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f")
      org-latex-minted-options '(("frame" "lines")
                                 ("fontsize" "\\scriptsize")
                                 ("linenos" ""))
      org-latex-listings 'minted

      org-capture-templates '(("t" "Todo" entry (file+headline "~/org/work.org" "Tasks")
                               "* TODO %?\n  %i\n  %a")
                              ("j" "Journal" entry (file+datetree "~/org/diary.org")
                               "* %?\n%U\n" :clock-in t :clock-resume t)))

(defun bwm:list-all-org (base)
  (delq nil
        (mapcar (lambda (filename)
                  (and (not (string-match "/\.#" filename)) filename))
                (file-expand-wildcards (concat base "/*/*.org")))))

(defun set-agenda-files ()
  (setq org-agenda-files
        (append '("~/org/work.org"
                  "~/org/diary.org")
                (bwm:list-all-org "~/projects")
                (bwm:list-all-org "~/talks/sprints")))
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