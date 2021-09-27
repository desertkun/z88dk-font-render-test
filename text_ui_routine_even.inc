    ld a, (bc)                      ; get next 8 bit row of the character data
    inc bc
    and $F0                         ; we want the first half only
    ld (de), a                      ; put it on screen
    inc d                           ; get to the next row (+ 256)