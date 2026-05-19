(define (problem hero_problem_2)
   (:domain CMI7504-2526_solution)
   (:objects 
      rooma roomb roomc roomd roome roomf roomg roomh roomi roomj roomk rooml - room
      trap1 trap2 trap3 trap4 trap5 - trap
      sword1 sword2 - sword
      monster1 monster2 monster3 - monster
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
        (place roomi)
        (place roomj)
        (place roomk)
        (place rooml)
        (place-not-destroyed-yet rooma)
        (place-not-destroyed-yet roomb)
        (place-not-destroyed-yet roomc)
        (place-not-destroyed-yet roomd)
        (place-not-destroyed-yet roome)
        (place-not-destroyed-yet roomf)
        (place-not-destroyed-yet roomg)
        (place-not-destroyed-yet roomh)
        (place-not-destroyed-yet roomi)
        (place-not-destroyed-yet roomj)
        (place-not-destroyed-yet roomk)
        (place-not-destroyed-yet rooml)

        (corridor rooma roomb)
        (corridor roomb rooma)
        (corridor rooma roomc)
        (corridor roomc rooma)

        (corridor roomb roomd)
        (corridor roomd roomb)
        (corridor roomb roome)
        (corridor roome roomb)

        (corridor roomc roomd)
        (corridor roomd roomc)
        (corridor roomc roome)
        (corridor roome roomc)

        (corridor roomd roomf)
        (corridor roomf roomd)
        (corridor roomd roomg)
        (corridor roomg roomd)

        (corridor roome roomf)
        (corridor roomf roome)
        (corridor roome roomg)
        (corridor roomg roome)

        (corridor roomf roomh)  
        (corridor roomh roomf)
        (corridor roomf roomi)
        (corridor roomi roomf)

        (corridor roomg roomh)
        (corridor roomh roomg)
        (corridor roomg roomi)
        (corridor roomi roomg)

        (corridor roomh roomj)
        (corridor roomj roomh)
        (corridor roomh roomk)
        (corridor roomk roomh)  

        (corridor roomi roomj)
        (corridor roomj roomi)
        (corridor roomi roomk)
        (corridor roomk roomi)

        (corridor roomj rooml)
        (corridor rooml roomj)

        (corridor roomk rooml)
        (corridor rooml roomk)

        (at-hero rooma)

        (sword-not-destroyed-yet sword1)
        (sword-not-destroyed-yet sword2)
        (at-sword roomb sword1)
        (at-sword roomg sword2)

        (at-monster roomd monster1)
        (at-monster roomf monster2)
        (at-monster roomi monster3)

        (at-trap roomc trap1)
        (at-trap roome trap2)
        (at-trap roomh trap3)
        (at-trap roomj trap4)
        (at-trap roomk trap5)
        (not(trap-safe trap1))
        (not(trap-safe trap2))
        (not(trap-safe trap3))
        (not(trap-safe trap4))
        (not(trap-safe trap5))

        (hands-free)

               )
   (:goal (at-hero rooml))
)
