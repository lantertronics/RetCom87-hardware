# RetCom87-hardware
These are expansion boards for the W65C265SXB development board by Western Design Center developed for the "RetCom87" homebrew computer project by my Retrofuturistic Hardware Vertically Integrated Project team at Georgia Tech. For details, see this YouTube playlist:

https://www.youtube.com/playlist?list=PLOunECWxELQQ03GeMmJSVX49A8VtCcbT9

The controller board works! See the Wiki for how to read the controller buttons. 

Although the rest didn't cause anything to catch fire when I tried plugging them into a W65C265SXB, they are mostly untested otherwise. I'm primarily providing these files here so others can look them over and give advice if they'd like. But, if you are brave and want to go ahead and get your own fabricated, perhaps modifying it as you see fit, have fun! These designs are dedicated to the public domain.

The YM2149 soundchip board doesn't work. To get my design working on a breadboard, I added an inverter between RWB from the microcontroller and BDIR on the YM2149, and two inverters to provide delay for the chip selects going to the A9bar pin on the YM2149. I'll post a revision at some point.

The reset pin on TMS9118 is erroneously left disconnected on the PCB; I had to add a bodge wire to hook it to the W65C265SXB reset pin. The TMS9118 board currently sends out bright speckled video. I'm not sure what the issue is: https://youtu.be/yKsjV6f-HKg -- if anyone has any advice, please let me know: lanterma@ece.gatech.edu
