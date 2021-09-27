EXTERN _text_x
EXTERN _text_y
EXTERN asm_zx_cxy2saddr
EXTERN _font_4x8_80columns
PUBLIC _text_ui_write

defc font = _font_4x8_80columns

_text_ui_get_screen_addr:
    ld a, (_text_x)                 ; get initial screen address
    ld l, a
    ld a, (_text_y)
    ld h, a
    jp asm_zx_cxy2saddr             ; hl now holds a screen address

; stack: string to write
; stack: amount to write
; registers used:
;     ixh - even or odd
;     ixl - number of characters left to write
;     hl - current screen address
;     de - current characted data address
;     bc - current string address
_text_ui_write:
    pop hl                          ; ret
    pop ix                          ; pop the amount into ix
    pop bc                          ; pop string address into bc
    push hl                         ; ret

    call _text_ui_get_screen_addr   ; hl now holds a screen address

    ld ixh, 0                       ; let's start with even

_text_ui_write_loop:
    ld a, (bc)                      ; load the char num
    sub 32

    ex de, hl

    ld h, 0
    ld l, a                         ; hl now holds character num - 32

    add hl, hl
    add hl, hl
    add hl, hl                      ; multiply by 8
    add hl, font

    ex de, hl                       ; de now holds a pointer to characted data

    dec ixh
    jp nz, write_char_loop_even     ; if ixh used to be 1 that means we're even now

write_char_loop_odd:
    include "text_ui_routine_odd.inc"
    include "text_ui_routine_odd.inc"
    include "text_ui_routine_odd.inc"
    include "text_ui_routine_odd.inc"
    include "text_ui_routine_odd.inc"
    include "text_ui_routine_odd.inc"
    include "text_ui_routine_odd.inc"
    include "text_ui_routine_odd.inc"

    ld ixh, 0                       ; we're even now
    inc hl                          ; onto next screen address position
    ld a, h                         ; restore (h)l from 8 increments
    sub 8
    ld h, a
    inc bc                          ; onto next character
    dec ixl                         ; do we have more to print?
    ret z                           ; we're done
    jp _text_ui_write_loop

write_char_loop_even:
    include "text_ui_routine_even.inc"
    include "text_ui_routine_even.inc"
    include "text_ui_routine_even.inc"
    include "text_ui_routine_even.inc"
    include "text_ui_routine_even.inc"
    include "text_ui_routine_even.inc"
    include "text_ui_routine_even.inc"
    include "text_ui_routine_even.inc"

    ld ixh, 1                       ; we're odd now
    ld a, h                         ; restore (h)l from 8 increments
    sub 8
    ld h, a
    inc bc                          ; onto next character
    dec ixl                         ; do we have more to print?
    ret z                           ; we're done
    jp _text_ui_write_loop
