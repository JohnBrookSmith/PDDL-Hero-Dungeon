(define
    (domain it-is-a-trap)

    ; There is a basic dungeon with rooms and corridors.  
    ; There is a trap that needs to be disarmed to get to the goal.
    ; The hero can disarm the trap if their hands are free, but they can't move away from the trap until it is disarmed.

    (:requirements :strips :typing :negative-preconditions :conditional-effects)
    (:types  
	hero
    monster
    room
    sword
    trap
    )

    (:predicates 
        (place ?p - room)                       ; a room
        (holding ?s - sword)                    ; the hero is holding the sword
        (hands-free)                            ; the hero's hands are free
        (sword-not-destroyed-yet ?s - sword)    ; the sword is not destroyed
        (at-sword ?p - room ?s - sword)         ; there is a sword at a location
	    (at-hero ?p - room)                     ; our hero is in a room
	    (corridor ?from - room ?to - room)      ; there is a corridor between two rooms
        (at-monster ?p - room ?m - monster)     ; there is a monster at a location
        (at-trap ?p - room ?t - trap)           ; there is a trap at a location
        (trap-safe ?t - trap)                   ; the trap is safe to move away from
        (with-trap ?p - room)                   ; the hero is in a room with a trap
        (with-trap-armed ?p - room)             ; the hero is in a room with an armed trap

	)

 (:action move
        ; Our hero moves from one room to another using a corridor. 
        ; Our hero must be in a room, have a room to move to and there must be a corridor between the two rooms.
        ; The effect is that the hero is in the new room and not in the old room.
        ; If there is a monster in the new room and the hero is not holding a sword, the hero dies and the game is over.
        ; If there is a trap in the new room then it becomes armed and the hero can't move away from it until it is disarmed.
        ; When the hero moves away from the room, it is destroyed and the hero can't go back to it .

        :parameters  (?curpos - room ?nextpos - room)
        :precondition (and
                (place ?curpos)
                (place ?nextpos)
                (at-hero ?curpos)
                (corridor ?curpos ?nextpos)
                (forall (?m - monster) (not (at-monster ?nextpos ?m)))
                (forall (?t - trap) (not (and (at-trap ?curpos ?t) (not (trap-safe ?t)))))
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
        :parameters (?curpos - room ?sword - sword)
        :precondition (and
            (place ?curpos)
            (at-hero ?curpos)
            (holding ?sword)
            (forall (?m - monster) (not (at-monster ?curpos ?m)))
        )
        :effect (and
            (hands-free)
            (not (holding ?sword))
            (not(sword-not-destroyed-yet ?sword))
            
        )
    )

    (:action trap-disarmed
        ; When the hero disarms a trap, the trap is no longer armed.
        ; The hero must be in the same room as the trap and have their hands free to disarm the trap.
        ; The effect is that the trap is now safe and the hero can move away from this room again.
        :parameters (?curpos - room ?t - trap)
        :precondition (and
            (place ?curpos)
            (at-hero ?curpos)
            (at-trap ?curpos ?t)
            (hands-free)
            (not (trap-safe ?t))
        )
        :effect (and
            (trap-safe ?t)
        )
    )

    (:action scare-monster
                ; Our hero scares the monster away.
                ; The hero must be about to move into the same room as the monster.
                ; The effect is that the monster doesn't attack, so our hero can be in this room
                ; without dying and move to the next room. 
                
                :parameters (?curpos - room ?nextpos - room ?sword - sword ?m - monster)
                :precondition (and
                    (place ?curpos)
                    (place ?nextpos)
                    (at-hero ?curpos)
                    (corridor ?curpos ?nextpos)
                    (holding ?sword)
                    (at-monster ?nextpos ?m)
                    )
                        
                :effect 
                    (and
                        (at-hero ?nextpos)
                        (not (at-hero ?curpos))
                    )
            )
)