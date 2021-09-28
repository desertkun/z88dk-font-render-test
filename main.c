#include "text_ui.h"
#include <spectrum.h>

const char* text =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin hendrerit finibus nunc, vel imperdiet ipsum euismod vel. Pellentesque suscipit, erat quis viverra mollis, ex nisi consectetur nulla, ut aliquet elit nibh eu neque. Donec vitae congue urna. Integer eget turpis in elit vulputate dignissim ac ut nulla. Donec pulvinar mollis ultrices. Curabitur pulvinar, neque sed pulvinar dapibus, elit felis rutrum massa, facilisis pharetra mauris lectus vel sem. Quisque rutrum quam justo, sed iaculis velit tristique sit amet. "
    "Sed magna mi, vestibulum quis facilisis sed, ultrices non metus. Duis pulvinar ipsum a sagittis ullamcorper. Nulla sollicitudin luctus tortor. Pellentesque eros risus, efficitur quis ligula eget, tincidunt dictum sapien. Aenean ut egestas eros. Suspendisse viverra hendrerit mollis. Duis efficitur eget leo vitae vestibulum. Duis feugiat lacinia iaculis. Suspendisse gravida, tortor quis tempor porta, tortor metus blandit ligula, in cursus neque ex vel felis. "
    "Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Pellentesque pretium purus eros, pulvinar viverra libero rhoncus et. Nulla finibus nulla ac sem aliquam tincidunt. Suspendisse ut purus at sapien mattis venenatis ac nec quam. Morbi iaculis libero tortor, sed volutpat nunc feugiat a. Duis a feugiat enim. Maecenas gravida lorem quis lacus consequat, non porttitor sapien aliquet. Sed tortor nisl, tincidunt vitae orci vitae, consectetur luctus eros. Proin egestas accumsan accumsan. Ut blandit velit eu iaculis porta. In mauris ex, mollis non metus id, tempor ultricies libero. Sed in mauris risus. Duis rutrum auctor sem quis iaculis.";

int main()
{
    text_ui_init();
    text_ui_color(INK_BLACK | PAPER_WHITE);

    char* p = text;
    uint16_t left = strlen(text);

    for (uint8_t at = 0; at < 24; at++)
    {
        text_ui_write_at(0, at, p, 32);
        p += 64;
    }

}