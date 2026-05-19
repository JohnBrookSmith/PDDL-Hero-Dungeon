(define 
    (problem do-not-die_sword_two_monsters)
    ; The hero luckily finds a sword on their way to the goal, scares a monster away, 
    ; then decides to destroy the sword to free their hands and continue on their way to the goal. 

    (:domain monster-monster)
   (:objects 
      rooma roomb roomc roomd roome roomf roomg roomh - room
      sword1 - sword
      monster1 monster2 - monster
   )
   (:init 
        (place rooma)
        (place roomb)
        (place roomc)
        (place roomd)
        (place roome)
        (place roomf)
        (place roomg)
        (place roomh)
        (corridor rooma roomb)
        (corridor roomb rooma)
        (corridor rooma roomc)
        (corridor roomc rooma)
        (corridor roomb roomc)
        (corridor roomc roomb)
        (corridor roomb roomd)
        (corridor roomd roomb)
        (corridor roomc roome)
        (corridor roome roomc)
        (corridor roomd roome)
        (corridor roome roomd)
        (corridor roomd roomf)
        (corridor roomf roomd)
        (corridor roome roomg)
        (corridor roomg roome)
        (corridor roomf roomg)
        (corridor roomg roomf)
        (corridor roomf roomh)
        (corridor roomh roomf)
        (at-hero rooma)
        (at-sword roomb sword1)
        (at-monster roomd monster1)
        (at-monster roomc monster2)
        (hands-free)
        (sword-not-destroyed-yet sword1)      
   )            

   (:goal (at-hero roomh))  
)
