(define
    (domain CMI7504-2526_solution)

    ; There is a basic dungeon made up of rooms. Rooms are connected by one-way corridors. As they leave each room, it is destreoyed and the hero can't go back to it.
    ; Each room can be one of the following: empty, with a sword, with a monster, or with a trap.
    ; The hero can pick up the sword if they are not holding one. They can't drop the sword, if they need to free up their hands, they must destroy it.
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
        (at-sword ?p - room ?s - sword)         ; there is a sword at a location
        (sword-not-destroyed-yet ?s - sword)    ; the sword is not destroyed       
        (holding ?s - sword)                    ; the hero is holding the sword
        (at-monster ?p - room ?m - monster)     ; there is a monster at a location
        (at-trap ?p - room ?t - trap)           ; there is a trap at a location
        (trap-safe ?t - trap)                   ; the trap is not yet armed        
        (with-trap ?p - room)                   ; the hero is in a room with a trap
    )

    (:action move
        ; Our hero moves from one room to another using a corridor. 
        ; Our hero must be in a room, have a room to move to and there must be a corridor between the two rooms.
        ; There must not be a monster in the next room. 
        ; If there is a trap in the current room, it must be disarmed before the hero can move away from this room.
        ; The effect is the hero is in the new room, and the current room is destroyed, so the hero can't go back to it anymore.
        
        :parameters  (?curpos - room ?nextpos - room)
        :precondition (and
                (place ?curpos)
                (place ?nextpos)
                (place-not-destroyed-yet ?nextpos)
                (at-hero ?curpos)
                (corridor ?curpos ?nextpos)
                (forall (?m - monster) (not (at-monster ?nextpos ?m)))
                (forall (?t - trap) (not (and (at-trap ?curpos ?t) (not (trap-safe ?t)))))
                )       
        :effect 
            (and
                (at-hero ?nextpos)
                (not (at-hero ?curpos))
                (not (place-not-destroyed-yet ?curpos))
                
            )
    )        
     
    (:action pickup-sword
        ; Our hero finds and picks up a sword.
        ; The hero must be in the same room as the sword, their hands must be free and the sword must not be destroyed yet.
        ; The effect is that the hero is now holding a sword.
        
        :parameters (?curpos - room ?s - sword)
        :precondition (and
            (place ?curpos)
            (at-hero ?curpos)
            (at-sword ?curpos ?s)
            (not(holding ?s))
            (sword-not-destroyed-yet ?s)
        )
        :effect (holding ?s) 
            
    )

    (:action destroy-sword-and-trap-disarmed
        ; Our hero decides to destroy the sword and disarm the trap at the same time.
        ; The hero must be holding the sword and be in the same room as the trap.
        ; The effect is that the hero is no longer holding the sword, the sword is destroyed, and the trap is disarmed.
        :parameters (?curpos - room ?s - sword ?t - trap)
        :precondition (and
            (place ?curpos)
            (at-hero ?curpos)
            (holding ?s)
            (at-trap ?curpos ?t)
            (not (trap-safe ?t))
        )
        :effect (and
            (not (holding ?s))
            (not(sword-not-destroyed-yet ?s))
            (trap-safe ?t)
        )
    )
   
    (:action trap-disarmed
        ; When the hero disarms a trap, the trap is no longer armed.
        ; The hero must be in the same room as the trap and have their hands free to disarm the trap.
        ; The effect is that the trap is now safe and the hero can move away from this room again.
        :parameters (?curpos - room ?t - trap ?s - sword)
        :precondition (and
            (place ?curpos)
            (at-hero ?curpos)
            (at-trap ?curpos ?t)
            (not (holding ?s))
            (not (trap-safe ?t))
        )
        :effect (trap-safe ?t)        
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
    
    ;(:action destroy-sword
    ;    ; Our hero decides to destroy the sword.
    ;    ; The hero must be holding the sword and cannot destroy it if there is a monster in the same room.
    ;    ; The effect is that the hero is no longer holding the sword, their hands are free, but the sword is forever destroyed.
    ;    :parameters (?curpos - room ?s - sword)
    ;    :precondition (and
    ;        (place ?curpos)
    ;        (at-hero ?curpos)
    ;        (holding ?s)
    ;        (forall (?m - monster) (not (at-monster ?curpos ?m)))
    ;    )
    ;    :effect (and
    ;        (not (holding ?s))
    ;        (not(sword-not-destroyed-yet ?s))
    ;    )
    ;)
)