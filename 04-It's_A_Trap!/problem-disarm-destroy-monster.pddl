(define 
    (problem disarm-the-trap_destroy_the_sword_and_avoid_the_monster)
    (:domain it-is-a-trap)
       ; The hero finds a trap in the middle of the path to the goal,
       ; they also find a sword that they want to pick up, only to destroy it,
       ; but there is also a monster to avoid AND a trap to disarm, 
       ; the order of these actions make this unsolvable.
   (:objects 
          rooma roomb roomc roomd roome - room
          trap1 - trap
          sword1 - sword
          monster1 - monster
   )
   (:init (place rooma)
          (place roomb)
          (place roomc)
          (place roomd)
          (place roome)   
          (corridor rooma roomb)
          (corridor roomb roomc)
          (corridor roomc roomd)
          (corridor roomd roome)
          (at-hero rooma)
          (at-sword roomb sword1)
          (at-trap roomc trap1)
          (at-monster roomd monster1)
          (with-trap roomc)
       )

   (:goal (and
          (at-hero roomd)
          (not (sword-not-destroyed-yet sword1))
       )
   )

)