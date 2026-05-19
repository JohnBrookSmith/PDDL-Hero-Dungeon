(define 
    (problem do-not-die_sword)
    ; The hero luckily finds a sword on their way to the goal, scares a monster away, 
    ; then decides to destroy the sword to free their hands and continue on their way to the goal. 

    (:domain monster-monster)
   (:objects 
          rooma roomb roomc roomd - room
          sword1 - sword
          monster1 - monster
   )
   (:init (place rooma)
          (place roomb)
          (place roomc)
          (place roomd)
          (corridor rooma roomb)
          (corridor roomb roomc)
          (corridor roomc roomd)
          (sword-not-destroyed-yet sword1)
          (at-sword roomb sword1)
          (at-hero rooma)
          (at-monster roomc monster1)
       )

   (:goal (and
          (at-hero roomd)
          (not(sword-not-destroyed-yet sword1))
          )
          
   )

)