(define 
    (problem do-not-die_sword_two_traps)
    ; The hero unluckily finds a maze with two traps, 
    ; but hey, at least there is a sword 

    (:domain it-is-a-trap)
   (:objects 
      rooma roomb roomc roomd roome roomf roomg roomh - room
      sword1 - sword
      monster1 monster2 - monster
      trap1 trap2 - trap
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
        (at-trap roomf trap1)
        (at-trap roomg trap2)
        (with-trap roomf)
        (with-trap roomg)
        (hands-free)
        (sword-not-destroyed-yet sword1)      
   )            

   (:goal (at-hero roomh))  
)
