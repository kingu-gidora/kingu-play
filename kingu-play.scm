#!/usr/local/bin/gosh

(use gauche.process)
(use text.console)

(define loop
  (lambda (term pid)
    (let ((ui (getch term)))
      (print ui)
      (loop term pid)
    )))

(define main
  (lambda (args)
    (let ((proc (run-process '(cvlc http://stream.streamaudio.de:8000/kingus-broadcast)
			     :redirects '((>& 2 1) (> 1 out))))
	  (term (make-default-console)))
      (reset-terminal term)
      (with-character-attribute term '(cyan #f) (lambda ()(putstr term (format #f "Starting Kingu's channel... (pid: ~a)\nType ctrl-C to quit." (process-pid proc)))))

      (loop term (process-pid proc)))))
