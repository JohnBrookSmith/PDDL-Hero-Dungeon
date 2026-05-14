(define
    (domain monster-monster)

    ; There is a basic dungeon with rooms and corridors.  
    ; There is a sword that the hero can pick up if their hands are free. 
    ; They can't drop the sword, if they need to free up their hands, they must destroy it. 
    ; There is a monster in one of the rooms. If the hero tries to move into a room with a monster, they die and fail the plan.
    ; The hero can scare the monster away if they are holding the sword, so they can move into the room with the monster without dying.

    (:requirements :strips :typing :negative-preconditions :conditional-effects)
    (:types  
	hero
    monster
    room
    sword
    )

    (:predicates 
        (place ?p - room)               ; a room
        (is-sword ?s - sword)                   ; the sword                      ; the sword
        (holding ?s - sword)                    ; the hero is holding the sword
        (hands-free)                            ; the hero's hands are free
        (sword-not-destroyed-yet ?s - sword)    ; the sword is not destroyed
        (at-sword ?p - room ?s - sword)         ; there is a sword at a location
	    (at-hero ?p - room)                     ; our hero is in a room
	    (corridor ?from - room ?to - room)      ; there is a corridor between two rooms
        (at-monster ?p - room ?m - monster)     ; there is a monster at a location
        (game-over)                             ; the hero is dead, the game is over
	        )

    (:action move
        ; Our hero moves from one room to another using a corridor. 
        ; Our hero must be in a room, have a room to move to and there must be a corridor between the two rooms.
        ; The effect is that the hero is in the new room and not in the old room anymore.
        ; If there is a monster in the new room and the hero is not holding a sword, the hero dies and the game is over.

        :parameters  (?curpos - room ?nextpos - room ?m - monster ?s - sword)
        :precondition (and
            (place ?curpos)
            (place ?nextpos)
            (at-hero ?curpos)
            (corridor ?curpos ?nextpos)
            )         
        :effect 
            (and
                (at-hero ?nextpos)
                (not (at-hero ?curpos))
                (when (and 
                    (at-monster ?nextpos ?m) 
                    (not (holding ?s)))
                (game-over)
                )
            )
        )
    
   
    (:action pickup-sword
        ; Our hero finds and picks up a sword.
        ; The hero must be in the same room as the sword, their hands must be free and the sword must not be destroyed yet.
        ; The effect is that the hero is now holding the sword, their hands are not free.
        
        :parameters (?curpos - room ?sword - sword)
        :precondition (and
            (place ?curpos)
            (is-sword ?sword)
            (at-hero ?curpos)
            (at-sword ?curpos ?sword)
            (hands-free)
            (sword-not-destroyed-yet ?sword)
        )
        :effect (and 
            (holding ?sword) 
            (not (hands-free))
        )
    )

    (:action destroy-sword
        ; Our hero decides to destroy the sword.
        ; The hero must be holding the sword and cannot destroy it if there is a monster in the same room.
        ; The effect is that the hero is no longer holding the sword, their hands are free, but the sword is forever destroyed.
        :parameters (?curpos - room ?sword - sword ?m - monster)
        :precondition (and
            (place ?curpos)
            (is-sword ?sword)
            (at-hero ?curpos)
            (holding ?sword)
            (not (at-monster ?curpos ?m))
        )
        :effect (and
            (hands-free)
            (not (holding ?sword))
            (not(sword-not-destroyed-yet ?sword))
            
        )
    ) 

)