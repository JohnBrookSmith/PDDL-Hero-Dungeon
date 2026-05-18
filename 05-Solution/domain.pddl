(define
    (domain CMI7504-2526_solution)

    ; There is a basic dungeon made up of rooms. Rooms are connected by one-way corridors.  
    ; Each room can be one of the following: empty, with a sword, with a monster, or with a trap.
    ; The hero can pick up the sword if their hands are free. They can't drop the sword, if they need to free up their hands, they must destroy it.
    ; The hero must be holding a sword to scare the monster in any room they are in. 
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
        (place-not-destroyed-yet ?p)            ; the room is not destroyed yet
        (corridor ?from - room ?to - room)      ; there is a corridor between two rooms
        (at-hero ?p - room)                     ; our hero is in a room
        (is-sword ?s - sword)                   ; the sword
        (at-sword ?p - room ?s - sword)         ; there is a sword at a location
        (sword-not-destroyed-yet ?s - sword)    ; the sword is not destroyed       
        (holding ?s - sword)                    ; the hero is holding the sword
        (is-trap ?t - trap)                     ; a trap      
        (at-monster ?p - room ?m - monster)     ; there is a monster at a location
        (at-trap ?p - room ?t - trap)           ; there is a trap at a location
        (trap-safe ?t - trap)                   ; the trap is not yet armed        
        (with-trap ?p - room)                   ; the hero is in a room with a trap
        (with-trap-armed ?p - room)             ; the hero is in a room with an armed trap
        (hands-free)                            ; the hero's hands are free
        
	)

    (:action move
        ; Our hero moves from one room to another using a corridor. 
        ; Our hero must be in a room, have a room to move to and there must be a corridor between the two rooms.
        ; The effect is that the hero is in the new room and not in the old room.
        ; If there is a monster in the new room and the hero is not holding a sword, the hero dies and the game is over.
        ; If there is a trap in the new room then it becomes armed and the hero can't move away from it until it is disarmed.
        ; When the hero moves away from the room, it is destroyed and the hero can't go back to it .

        :parameters  (?curpos - room ?nextpos - room ?t - trap)
        :precondition (and
                (place ?curpos)
                (place ?nextpos)
                (place-not-destroyed-yet ?nextpos)
                (at-hero ?curpos)
                (corridor ?curpos ?nextpos)
                (forall (?m - monster) (not (at-monster ?nextpos ?m)))
                (not(with-trap-armed ?curpos))
                )       
        :effect 
            (and
                (at-hero ?nextpos)
                (not (at-hero ?curpos))
                (not (place-not-destroyed-yet ?curpos))
                (when (with-trap ?nextpos) 
                (with-trap-armed ?nextpos))             
                
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

    (:action destroy-sword-and-trap-disarmed
        ; Our hero decides to destroy the sword and disarm the trap at the same time.
        ; The hero must be holding the sword and be in the same room as the trap.
        ; The effect is that the hero is no longer holding the sword, their hands are free, the sword is destroyed, and the trap is disarmed.
        :parameters (?curpos - room ?sword - sword ?t - trap)
        :precondition (and
            (place ?curpos)
            (is-sword ?sword)
            (is-trap ?t)
            (at-hero ?curpos)
            (holding ?sword)
            (at-trap ?curpos ?t)
            (not (trap-safe ?t))
        )
        :effect (and
            (hands-free)
            (not (holding ?sword))
            (not(sword-not-destroyed-yet ?sword))
            (trap-safe ?t)
            (not (with-trap-armed ?curpos))
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
            (not (with-trap-armed ?curpos))
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
    
    ;(:action destroy-sword
    ;    ; Our hero decides to destroy the sword.
    ;    ; The hero must be holding the sword and cannot destroy it if there is a monster in the same room.
    ;    ; The effect is that the hero is no longer holding the sword, their hands are free, but the sword is forever destroyed.
    ;    :parameters (?curpos - room ?sword - sword)
    ;    :precondition (and
    ;        (place ?curpos)
    ;        (is-sword ?sword)
    ;        (at-hero ?curpos)
    ;        (holding ?sword)
    ;        (forall (?m - monster) (not (at-monster ?curpos ?m)))
    ;    )
    ;    :effect (and
    ;        (hands-free)
    ;        (not (holding ?sword))
    ;        (not(sword-not-destroyed-yet ?sword))
    ;        
    ;    )
    ;)
)