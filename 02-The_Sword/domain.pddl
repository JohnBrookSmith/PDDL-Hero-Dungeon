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
        :parameters (?curpos ?s)
        :precondition (and (place ?curpos) (sword ?s) (at-hero ?curpos) (at ?curpos ?s) (not(holding ?s)) (sword-not-destroyed-yet ?s))
        :effect (and (holding ?s))
    )

    (:action destroy-sword
        ; Our hero decides to destroy the sword.
        ; The hero must be holding the sword.
        ; The effect is that the hero is no longer holding the sword, their hands are free, but the sword is forever destroyed.
        :parameters (?curpos ?s)
        :precondition (and (place ?curpos) (sword ?s) (at-hero ?curpos) (holding ?s))
        :effect (and (not (holding ?s)) (not(sword-not-destroyed-yet ?s)))
    )
    
)