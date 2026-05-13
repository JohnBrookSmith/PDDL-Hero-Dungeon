(define 
    (problem do-not-die_sword)
    ; This problem is unsolvable because the hero needs to go 
    ; through a room with a monster to get to the goal, but there is no sword available. 

    (:domain monster-monster)
    (:requirements :negative-preconditions)
   (:objects 
          rooma roomb roomc roomd - room
          sword - sword
          monster1 - monster
   )
   (:init (place rooma)
          (place roomb)
          (place roomc)
          (place roomd)
          (corridor rooma roomb)
          (corridor roomb roomc)
          (corridor roomc roomd)
          (sword sword)
          (sword-not-destroyed-yet sword)
          (at-sword roomb sword)
          (hands-free)
          (at-hero rooma)
          (at-monster roomc monster1)
  
       )

   (:goal (and
          (at-hero roomd)
          (not(sword-not-destroyed-yet sword))
          )
          
   )

)