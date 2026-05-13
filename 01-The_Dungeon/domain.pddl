(define 
(domain the-dungeon)

; This is the layout of the dungeon, with rooms and corridors between them.
; The hero can move between rooms using the corridors, and the goal is to reach a specific room.

(:requirements :strips)
    (:predicates 
        (room ?r)               ; a room
        (hero ?h)               ; our hero
        (room-visited ?r)        ; a room has been visited by the hero
	    (at-hero ?r)            ; our hero is in a room
	    (corridor ?from ?to)    ; there is a corridor between two rooms
        (not-destroyed-yet ?r) ; the room is not destroyed yet
	        )
    
    (:action move
        ; Our hero moves from one room to another using a corridor 
        ; the effect is that the hero is in the new room and not in the old room anymore
        ; and the old room is now destroyed (not-destroyed-yet becomes false)
        :parameters  (?from ?to)
        :precondition (and  (room ?from) (room ?to) (not-destroyed-yet ?to) (corridor ?from ?to) (at-hero ?from))
        :effect 
            (and
                (at-hero ?to)
                (room-visited ?from)
		        (not (at-hero ?from))
		        (not(not-destroyed-yet ?from))
            ))
   
   )
    
