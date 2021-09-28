#include "text_ui.h"
#include <spectrum.h>
#include <string.h>

uint8_t text_x, text_y, text_color;

extern void text_ui_write(const char* buf, uint16_t buflen) __z88dk_callee;

void text_ui_init(void)
{
}

void text_ui_at(uint8_t x, uint8_t y)
{
    text_x = x;
    text_y = y;
}

void text_ui_puts_at(uint8_t x, uint8_t y, const char* s) __z88dk_callee
{
    text_ui_write_at(x, y, s, strlen(s));
}

void text_ui_write_at(uint8_t x, uint8_t y, const char* buf, uint16_t buflen)
{
    text_x = x;
    text_y = y;
    text_ui_write(buf, buflen);

    //uint8_t* c = zx_cxy2aaddr(x, y);
    //memset(c, text_color, (buflen >> 1) + (buflen & 0x01));
}

char* text_ui_buffer_partition(char *buf, uint16_t buflen, uint8_t allowed_width)
{
    allowed_width = allowed_width << 1; // two chars per cell
    uint8_t exceeded_len = buflen > allowed_width;
    uint8_t len = exceeded_len ? allowed_width : buflen;
    char* next_line = memchr(buf, '\n', len);
    if (next_line)
    {
        return next_line;
    }
    if (exceeded_len)
    {
        char *p = memrchr(buf, ' ', len);
        return p ? p : buf + len;
    }
    return buf + len;
}

uint16_t text_ui_string_extent(const char *s)
{
    return strlen(s) / 2;
}

void text_ui_switch_xor(void)
{
}

void text_ui_switch_or(void)
{
}

void text_ui_set_paper(uint16_t x, uint16_t y, uint16_t w, uint16_t h)
{
}

void text_ui_color(uint8_t color) __z88dk_fastcall
{
    text_color = color;
}
