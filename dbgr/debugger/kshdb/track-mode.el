;;; "kshdb" Debugger tracking a comint or eshell buffer.

(eval-when-compile (require 'cl))
(require 'load-relative)
(require-relative-list '(
			 "../../common/cmds" 
			 "../../common/menu"
			 "../../common/track"
			 "../../common/track-mode"
			 ) 
		       "dbgr-")
(require-relative-list '("core" "cmds" "init") "dbgr-kshdb-")

(dbgr-track-mode-vars "kshdb")
(set-keymap-parent kshdb-track-mode-map dbgr-track-mode-map)

(declare-function dbgr-track-mode(bool))

(define-key kshdb-track-mode-map 
  (kbd "C-c !!") 'kshdb-goto-dollarbang-backtrace-line)
(define-key kshdb-track-mode-map 
  (kbd "C-c !b") 'kshdb-goto-backtrace-line)
(define-key kshdb-track-mode-map 
  (kbd "C-c !c") 'kshdb-goto-control-frame-line)
(define-key kshdb-track-mode-map 
  (kbd "C-c !c") 'kshdb-goto-control-frame-line)

(defun kshdb-track-mode-hook()
  (if kshdb-track-mode
      (progn
	(use-local-map kshdb-track-mode-map)
	(message "using kshdb mode map")
	)
    (message "kshdb track-mode-hook disable called"))
)

(define-minor-mode kshdb-track-mode
  "Minor mode for tracking ruby debugging inside a process shell."
  :init-value nil
  ;; :lighter " kshdb"   ;; mode-line indicator from dbgr-track is sufficient.
  ;; The minor mode bindings.
  :global nil
  :group 'kshdb
  :keymap kshdb-track-mode-map

  (dbgr-track-set-debugger "kshdb")
  (if kshdb-track-mode
      (progn 
	(dbgr-track-mode 't)
	(run-mode-hooks (intern (kshdb-track-mode-hook))))
    (progn 
      (dbgr-track-mode nil)
      ))
)

(provide-me "dbgr-kshdb-")