#ifndef FZX_UI_HEADER
#define FZX_UI_HEADER

#include <stdint.h>

extern void text_ui_init(void);
extern void text_ui_at(uint8_t x, uint8_t y);
extern void text_ui_puts_at(uint8_t x, uint8_t y, const char* s) __z88dk_callee;
extern void text_ui_write_at(uint8_t x, uint8_t y, const char* buf, uint16_t buflen) __z88dk_callee;
extern char* text_ui_buffer_partition(char *buf, uint16_t buflen, uint8_t allowed_width);
extern uint16_t text_ui_string_extent(const char *s);
extern void text_ui_switch_xor(void);
extern void text_ui_switch_or(void);
extern void text_ui_set_paper(uint16_t x, uint16_t y, uint16_t w, uint16_t h);
extern void text_ui_color(uint8_t color) __z88dk_fastcall;

#endif