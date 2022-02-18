# RetCom87-hardware
These are expansion boards for the W65C265SXB development board by Western Design Center developed for the "RetCom87" homebrew computer project by my Retrofuturistic Hardware Vertically Integrated Project team at Georgia Tech. For details, see this YouTube playlist:

https://www.youtube.com/playlist?list=PLOunECWxELQQ03GeMmJSVX49A8VtCcbT9

WARNING: Although these didn't cause anything to catch fire when I tried pluggint them into a W65C265SXB, they are pretty much untested otherwise. I'm primarily providing these files here so others can look them over and give advice if they'd like. But, if you are brave and want to go ahead and get your own fabricated, perhaps modifying it as you see fit, have fun! These designs are dedicated to the public domain.

The reset pin on TMS9118 is erroneously left disconnected on the PCB; I had to add a bodge wire to hook it to the W65C265SXB reset pin. 

The TMS9118 board currently sends out bright speckled video. I'm not sure what the issue is: https://youtu.be/yKsjV6f-HKg
