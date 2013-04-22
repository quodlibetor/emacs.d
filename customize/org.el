(setq org-hide-leading-stars t
      org-columns-default-format "%35ITEM(Task) %17Effort(Estimated Effort){:} %CLOCKSUM(Time Spent) %TODO %3PRIORITY %TAGS"
      org-clock-into-drawer t
      org-todo-keywords '((sequence "TODO(t)" "IN-PROGRESS(i)" "|" "DONE(d)")
			  (sequence "NEXT(n)" "|")
			  (sequence "BUG(b)" "|" "FIXED(f)" "WONTFIX(w)"))
      org-log-done 'time
      org-use-speed-commands t
      org-clock-out-remove-zero-time-clocks t
      org-export-html-style "<style type=\"text/css\">\n <!--/*--><![CDATA[/*><!--*/\n  html { font-family: Times, serif; font-size: 12pt; }\n  .title  { text-align: center; }\n  .todo   { color: red; }\n  .done   { color: green; }\n  .tag    { background-color: #add8e6; font-weight:normal }\n  .target { }\n  .timestamp { color: #bebebe; }\n  .timestamp-kwd { color: #5f9ea0; }\n  p.verse { margin-left: 3% }\n  pre {\nborder: 1pt solid #AEBDCC;\nbackground-color: #F3F5F7;\npadding: 5pt;\nfont-family: courier, monospace;\n        font-size: 90%;\n        overflow:auto;\n  }\n.slide pre{\nfont-size: 65%\n}\n.src {\n          background-color: #110000;\n          color: #4682b4;\n          font-family: \"DejaVu Sans Mono\", \"Inconsolata\", \"Consolas\", monospace;\n }\n  table { border-collapse: collapse; }\n  td, th { vertical-align: top; }\n  dt { font-weight: bold; }\n  div#content { max-width: 800px; margin: auto; }\n  div.figure { padding: 0.5em; }\n  div.figure p { text-align: center; }\n  .mono { font-family: \"DejaVu Sans Mono\", \"Inconsolata\", \"Consolas\", monospace; font-size: 10pt; }\n  code { background-color: #dfdfdf; font-size: 85%; padding: 0.1em; border-radius: 0.2em;}\n  .linenr { font-size:smaller }\n  .code-highlighted {background-color:#ffff00;}\n  .org-info-js_info-navigation { border-style:none; }\n  #org-info-js_console-label { font-size:10px; font-weight:bold;\n                               white-space:nowrap; }\n  .org-info-js_search-highlight {background-color:#ffff00; color:#000000;\n                                 font-weight:bold; }\n  /*]]>*/-->\n</style>\n"
      org-default-notes-file "/home/bwm/work.org")

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

(setq jiralib-url "https://jira2.advance.net/")

(let ((load-path (cons ".emacs.d/packages/org-jira" load-path)))
  (require 'org-jira "packages/org-jira/org-jira"))
(require 'org-html5presentation "packages/org-html5presentation/org-html5presentation")

(add-hook 'org-mode-hook
	  (lambda ()
	    (set (make-local-variable 'fill-column) 80)))


;; allow for export=>beamer by placing
;; #+LaTeX_CLASS: beamer in org files

(unless (boundp 'org-export-latex-classes)
  (setq org-export-latex-classes nil))
(add-to-list 'org-export-latex-classes
             ;; beamer class, for presentations
             '("beamer"
               "\\documentclass[11pt]{beamer}\n
      \\mode<{{{beamermode}}}>\n
      \\usetheme{{{{beamertheme}}}}\n
      \\usecolortheme{{{{beamercolortheme}}}}\n
      \\beamertemplateballitem\n
      \\setbeameroption{show notes}
      \\usepackage[utf8]{inputenc}\n
      \\usepackage[T1]{fontenc}\n
      \\usepackage{hyperref}\n
      \\usepackage{color}
      \\usepackage{listings}
      \\lstset{numbers=none,language=[ISO]C++,tabsize=4,
  frame=single,
  basicstyle=\\small,
  showspaces=false,showstringspaces=false,
  showtabs=false,
  keywordstyle=\\color{blue}\\bfseries,
  commentstyle=\\color{red},
  }\n
      \\usepackage{verbatim}\n
      \\institute{{{{beamerinstitute}}}}\n
       \\subject{{{{beamersubject}}}}\n"

               ("\\section{%s}" . "\\section*{%s}")

               ("\\begin{frame}[fragile]\\frametitle{%s}"
                "\\end{frame}"
                "\\begin{frame}[fragile]\\frametitle{%s}"
                "\\end{frame}")))

;; letter class, for formal letters

(add-to-list 'org-export-latex-classes

             '("letter"
               "\\documentclass[11pt]{letter}\n
      \\usepackage[utf8]{inputenc}\n
      \\usepackage[T1]{fontenc}\n
      \\usepackage{color}"

               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
