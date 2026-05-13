(define 
   (problem get_out_unsolvable)

   ; This problem is unsolvable because the hero cannot get to room c without going through room b, 
   ; but room b will be destroyed when the hero goes through it, and the hero needs room b to get back
   ; to the goal. Removing the destruction of room b makes the problem solvable. 

   (:domain the-dungeon)
   (:objects rooma roomb roomc roomd)
   (:init 
        (room rooma)
        (room roomb)
        (room roomc)
        (room roomd)
        (not-destroyed-yet rooma)
        (not-destroyed-yet roomb)
        (not-destroyed-yet roomc)
        (not-destroyed-yet roomd)
        (corridor rooma roomb)
        (corridor roomb rooma)
        (corridor roomb roomc)
        (corridor roomc roomb)
        (corridor roomb roomd)
        (corridor roomd roomb)
        (at-hero rooma)
        
               )
   (:goal (and
      (at-hero roomd)
      (room-visited roomc)
      )))
