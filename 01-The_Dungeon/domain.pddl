(define 
(domain the-dungeon)

; This is the layout of the dungeon, with rooms and corridors between them.
; The hero can move between rooms using the corridors, and the goal is to reach a specific room.

(:requirements :strips)
    (:predicates 
        (place ?p)               ; a room
        (place-visited ?p)        ; a room has been visited by the hero
	    (at-hero ?p)            ; our hero is in a room
	    (corridor ?from ?to)    ; there is a corridor between two rooms
        (place-not-destroyed-yet ?p) ; the room is not destroyed yet
	        )
    
    (:action move
        ; Our hero moves from one room to another using a corridor 
        ; the effect is that the hero is in the new room and not in the old room anymore
        ; and the old room is now destroyed (not-destroyed-yet becomes false)
        :parameters  (?from ?to)
        :precondition (and
            (place ?from)
            (place ?to)
            (place-not-destroyed-yet ?to)
            (corridor ?from ?to)
            (at-hero ?from)
        )
        :effect 
            (and
                (at-hero ?to)
                (place-visited ?from)
		        (not (at-hero ?from))
		        (not(place-not-destroyed-yet ?from))
            )
    )
   
)