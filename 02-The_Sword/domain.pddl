(define 
(domain the-sword)

; There is a basic dungeon with rooms and corridors.  
; There is a sword that the hero can pick up if their hands are free. 
; They can't drop the sword, if they need to free up their hands, they must destroy it. 

(:requirements :strips :negative-preconditions)
    (:predicates 
        (place ?p)            ; a room
        (sword ?s)              ; the sword
        (holding ?s)            ; the hero is holding the sword
        (hands-free)            ; the hero's hands are free
        (sword-not-destroyed-yet ?s)            ; the sword is not destroyed
        (at ?p ?s)              ; the sword is at a location
	    (at-hero ?r)            ; our hero is in a room
	    (corridor ?from ?to)    ; there is a corridor between two rooms

	        )

   (:action move
        ; Our hero moves from one room to another using a corridor. 
        ; Our hero must be in a room, have a room to move to and there must be a corridor between the two rooms.
        ; The effect is that the hero is in the new room and not in the old room anymore.

        :parameters  (?curpos ?nextpos)
        :precondition (and (place ?curpos) (place ?nextpos) (at-hero ?curpos) (corridor ?curpos ?nextpos))
        :effect 
            (and
                (at-hero ?nextpos)
		        (not (at-hero ?curpos))
            )
    )

    (:action pickup-sword
        ; Our hero finds and picks up a sword.
        ; The hero must be in the same room as the sword, their hands must be free and the sword must not be destroyed yet.
        ; The effect is that the hero is now holding the sword, their hands are not free.
        :parameters (?curpos ?sword)
        :precondition (and (place ?curpos) (sword ?sword) (at-hero ?curpos) (at ?curpos ?sword) (hands-free) (sword-not-destroyed-yet ?sword))
        :effect (and (holding ?sword) (not (hands-free)))
    )

    (:action destroy-sword
        ; Our hero decides to destroy the sword.
        ; The hero must be holding the sword.
        ; The effect is that the hero is no longer holding the sword, their hands are free, but the sword is forever destroyed.
        :parameters (?curpos ?sword)
        :precondition (and (place ?curpos) (sword ?sword) (at-hero ?curpos) (holding ?sword))
        :effect (and (hands-free) (not (holding ?sword)) (not(sword-not-destroyed-yet ?sword)))
    )
    
)