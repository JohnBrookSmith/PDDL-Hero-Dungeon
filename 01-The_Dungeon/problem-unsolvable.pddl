(define 
   (problem get_out_unsolvable)

   ; This problem is unsolvable because the hero cannot get to room c without going through room b, 
   ; but room b will be destroyed when the hero goes through it, and the hero needs room b to get back
   ; to the goal. Removing the destruction of room b makes the problem solvable. 

   (:domain the-dungeon)
   (:objects rooma roomb roomc roomd)
   (:init 
        (place rooma)
        (place roomb)
        (place roomc)
        (place roomd)
        (place-not-destroyed-yet rooma)
        (place-not-destroyed-yet roomb)
        (place-not-destroyed-yet roomc)
        (place-not-destroyed-yet roomd)
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
      (place-visited roomc)
      )))
