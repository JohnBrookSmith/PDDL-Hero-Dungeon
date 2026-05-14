(define 
    (problem do-not-die_no-sword)
    ; This problem is unsolvable because the hero needs to go 
    ; through a room with a monster to get to the goal, but there is no sword available. 

    (:domain monster-monster)
   (:objects 
          rooma roomb roomc roomd - room
          monster1 - monster          
   )
   (:init (place rooma)
          (place roomb)
          (place roomc)
          (place roomd)
          (corridor rooma roomb)
          (corridor roomb roomc)
          (corridor roomc roomd)
          (at-monster roomc monster1)
          (hands-free)
          (at-hero rooma)
       )

   (:goal (at-hero roomd))
)
