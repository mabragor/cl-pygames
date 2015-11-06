
(in-package #:cl-pygames)

(defparameter *white* '(255 255 255 255))
(defparameter *black* '(0 0 0 255))

(defparameter *fps* 60)

(defun %load-bmp (fname)
  (sdl2::check-null (load-bmp fname)))

(defun mk-delta-t ()
  (let ((prev (get-ticks)))
    (lambda ()
      (let* ((new (get-ticks))
	     (delta (- new prev)))
	(setf prev new)
	delta))))

(defun launch-catanimation ()
  "The cat image moving across the window"
  (with-init (:everything)
    (with-window (win :title "Animation" :w 400 :h 300)
      (with-renderer (rend win)
	(let ((penguin (create-texture-from-surface rend (%load-bmp "/home/popolit/quicklisp/local-projects/cl-pygames/mushroom.bmp")))
	      (pen-x 10)
	      (pen-y 10)
	      (direction :right)
	      (fps-cap t)
	      (delta-t (mk-delta-t)))
	  (with-event-loop (:method :poll)
	    (:idle ()
		   (apply #'set-render-draw-color `(,rend ,@*white*))
		   (render-clear rend)
		   (cond ((eq :right direction) (progn (incf pen-x 5)
						       (if (= 280 pen-x)
							   (setf direction :down))))
			 ((eq :down direction) (progn (incf pen-y 5)
						      (if (= 220 pen-y)
							  (setf direction :left))))
			 ((eq :left direction) (progn (decf pen-x 5)
						      (if (= 10 pen-x)
							  (setf direction :up))))
			 ((eq :up direction) (progn (decf pen-y 5)
						    (if (= 10 pen-y)
							(setf direction :right)))))
		   (apply #'set-render-draw-color `(,rend ,@*black*))
		   (render-copy rend penguin :dest-rect (make-rect pen-x pen-y 50 50))
		   (render-present rend)
		   (if fps-cap
		       (let ((dt (funcall delta-t)))
			 (if (< dt (/ 1000 *fps*))
			     (delay (floor (- (/ 1000 *fps*) dt)))))))
	    (:keyup (:keysym keysym)
	     (when (sdl2:scancode= (sdl2:scancode-value keysym) :scancode-escape)
	       (sdl2:push-event :quit))
	     (when (sdl2:scancode= (sdl2:scancode-value keysym) :scancode-t)
	       (setf fps-cap (not fps-cap)))
	     (when (sdl2:scancode= (sdl2:scancode-value keysym) :scancode-equals)
	       (incf *fps* 5))
	     (when (sdl2:scancode= (sdl2:scancode-value keysym) :scancode-minus)
	       (decf *fps* 5)))
	    (:quit () t)))))))

		    
