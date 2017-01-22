(require 'dash)

(require 'org)
(require 'ox-latex)
(require 'ox-s5)
(require 'ox-confluence)
(require 'org-capture)
(require 'ob-plantuml)
(require 'ox-reveal "packages/org-reveal/ox-reveal.el")

;; active Org-babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '(;; other Babel languages
   (plantuml . t)
   (dot . t)))

(defun toggle-babel-evaluate ()
  (interactive)
  (if org-export-babel-evaluate
      (progn
        (setq org-export-babel-evaluate nil)
        (message "Babel evaluate set to nil"))
    (setq org-export-babel-evaluate t)
    (message "Babel evaluate set to t")))

;; set plantuml jar path for linux or homebrew
(let* ((maybe-jars (-map 'expand-file-name
                         '("~/.local/lib/plantuml.jar"
                           "/usr/local/Cellar/plantuml/8041/plantuml.8041.jar"
                           "/usr/local/Cellar/plantuml/7999/plantuml.7999.jar")))
      (jars (-filter 'file-exists-p maybe-jars)))
  (if jars
      (setq org-plantuml-jar-path (car jars))
    (warn "plantuml is not installed [%s do not exist]" maybe-jars)))

(add-to-list
 'org-src-lang-modes '("plantuml" . puml))
(add-to-list
 'org-src-lang-modes '("dot" . graphviz-dot))

(setq org-hide-leading-stars t
      org-columns-default-format "%35ITEM(Task) %17Effort(Estimated Effort){:} %CLOCKSUM(Time Spent) %TODO %3PRIORITY %TAGS"
      org-clock-into-drawer t
      org-todo-keywords '((sequence "TODO(t)" "IN-PROGRESS(i)" "|" "DONE(d)")
			  (sequence "NEXT(n)" "|")
			  (sequence "BUG(b)" "|" "FIXED(f)" "WONTFIX(w)")
                          (sequence "TO-SCHEDULE(s)" "|" "JIRAd(j)")
                          )
      org-confirm-babel-evaluate nil
      org-log-done 'time
      org-use-speed-commands t
      org-clock-out-remove-zero-time-clocks t
      org-src-fontify-natively t
      org-html-head "<style type=\"text/css\">
 <!--/*--><![CDATA[/*><!--*/
  html { font-family: Times, serif; font-size: 12pt; }
  .title  { text-align: center; }
  .todo   { color: red; }
  .done   { color: green; }
  .tag    { background-color: #add8e6; font-weight:normal }
  .target { }
  .timestamp { color: #bebebe; }
  .timestamp-kwd { color: #5f9ea0; }
  p.verse { margin-left: 3% }
  pre {
    border: 1pt solid #AEBDCC;
    background-color: #F3F5F7;
    padding: 5pt;
    font-family: courier, monospace;
    font-size: 90%;
    overflow:auto;
  }
  .slide pre{
    font-size: 65%
  }
  .src {
    background-color: #110000;
    color: #4682b4;
    font-family: \"DejaVu Sans Mono\", \"Inconsolata\", \"Consolas\", monospace;
  }
  table { border-collapse: collapse; }
  td, th { vertical-align: top; }
  dt { font-weight: bold; }
  div#content { max-width: 800px; margin: auto; }
  div.figure { padding: 0.5em; }
  div.figure p { text-align: center; }
  .mono { font-family: \"DejaVu Sans Mono\", \"Inconsolata\", \"Consolas\", monospace; font-size: 10pt; }
  code { background-color: #dfdfdf; font-size: 85%; padding: 0.1em; border-radius: 0.2em; }
  .linenr { font-size:smaller }
  .code-highlighted { background-color:#ffff00; }
  .org-info-js_info-navigation { border-style:none; }
  table tbody tr:nth-child(even) { background-color: #f0f0f9; }
  white-space: nowrap;
  .org-info-js_search-highlight {
    background-color:#ffff00;
    color:#000000;
    font-weight:bold; }
  /*]]>*/-->
</style>
"
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
                               "* %?\n%U\n" :clock-in t :clock-resume t)
                              ("a" "Alexandria" entry (file+headline "~/org/work.org" "Alexandria")
                               "* %?    :alexandria:fixes:\n  %a")))

(defun bwm:list-all-org (base)
  (delq nil
        (mapcar (lambda (filename)
                  (and (not (string-match "/\.#" filename)) filename))
                (file-expand-wildcards (concat base "/*/*.org")))))

(defun set-agenda-files ()
  (setq org-agenda-files
        (append '("~/org")
                (bwm:list-all-org "~/org")
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
(require 'org-export-as-s5)

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
