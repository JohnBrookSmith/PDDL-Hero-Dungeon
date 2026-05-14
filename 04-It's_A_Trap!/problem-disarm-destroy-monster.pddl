(define 
    (problem disarm-the-trap_destory_the_sword_and_avoid_the_monster)
    (:domain it-is-a-trap)
       ; The hero finds a trap in the middle of the path to the goal,
       ; they also find a sword that they want to pick up, only to destory it,
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
          (hands-free)
          (at-hero rooma)
          (at-sword roomb sword1)
          (at-trap roomc trap1)
          (at-monster roomd monster1)
          (trap-safe trap1)
          (is-trap trap1)
          (is-sword sword1)
          (sword-not-destroyed-yet sword1)
       )

   (:goal (and
          (at-hero roomd)
          (trap-safe trap1)
          (not (sword-not-destroyed-yet sword1))
   ))

)