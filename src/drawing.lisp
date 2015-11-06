
(in-package #:cl-pygames)

(defparameter *black* `(0 0 0 255))
(defparameter *white* `(255 255 255 255))
(defparameter *red* `(255 0 0 255))
(defparameter *green* `(0 255 0 255))
(defparameter *blue* `(0 0 255 255))

(defun launch-drawing-game ()
  "Just open a window with a title and some handlers bound"
  (with-init (:everything)
    (with-window (win :title "Drawing" :w 400 :h 300)
      (with-renderer (rend win)
	(apply #'set-render-draw-color `(,rend ,@*white*))
	(render-clear rend)
	(apply #'set-render-draw-color `(,rend ,@*blue*))
	(render-draw-line rend 60 60 120 60)
	(apply #'set-render-draw-color `(,rend ,@*red*))
	(render-draw-rect rend (make-rect 200 150 100 50))
	;; circles and ellipses are not supported (maybe, they still are supported by OpenGL, I dunno
	(render-present rend)
	(with-event-loop (:method :poll)
	  (:keyup
	   (:keysym keysym)
	   (when (sdl2:scancode= (sdl2:scancode-value keysym) :scancode-escape)
	     (sdl2:push-event :quit)))
	  (:quit () t))))))
