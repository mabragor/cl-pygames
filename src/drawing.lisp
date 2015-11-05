
(in-package #:cl-pygames)

import pygame, sys
from pygame.locals import *

pygame.init()

# set up the window
DISPLAYSURF = pygame.display.set_mode((400, 300), 0, 32)
pygame.display.set_caption('Drawing')

# set up the colors
BLACK = (  0,   0,   0)
WHITE = (255, 255, 255)
RED   = (255,   0,   0)
GREEN = (  0, 255,   0)
BLUE  = (  0,   0, 255)

# draw on the surface object
DISPLAYSURF.fill(WHITE)
pygame.draw.polygon(DISPLAYSURF, GREEN, ((146, 0), (291, 106), (236, 277), (56, 277), (0, 106)))
pygame.draw.line(DISPLAYSURF, BLUE, (60, 60), (120, 60), 4)
pygame.draw.line(DISPLAYSURF, BLUE, (120, 60), (60, 120))
pygame.draw.line(DISPLAYSURF, BLUE, (60, 120), (120, 120), 4)
pygame.draw.circle(DISPLAYSURF, BLUE, (300, 50), 20, 0)
pygame.draw.ellipse(DISPLAYSURF, RED, (300, 200, 40, 80), 1)
pygame.draw.rect(DISPLAYSURF, RED, (200, 150, 100, 50))

pixObj = pygame.PixelArray(DISPLAYSURF)
pixObj[380][280] = BLACK
pixObj[382][282] = BLACK
pixObj[384][284] = BLACK
pixObj[386][286] = BLACK
pixObj[388][288] = BLACK
del pixObj

# run the game loop
while True:
for event in pygame.event.get():
if event.type == QUIT:
pygame.quit()
sys.exit()
    pygame.display.update()

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
	(render-present rend)
	(with-event-loop (:method :poll)
	  (:keyup
	   (:keysym keysym)
	   (when (sdl2:scancode= (sdl2:scancode-value keysym) :scancode-escape)
	     (sdl2:push-event :quit)))
	  (:quit () t))))))
