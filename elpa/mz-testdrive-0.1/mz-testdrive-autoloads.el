;;; mz-testdrive-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "mz-testdrive" "mz-testdrive.el" (0 0 0 0))
;;; Generated autoloads from mz-testdrive.el

(setq poly-mztd-subsec-end (rx (or (seq line-start (not whitespace)) "\n\n")))

(define-innermode poly-mztd-sql-innermode :mode 'sql-mode :head-matcher (rx (seq line-start (or ">" "!") " ")) :tail-matcher poly-mztd-subsec-end :head-mode 'host :tail-mode 'host)

(define-innermode poly-mztd-set-json-innermode :mode 'json-mode :head-matcher (rx "set " (+ word) "=") :tail-matcher poly-mztd-subsec-end :head-mode 'host :tail-mode 'host)

(define-auto-innermode poly-mztd-file-contents-innermode :head-matcher (rx line-start "$ file-append") :tail-matcher "\n\n" :mode-matcher (cons (rx "path=" (+ word) "." (group (+ word))) 1) :head-mode 'host :tail-mode 'host)

(define-innermode poly-mztd-line-delimited-json-innermode :mode 'json-mode :head-matcher (rx line-start "{") :tail-matcher (rx "}" line-end) :head-mode 'host :tail-mode 'host)

(define-hostmode poly-mztd-hostmode :mode 'shell-script-mode)

(defvar poly-mz-testdrive-mode-hook nil "\
hooks that are run for `mz-testdrive-mode' and all submodes")

(define-polymode mz-testdrive-mode :hostmode 'poly-mztd-hostmode :innermodes '(poly-mztd-sql-innermode poly-mztd-set-json-innermode poly-mztd-line-delimited-json-innermode poly-mztd-file-contents-innermode))

(autoload 'mz-testdrive-enable "mz-testdrive" "\
Enable mz-testdrive mode for all files that end in \\.td, and configure some sub-modes" nil nil)

;;;***

;;;### (autoloads nil nil ("mz-testdrive-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; mz-testdrive-autoloads.el ends here
