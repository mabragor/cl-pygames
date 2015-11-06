;;;; cl-pygames.asd

(asdf:defsystem #:cl-pygames
  :description "Port of games from the book 'Making Games with Python & Pygame'"
  :author "Alexandr Popolitov <popolit@gmail.com>"
  :version "0.1"
  :license "MIT???" ;; I honestly don't know how the code of the book is licenced
  :serial t
  :depends-on (#:sdl2)
  :components ((:module "src"
			:pathname "src/"
			:serial t
			:components ((:file "package")
				     (:file "blankgame")
				     (:file "drawing")
				     (:file "catanimation")
				     (:file "memorypuzzle")
				     (:file "slidepuzzle")
				     (:file "simulate")
				     (:file "wormy")
				     (:file "tetromino")
				     (:file "squirrel")
				     (:file "starpusher")
				     (:file "flippy")
				     (:file "inkspill")
				     (:file "fourinarow")
				     (:file "gemgem")))))

