# RetCom87-hardware
These are expansion boards for the W65C265SXB development board by Western Design Center developed for the "RetCom87" homebrew computer project by my Retrofuturistic Hardware Vertically Integrated Project team at Georgia Tech. For details, see this YouTube playlist:

https://www.youtube.com/playlist?list=PLOunECWxELQQ03GeMmJSVX49A8VtCcbT9

Atari/Sega controller board: This works! See the Wiki for how to read the controller buttons and the example test code.

Sound board: The YM2149 soundchip board design has been tested on the breadboard, but the actual PCB hasn't been tested yet (I need to order it from JLCPCB). See the example test code.

Video board: The reset pin on TMS9118 is erroneously left disconnected on the PCB; I had to add a bodge wire to hook it to the W65C265SXB reset pin. The TMS9118 board currently sends out bright speckled video. I'm not sure what the issue is: https://youtu.be/yKsjV6f-HKg -- if anyone has any advice, please let me know: lanterma@ece.gatech.edu

These designs are dedicated to the public domain.
