(define 
    (problem do-not-die_sword)
    ; The hero luckily finds a sword on their way to the goal, scares a monster away, 
    ; then decides to destroy the sword to free their hands and continue on their way to the goal. 

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