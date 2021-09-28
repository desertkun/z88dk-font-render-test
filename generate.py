import struct

even = []
odd = []

with open("font_4x8.source", "rb") as f:
    byte = f.read(1)
    while byte != b"":
        # Do stuff with byte.
        even.append(byte[0] & 0x0F)
        odd.append(byte[0] & 0xF0)
        byte = f.read(1)

with open("font_4x8_even.bin", "wb") as f:
    for b in even:
        f.write(struct.pack("=B", b))

with open("font_4x8_odd.bin", "wb") as f:
    for b in odd:
        f.write(struct.pack("=B", b))
