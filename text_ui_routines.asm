EXTERN _text_x
EXTERN _text_y
EXTERN asm_zx_cxy2saddr
EXTERN _font_4x8_80columns
PUBLIC _text_ui_puts
PUBLIC _text_ui_write

defc font = _font_4x8_80columns

_text_ui_get_screen_addr:
    ld a, (_text_x)                 ; get initial screen address
    ld l, a
    ld a, (_text_y)
    ld h, a
    jp asm_zx_cxy2saddr             ; hl now holds a screen address

; a = address to write
; de = screen address to write
; ixl = if not zero, we're odd
_text_ui_write_char:
    sub 32
    ld h, 0
    ld l, a                         ; hl now holds character num - 32

    add hl, hl
    add hl, hl
    add hl, hl                      ; multiply by 8

    ld bc, font
    add hl, bc
    ld bc, hl                       ; bc now holds a pointer to characted data

    ld a, ixl
    and a
    jp z, write_char_loop_even

write_char_loop_odd:
    include "text_ui_routine_odd.inc"
    include "text_ui_routine_odd.inc"
    include "text_ui_routine_odd.inc"
    include "text_ui_routine_odd.inc"
    include "text_ui_routine_odd.inc"
    include "text_ui_routine_odd.inc"
    include "text_ui_routine_odd.inc"
    include "text_ui_routine_odd.inc"

    ld ixl, 0                       ; we're even now
    ret

write_char_loop_even:
    include "text_ui_routine_even.inc"
    include "text_ui_routine_even.inc"
    include "text_ui_routine_even.inc"
    include "text_ui_routine_even.inc"
    include "text_ui_routine_even.inc"
    include "text_ui_routine_even.inc"
    include "text_ui_routine_even.inc"
    include "text_ui_routine_even.inc"

    ld ixl, 1                       ; we're odd now
    ret

; hl = string to write
_text_ui_puts:
    push hl

    call _text_ui_get_screen_addr   ; hl now holds a screen address
    ld de, hl                       ; put that into de
    pop bc                          ; pop string address into bc

    ld ixl, 0                       ; let's start with even
_text_ui_puts_loop:
    ld a, (bc)                      ; load the char
    and a
    ret z                           ; we've reached null-terminator

    push bc
    push de

    call _text_ui_write_char        ; print it out

    pop de
    pop bc

    inc bc                          ; onto next characted

    ld a, ixl                       ; skip the next instruction if we're odd
    and a                           ; move screen position only on ever second char
    jp nz, _text_ui_puts_loop

    inc de                          ; onto next screen address position

    jp _text_ui_puts_loop

; stack: string to write
; stack: amount to write
_text_ui_write:
    pop hl                          ; ret
    pop iy                          ; pop the amount into iy
    pop bc                          ; pop string address into bc
    push hl                         ; ret

    call _text_ui_get_screen_addr   ; hl now holds a screen address
    ld de, hl                       ; put that into de

    ld ixl, 0                       ; let's start with even
_text_ui_write_loop:
    ld a, (bc)                      ; load the char

    push bc
    push de

    call _text_ui_write_char        ; print it out

    pop de
    pop bc

    inc bc                          ; onto next characted

    ld a, ixl                       ; skip the next instruction if we're odd
    and a                           ; move screen position only on ever second char
    jp nz, _text_ui_write_skip_next_screen

    inc de                          ; onto next screen address position

_text_ui_write_skip_next_screen:
    dec iy
    ld a, iyh
    or iyl
    ret z                           ; we're done

    jp _text_ui_write_loop
