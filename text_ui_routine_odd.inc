    ld a, (de)                      ; what's currently on screen?
    ld h, a
    ld a, (bc)                      ; get next 8 bit row of the character data
    inc bc
    and $0F                         ; we want the second half only
    or h
    ld (de), a                      ; put it on screen
    inc d                           ; get to the next row (+ 256)