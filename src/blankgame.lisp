
(in-package #:cl-pygames)

(defun launch-blank-game ()
  "Just open a window with a title and some handlers bound"
  (with-init (:everything)
    (with-window (win :title "Hello CL-PYGAMES World!" :flags '(:shown))
      (with-event-loop (:method :poll)
	(:keyup
	 (:keysym keysym)
	 (when (sdl2:scancode= (sdl2:scancode-value keysym) :scancode-escape)
	   (sdl2:push-event :quit)))
	(:quit () t)))))
