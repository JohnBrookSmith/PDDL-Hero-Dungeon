(define 
    (problem do-not-die_avoidance)
       ; This problem is solvable by avoiding the monster, but not by going through the room with the monster.
    
    (:domain monster-monster)
   (:objects 
          rooma roomb roomc roomd roome roomf - room
          monster1 - monster
          sword1 - sword      
   )
   (:init (place rooma)
          (place roomb)
          (place roomc)
          (place roomd)
          (place roome)
          (place roomf)
          (corridor rooma roomb)
          (corridor roomb roomc)
          (corridor roomc roomd)
          (corridor roomb roome)
          (corridor roome roomf)
          (corridor roomf roomd)
          (at-monster roomc monster1)
          (hands-free)
          (at-hero rooma)
   )

   (:goal (at-hero roomd))
)
