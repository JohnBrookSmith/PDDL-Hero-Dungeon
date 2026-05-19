(define 
    (problem disarm-the-trap_destory_the_sword)
    (:domain it-is-a-trap)
       ; The hero finds a trap in the middle of the path to the goal,
       ; they also find a sword that they want to pick up, only to destory
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
          (hands-free)
          (at-hero rooma)
          (at-sword roomb sword1)
          (at-trap roomc trap1)
          (with-trap roomc)
          (sword-not-destroyed-yet sword1)

       )

   (:goal (and
          (at-hero roomd)
          (not (sword-not-destroyed-yet sword1))    
       )
   )

)