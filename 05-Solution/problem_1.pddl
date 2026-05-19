(define (problem hero_problem_1)
   (:domain CMI7504-2526_solution)
   (:objects 
      rooma roomb roomc roomd roome roomf roomg roomh - room
      trap1 - trap
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
        (place-not-destroyed-yet rooma)
        (place-not-destroyed-yet roomb)
        (place-not-destroyed-yet roomc)
        (place-not-destroyed-yet roomd)
        (place-not-destroyed-yet roome)
        (place-not-destroyed-yet roomf)
        (place-not-destroyed-yet roomg)
        (place-not-destroyed-yet roomh)

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
        (is-sword sword1)
        (sword-not-destroyed-yet sword1)

        (at-monster roomc monster1)
        (at-monster roomd monster2)

        (at-trap roomf trap1)
        (is-trap trap1)
        (with-trap roomf)
        
        (hands-free)
   )
   (:goal (at-hero roomh))
)
