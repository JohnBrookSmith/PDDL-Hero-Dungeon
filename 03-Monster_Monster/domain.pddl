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
        (holding ?s - sword)                    ; the hero is holding the sword
        (sword-not-destroyed-yet ?s - sword)    ; the sword is not destroyed
        (at-sword ?p - room ?s - sword)         ; there is a sword at a location
	    (at-hero ?p - room)                     ; our hero is in a room
	    (corridor ?from - room ?to - room)      ; there is a corridor between two rooms
        (at-monster ?p - room ?m - monster)     ; there is a monster at a location
	)

    (:action move
        ; Our hero moves from one room to another using a corridor. 
        ; Our hero must be in a room, have a room to move to and there must be a corridor between the two rooms.
        ; The effect is that the hero is in the new room and not in the old room anymore.
        ; If there is a monster in the new room the hero can't move into the room.

        :parameters  (?curpos - room ?nextpos - room)
        :precondition (and
            (place ?curpos)
            (place ?nextpos)
            (at-hero ?curpos)
            (corridor ?curpos ?nextpos)
            (forall (?m - monster) (not (at-monster ?nextpos ?m)))
            )         
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
        
        :parameters (?curpos - room ?s - sword)
        :precondition (and
            (place ?curpos)
            (at-hero ?curpos)
            (at-sword ?curpos ?s)
            (sword-not-destroyed-yet ?s)
            (not(holding ?s))
        )
        :effect(holding ?s)

        )
    

    (:action destroy-sword
        ; Our hero decides to destroy the sword.
        ; The hero must be holding the sword and cannot destroy it if there is a monster in the same room.
        ; The effect is that the hero is no longer holding the sword, their hands are free, but the sword is forever destroyed.
        :parameters (?curpos - room ?s - sword)
        :precondition (and
            (place ?curpos)
            (at-hero ?curpos)
            (holding ?s)
            (forall (?m - monster) (not (at-monster ?curpos ?m)))
        )
        :effect (and
            (not (holding ?s))
            (not(sword-not-destroyed-yet ?s))
        )
    ) 

    (:action scare-monster
            ; Our hero scares the monster away.
            ; The hero must be about to move into the same room as the monster.
            ; The effect is that the monster doesn't attack, so our hero can be in this room
            ; without dying and move to the next room. 
            
            :parameters (?curpos - room ?nextpos - room ?s - sword ?m - monster)
            :precondition (and
                (place ?curpos)
                (place ?nextpos)
                (at-hero ?curpos)
                (corridor ?curpos ?nextpos)
                (holding ?s)
                (at-monster ?nextpos ?m)
                )
                    
            :effect 
                (and
                    (at-hero ?nextpos)
                    (not (at-hero ?curpos))
                )
    )
)