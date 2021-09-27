    ld a, (de)                      ; get next 8 bit row of the character data
    and $0F
    or (hl)                         ; combine with what's on screen
    ld (hl), a                      ; put it on screen

    inc de
    inc h                           ; get to the next row (+ 256)