;;; Copyright (C) 2013 Rocky Bernstein <rocky@gnu.org>
;;; Golang SSA gub tracking a comint or eshell buffer.

(eval-when-compile (require 'cl))
(require 'load-relative)
(require-relative-list '(
			 "../../common/cmds"
			 "../../common/menu"
			 "../../common/track"
			 "../../common/track-mode"
			 )
		       "realgud-")
(require-relative-list '("core" "init") "realgud-gub-")

(realgud-track-mode-vars "gub")

(declare-function realgud-track-mode(bool))

(defun realgud-gub-goto-location (pt)
  "Display the location mentioned in a location
described by PT."
  (interactive "d")
  (realgud-goto-line-for-pt pt "location"))


(define-key gub-track-mode-map
  (kbd "C-c !!") 'realgud-goto-lang-backtrace-line)
(define-key gub-track-mode-map
  (kbd "C-c !b") 'realgud-goto-debugger-backtrace-line)
(define-key gub-track-mode-map
  (kbd "C-c !s") 'realgud-gub-goto-location)


(defun gub-track-mode-hook()
  (if gub-track-mode
      (progn
	(use-local-map gub-track-mode-map)
	(message "using gub mode map")
	)
    (message "gub track-mode-hook disable called"))
)

(define-minor-mode gub-track-mode
  "Minor mode for tracking ruby debugging inside a process shell."
  :init-value nil
  ;; :lighter " gub"   ;; mode-line indicator from realgud-track is sufficient.
  ;; The minor mode bindings.
  :global nil
  :group 'gub
  :keymap gub-track-mode-map

  (realgud-track-set-debugger "gub")
  (if gub-track-mode
      (progn
	(setq realgud-track-mode 't)
        (realgud-track-mode-setup 't)
        (gub-track-mode-hook))
    (progn
      (setq realgud-track-mode nil)
      ))
)

(provide-me "realgud-gub-")
