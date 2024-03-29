;; Copyright (c) 2012 Brandon W Maister
;;
;; Permission is hereby granted, free of charge, to any person obtaining
;; a copy of this software and associated documentation files (the
;; "Software"), to deal in the Software without restriction, including
;; without limitation the rights to use, copy, modify, merge, publish,
;; distribute, sublicense, and/or sell copies of the Software, and to
;; permit persons to whom the Software is furnished to do so, subject to
;; the following conditions:
;;
;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.
;;
;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
;; LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
;; OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
;; WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

;; This code is based on hg-tools.el, which in turn is based on bzr-tools.el
;; Copyright (c) 2008-2012 Jonathan Lange, Matthew Lefkowitz, Barry A. Warsaw

(provide 'git-tools)

(defconst git-tools-grep-command
  "git ls-files -z %s | xargs -0 grep -in %s"
  "The command used for grepping files using git. See `git-tools-grep'.")

;; Run 'code' at the root of the branch which dirname is in.
(defmacro git-tools-at-branch-root (dirname &rest code)
  `(let ((default-directory (locate-dominating-file (expand-file-name ,dirname) ".git"))) ,@code))


(defun git-tools-grep (expression dirname)
  "Search a branch for `expression'. If there's a C-u prefix, prompt for `dirname'."
  (interactive
   (let* ((search-string (read-string "Search for: "))
          (search-dir (if (null current-prefix-arg)
                          (expand-file-name (locate-dominating-file default-directory ".git"))
                        (read-directory-name (format "Search for %s in: " search-string)))))
     (list search-string search-dir)))
  (git-tools-at-branch-root dirname
   (grep-find (format git-tools-grep-command
                      (shell-quote-argument dirname)
                      (shell-quote-argument expression)))))
