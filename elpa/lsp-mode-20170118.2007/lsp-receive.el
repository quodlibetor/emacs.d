;; Copyright (C) 2016  Vibhav Pant <vibhavp@gmail.com>

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

(require 'json)
(require 'cl-lib)
(require 'lsp-common)
(require 'lsp-notifications)

(defconst lsp-debug nil
  "When non-nil, print all non LSP messages from servers to a buffer.")

(defun lsp--json-read-from-string (str)
  "Like json-read-from-string(STR), but arrays are lists, and objects are hash tables."
  (let ((json-array-type 'list)
	(json-object-type 'hash-table)
	(json-false nil))
    (json-read-from-string str)))

(defun lsp--parse-message (body)
  "Read BODY.
Returns the json string in BODY if it is complete.
Else returns nil, and should be called again with the remaining output."
  (let ((completed-read nil)
	(json-body nil)
	(content-length nil)
	(content-type nil))
    (if (string-match "^Content\-Length: \\([0-9]+\\)" body)
	(setq content-length (string-to-number (match-string 1 body)))
      (error "Received body without Content-Length"))
    (when (string-match "Content\-Type: \\(.+\\)\r" body)
      (setq content-type (match-string 1 body)))
    (when (string-match "\r\n\r\n\\(.+\\)" body)
	(setq json-body (setq body (match-string 1 body))))
    (when (not (= (length json-body) content-length))
	(error "Body's length != Content-Length"))
    (lsp--json-read-from-string json-body)))

(defun lsp--get-message-type (params)
  "Get the message type from PARAMS."
  (when (not (string= (gethash "jsonrpc" params "") "2.0"))
    (error "JSON-RPC version is not 2.0"))
  (if (gethash "id" params nil)
      (if (gethash "error" params nil)
	  'response-error
	'response)
    (if (gethash "method" params nil)
	'notification
      (error "Couldn't guess message type from params"))))

(defvar-local lsp--waiting-for-response nil)
(defvar-local lsp--response-result nil)
(defvar-local lsp--queued-notifications nil)

(defsubst lsp--flush-notifications ()
  "Flush any notifications that were queued while processing the last response."
  (let ((el))
    (dolist (el (reverse lsp--queued-notifications))
      (lsp--on-notification el t))
    (setq lsp--queued-notifications nil)))

;; How requests might work:
;; 1 call wrapper around lsp--send-message-sync.
;; 2. the implemented lsp--send-message-sync waits for next message,
;; calls lsp--from-server.
;; 3. lsp--from-server verifies this is the correct response, set the variable
;; lsp--response-result to the `result` field in the response.
;; 4. the wrapper around lsp--send-message-sync returns the value of lsp--response-result.

(defun lsp--on-notification (notification &optional dont-queue)
  "If response queue is empty, call the appropriate handler for NOTIFICATION.
Else it is queued (unless DONT-QUEUE is non-nil)"
  (let ((params (gethash "params" notification)))
    (if (and (not dont-queue) lsp--response-result)
	(push lsp--queued-notifications notification)
      ;; else, call the appropriate handler
      (pcase (gethash "method" notification)
	("window/showMessage" (lsp--window-show-message params))
	("window/logMessage" (lsp--window-show-message params)) ;; Treat as showMessage for now
	("textDocument/publishDiagnostics" (lsp--on-diagnostics params))
	("rustDocument/diagnosticsEnd")
	("rustDocument/diagnosticsBegin")
	("textDocument/diagnosticsEnd")
	("textDocument/diagnosticsBegin")
	(unknown (message "Unknown notification %s" unknown))))))

(defun lsp--set-response (response)
  "Set lsp--response-result as per RESPONSE.
Set lsp--waiting-for-message to nil."
  (setq lsp--response-result (and response (gethash "result" response nil))
	;; no longer waiting for a response.
	lsp--waiting-for-response nil)
  (lsp--flush-notifications))

(defconst lsp--errors
  '((-32700 "Parse Error")
    (-32600 "Invalid Request")
    (-32601 "Method not Found")
    (-32602 "Invalid Parameters")
    (-32603 "Internal Error")
    (-32099 "Server Start Error")
    (-32000 "Server End Error")))

(defun lsp--error-string (err)
  "Format ERR as a user friendly string."
  (let ((code (gethash "code" err))
	(message (gethash "message" err)))
    (lsp--propertize (format "Error from the Language Server: (%s) %s"
			     (car (alist-get code lsp--errors)) message)
		1)))

(defun lsp--from-server (data)
  "Callback for when Emacs recives DATA from client.
If lsp--from-server returns non-nil, the client library must SYNCHRONOUSLY
read the next message from the language server, else asynchronously."
  (let ((parsed (lsp--parse-message data)))
    (when parsed
      (cl-case (lsp--get-message-type parsed)
	('response (lsp--set-response parsed))
	('response-error (lsp--set-response nil)
			 (message "%s" (lsp--error-string
					(gethash "error" parsed)))) ;;TODO
	('notification (lsp--on-notification parsed))))
    lsp--waiting-for-response))

(defvar lsp--process-pending-output (make-hash-table :test 'equal))
(defvar lsp--process-pending-output nil)
(defconst lsp--r-content-length "^Content-Length: .+\r\n"
  "Matches content-length ONLY.")
(defconst lsp--r-content-type "Content-Type: .+\r\n"
  "Matches content-type, DON'T use this as is.")

(defconst lsp--r-content-length-body (concat lsp--r-content-length "\r\n{.*}$")
  "Matches content-length, header end and json body (2 \r\n's).")
(defconst lsp--r-content-length-type-body (concat
					   lsp--r-content-length lsp--r-content-type
					   "\r\n{.*}$")
  "Matches content length, type, header end, and body (3 \r\n's).")
(defconst lsp--r-content-length-body-next (concat "\\("
					   lsp--r-content-length
					   "\r\n{.*}\\)\\(Content.+\\)")
  "Matches content length, header end, body, and parts from the next message.
\(3 \r\n's\)")
(defconst lsp--r-content-length-type-body-next (concat "\\("
						lsp--r-content-length
						"\\(?:" lsp--r-content-type "\\)*"
						"\r\n{.*}\\)\\(Content.+\\)")
  "Matches content length, type, header end, body and parts from next message.")

;; Taken from s.el
(defun lsp--count-matches (regexp str)
  (save-match-data
    (with-temp-buffer
      (insert str)
      (goto-char (point-min))
      (count-matches regexp 1 (point-max)))))

;; FIXME: This is highly inefficient. The same output is being matched *twice*
;; (once here, and in lsp--parse-message the second time.)
(defun lsp--process-filter (proc output)
  "Process filter for language servers.
PROC is the process.
OUTPUT is the output received from the process"
  ;; (message (format "[%s]" output))
  (let ((pending (gethash proc lsp--process-pending-output nil))
	(complete)
	(rem-pending)
	(next))
    (puthash proc (setq output (concat pending output)) lsp--process-pending-output)
    (cl-case (lsp--count-matches "\r\n" output)
      ;; will never be zero
      (2 (when (string-match lsp--r-content-length-body output)
	   (setq complete t
	       rem-pending t)))
      (3 (if (string-match lsp--r-content-length-type-body output)
	     (setq complete t
		   rem-pending t)
	   (when (string-match lsp--r-content-length-body-next output)
	     (puthash proc (substring output
				      (match-beginning 2)
				      (length output))
		      lsp--process-pending-output)
	     (setq output (match-string 1 output)
		   complete t
		   next t))))
      ;; >= 4
      (t (when (string-match lsp--r-content-length-type-body-next output)
	   (puthash proc (substring output
				    (match-beginning 2)
				    (length output))
		    lsp--process-pending-output)
	   (setq output (match-string 1 output))
	   (setq complete t
		 next t))))
    (when rem-pending
      (remhash proc lsp--process-pending-output))
    (while (and complete (lsp--from-server output))
      (with-local-quit
	(accept-process-output proc)))
    (when next
      ;; stuff from the next response/notification was in this outupt.
      ;; try parsing it to see if it was a complete message.
      (lsp--process-filter proc ""))
    ;; (message (format "complete %s rem-pending %s next %s" complete rem-pending next))
    (when (and (not (or rem-pending complete next))) ;; got non LSP output
      (with-current-buffer (get-buffer-create (format "%s output"
						      (process-name proc)))
	(insert output)
	(goto-char (point-max))))
    (when lsp--waiting-for-response
      (with-local-quit (accept-process-output proc)))))

(provide 'lsp-receive)
;;; lsp-callback.el ends here
