;;; find-file-in-project-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "find-file-in-project" "find-file-in-project.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from find-file-in-project.el

(autoload 'ffip-git-diff-current-file "find-file-in-project" "\
Run 'git diff version:current-file current-file'.\n\n(fn)" nil nil)

(autoload 'ffip-copy-without-change "find-file-in-project" "\
Copy P without change.\n\n(fn P)" nil nil)

(autoload 'ffip-copy-reactjs-import "find-file-in-project" "\
Create ReactJS link from P and copy the result.\n\n(fn P)" nil nil)

(autoload 'ffip-copy-org-file-link "find-file-in-project" "\
Create org link from P and copy the result.\n\n(fn P)" nil nil)

(defvar ffip-find-relative-path-callback 'ffip-copy-without-change "\
The callback after calling `find-relative-path'.")

(autoload 'ffip-project-root "find-file-in-project" "\
Return the root of the project.\n\n(fn)" nil nil)

(autoload 'ffip-save-ivy-last "find-file-in-project" "\
Save `ivy-last' into `ffip-ivy-last-saved'.  Requires ivy.\n\n(fn)" t nil)

(autoload 'ffip-get-project-root-directory "find-file-in-project" "\
Get the full path of project root directory.\n\n(fn)" nil nil)

(autoload 'ffip-ivy-resume "find-file-in-project" "\
Wrapper of `ivy-resume'.  Resume the search saved at `ffip-ivy-last-saved'.\n\n(fn)" t nil)

(autoload 'ffip-filename-identity "find-file-in-project" "\
Return identical KEYWORD.\n\n(fn KEYWORD)" nil nil)

(autoload 'ffip-filename-camelcase-to-dashes "find-file-in-project" "\
Convert KEYWORD from camel cased to dash seperated.\nIf CHECK-ONLY is true, only do the check.\n\n(fn KEYWORD &optional CHECK-ONLY)" nil nil)

(autoload 'ffip-filename-dashes-to-camelcase "find-file-in-project" "\
Convert KEYWORD from dash seperated to camel cased.\nIf CHECK-ONLY is true, only do the check.\n\n(fn KEYWORD &optional CHECK-ONLY)" nil nil)

(autoload 'ffip-completing-read "find-file-in-project" "\
Read a string in minibuffer, with completion.\n\nPROMPT is a string with same format parameters in `ido-completing-read'.\nCOLLECTION is a list of strings.\n\nACTION is a lambda function to call after selecting a result.\n\nThis function returns the selected candidate or nil.\n\n(fn PROMPT COLLECTION &optional ACTION)" nil nil)

(autoload 'ffip-project-search "find-file-in-project" "\
Return an alist of all filenames in the project and their path.\n\nFiles with duplicate filenames are suffixed with the name of the\ndirectory they are found in so that they are unique.\n\nIf KEYWORD is string, it's the file name or file path to find file.\nIf KEYWORD is list, it's the list of file names.\nIF IS-FINDING-DIRECTORY is t, we are searching directories, else files.\nDIRECTORY-TO-SEARCH specify the root directory to search.\n\n(fn KEYWORD IS-FINDING-DIRECTORY &optional DIRECTORY-TO-SEARCH)" nil nil)

(autoload 'ffip-find-files "find-file-in-project" "\
Use KEYWORD to find files.\nIf OPEN-ANOTHER-WINDOW is t, the results are displayed in a new window.\nIf FIND-DIRECTORY is t, only search directories.  FN is callback.\nThis function is the API to find files.\n\n(fn KEYWORD OPEN-ANOTHER-WINDOW &optional FIND-DIRECTORY FN)" nil nil)

(autoload 'ffip-create-project-file "find-file-in-project" "\
Create or Append .dir-locals.el to set up per directory.\nYou can move .dir-locals.el to root directory.\nSee (info \"(Emacs) Directory Variables\") for details.\n\n(fn)" t nil)

(autoload 'ffip-current-full-filename-match-pattern-p "find-file-in-project" "\
Is current full file name (including directory) match the REGEX?\n\n(fn REGEX)" nil nil)

(autoload 'find-file-in-project "find-file-in-project" "\
More powerful and efficient `find-file-in-project-by-selected' is recommended.\n\nPrompt with a completing list of all files in the project to find one.\nIf OPEN-ANOTHER-WINDOW is not nil, the file will be opened in new window.\nThe project's scope is defined as the first directory containing\na `ffip-project-file' whose value is \".git\" by default.\nYou can override this by setting the variable `ffip-project-root'.\n\n(fn &optional OPEN-ANOTHER-WINDOW)" t nil)

(autoload 'find-file-in-project-at-point "find-file-in-project" "\
Find file whose name is guessed around point.\nIf OPEN-ANOTHER-WINDOW is not nil, the file will be opened in new window.\n\n(fn &optional OPEN-ANOTHER-WINDOW)" t nil)

(autoload 'find-file-in-current-directory "find-file-in-project" "\
Like `find-file-in-project'.  But search only in current directory.\nIF OPEN-ANOTHER-WINDOW is t, results are displayed in new window.\n\n(fn &optional OPEN-ANOTHER-WINDOW)" t nil)

(autoload 'find-file-in-project-by-selected "find-file-in-project" "\
Same as `find-file-in-project' but more poweful and efficient.\nIt use string from selected region to search files in the project.\nIf no region is selected, you could provide a keyword.\n\nKeyword could be ANY part of the file's full path and support wildcard.\nFor example, to find /home/john/proj1/test.js, below keywords are valid:\n- test.js\n- roj1/tes\n- john*test\n\nIf keyword contains line number like \"hello.txt:32\" or \"hello.txt:32:\",\nwe will move to that line in opened file.\n\nIf keyword is empty, it behaves same as `find-file-in-project'.\n\nIf OPEN-ANOTHER-WINDOW is not nil, the file will be opened in new window.\n\n(fn &optional OPEN-ANOTHER-WINDOW)" t nil)

(autoload 'find-file-with-similar-name "find-file-in-project" "\
Use base name of current file as keyword which could be further stripped.\nby `ffip-strip-file-name-regex'.\nIf OPEN-ANOTHER-WINDOW is not nil, the file will be opened in new window.\n\n(fn &optional OPEN-ANOTHER-WINDOW)" t nil)

(autoload 'find-file-in-current-directory-by-selected "find-file-in-project" "\
Like `find-file-in-project-by-selected' but search current directory.\nIf OPEN-ANOTHER-WINDOW is not nil, the file will be opened in new window.\n\n(fn &optional OPEN-ANOTHER-WINDOW)" t nil)

(autoload 'find-relative-path "find-file-in-project" "\
Find file/directory and copy its relative path into `kill-ring'.\nOptional prefix FIND-DIRECTORY copy the directory path; file path by default.\n\nYou can set `ffip-find-relative-path-callback' to format the string before copying,\n  (setq ffip-find-relative-path-callback 'ffip-copy-reactjs-import)\n  (setq ffip-find-relative-path-callback 'ffip-copy-org-file-link)\n\n(fn &optional FIND-DIRECTORY)" t nil)

(autoload 'find-directory-in-project-by-selected "find-file-in-project" "\
Similar to `find-file-in-project-by-selected'.\nUse string from selected region to find directory in the project.\nIf no region is selected, you need provide keyword.\n\nKeyword could be directory's base-name only or parent-directoy+base-name\nFor example, to find /home/john/proj1/test, below keywords are valid:\n- test\n- roj1/test\n- john*test\n\nIf OPEN-ANOTHER-WINDOW is not nil, the file will be opened in new window.\n\n(fn &optional OPEN-ANOTHER-WINDOW)" t nil)

(defalias 'ffip 'find-file-in-project)

(autoload 'ffip-split-window-horizontally "find-file-in-project" "\
Find&Open file in horizontal split window.\nNew window size is looked up in `ffip-window-ratio-alist' by RATIO.\nKeyword to search new file is selected text or user input.\n\n(fn &optional RATIO)" t nil)

(autoload 'ffip-split-window-vertically "find-file-in-project" "\
Find&Open file in vertical split window.\nNew window size is looked up in `ffip-window-ratio-alist' by RATIO.\nKeyword to search new file is selected text or user input.\n\n(fn &optional RATIO)" t nil)

(autoload 'ffip-diff-quit "find-file-in-project" "\
Quit.\n\n(fn)" t nil)

(autoload 'ffip-diff-find-file "find-file-in-project" "\
File file(s) in current hunk.\nIf OPEN-ANOTHER-WINDOW is not nil, the file will be opened in new window.\n\n(fn &optional OPEN-ANOTHER-WINDOW)" t nil)

(autoload 'ffip-show-diff-internal "find-file-in-project" "\
Show the diff output by excuting selected `ffip-diff-backends'.\nNUM is the index selected backend from `ffip-diff-backends'.\nNUM is zero based whose default value is zero.\n\n(fn &optional NUM)" t nil)

(autoload 'ffip-show-diff-by-description "find-file-in-project" "\
Show the diff output by excuting selected `ffip-diff-backends.\nNUM is the backend index of `ffip-diff-backends'.\nIf NUM is not nil, the corresponding backend is executed directly.\n\n(fn &optional NUM)" t nil)

(autoload 'ffip-diff-apply-hunk "find-file-in-project" "\
Apply current hunk in `diff-mode'.  Try to locate the file to patch.\nSimilar to `diff-apply-hunk' but smarter.\nPlease read documenation of `diff-apply-hunk' to get more details.\nIf REVERSE is t, applied patch is reverted.\n\n(fn &optional REVERSE)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "find-file-in-project" '("ffip-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; find-file-in-project-autoloads.el ends here
