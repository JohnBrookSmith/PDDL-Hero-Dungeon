(define 
    (problem disarm-the-trap)
    (:domain it-is-a-trap)
    ; The hero finds a trap in the middle of the path to the goal,
    ; they must disarm the trap to continue on their way to the goal.
    
   (:objects 
          rooma roomb roomc roomd - room
          trap1 - trap
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
          (at-hero rooma)
          (at-trap roomc trap1)
          (with-trap roomc)
          
       )

   (:goal (at-hero roomd))

)