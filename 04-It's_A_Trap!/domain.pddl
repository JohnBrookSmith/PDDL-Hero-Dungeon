(define
    (domain it-is-a-trap)

    ; There is a basic dungeon with rooms and corridors.  
    ; There is a trap that needs to be disarmed to get to the goal.
    ; The hero can disarm the trap if their hands are free, but they can't move away from the trap until it is disarmed.

    (:requirements :strips :typing :negative-preconditions)
    (:types  
	hero
    monster
    room
    sword
    trap
    )

    (:predicates 
        (place ?p - room)                       ; a room
        (is-trap ?t - trap)                        ; a trap
        (is-sword ?s - sword)                   ; the sword
        (holding ?s - sword)                    ; the hero is holding the sword
        (hands-free)                            ; the hero's hands are free
        (sword-not-destroyed-yet ?s - sword)    ; the sword is not destroyed
        (at-sword ?p - room ?s - sword)         ; there is a sword at a location
	    (at-hero ?p - room)                     ; our hero is in a room
	    (corridor ?from - room ?to - room)      ; there is a corridor between two rooms
        (at-monster ?p - room ?m - monster)     ; there is a monster at a location
        (at-trap ?p - room ?t - trap)           ; there is a trap at a location
        (trap-safe ?t - trap)                   ; the trap is not yet armed
	)

    (:action move
        ; Our hero moves from one room to another using a corridor. 
        ; Our hero must be in a room, have a room to move to and there must be a corridor between the two rooms.
        ; Our hero cannot move into a room with a monster or trap in it, and cannot move out of a room with an 
        ; armed trap in it using this action.
        ; The effect is that the hero is in the new room and not in the old room anymore.

        :parameters  (?curpos - room ?nextpos - room ?m - monster ?t - trap)
        :precondition (and
            (place ?curpos)
            (place ?nextpos)
            (at-hero ?curpos)
            (corridor ?curpos ?nextpos)
            (not(at-monster ?nextpos ?m))
            (not(at-trap ?nextpos ?t))
            (not(and (at-trap ?curpos ?t) (not (trap-safe ?t))))
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

    (:action scare-monster
        ; Our hero scares the monster away.
        ; The hero must be about to move into the same room as the monster.
        ; Our hero cannot move into a room with a trap in it, or move out of a room with an armed trap in it using this action.
        ; The effect is that the monster doesn't attack, so our hero can be in this room
        ; without dying and move to the next room. 
        
        :parameters (?curpos - room ?nextpos - room ?sword - sword ?m - monster ?t - trap)
        :precondition (and
            (place ?curpos)
            (place ?nextpos)
            (at-hero ?curpos)
            (corridor ?curpos ?nextpos)
            (holding ?sword)
            (at-monster ?nextpos ?m)
            (not(at-trap ?nextpos ?t))
            (not(and (at-trap ?curpos ?t) (not (trap-safe ?t))))
            )
                 
        :effect 
            (and
                (at-hero ?nextpos)
                (not (at-hero ?curpos))
            )
    )

    (:action trap-armed
        ; When the hero enters a room with a trap, the trap is armed.
        ; The effect is that the trap is now armed and the hero cannot move away from this room until the trap is disarmed.
        
        :parameters  (?curpos - room ?nextpos - room ?m - monster ?t - trap)
        :precondition (and
            (place ?curpos)
            (place ?nextpos)
            (at-hero ?curpos)
            (corridor ?curpos ?nextpos)
            (at-trap ?nextpos ?t)
            (is-trap ?t)
            (not(at-monster ?nextpos ?m))
                   )         
        :effect 
            (and
                (at-hero ?nextpos)
                (not(at-hero ?curpos))
                (not(trap-safe ?t))
                )
                
            )
    
    (:action trap-disarmed
        ; When the hero disarms a trap, the trap is no longer armed.
        ; The hero must be in the same room as the trap and have their hands free to disarm the trap.
        ; The effect is that the trap is now safe and the hero can move away from this room again.
        :parameters (?curpos - room ?t - trap)
        :precondition (and
            (place ?curpos)
            (is-trap ?t)
            (at-hero ?curpos)
            (at-trap ?curpos ?t)
            (hands-free)
            (not (trap-safe ?t))
        )
        :effect (and
            (trap-safe ?t)
        )
    )

)