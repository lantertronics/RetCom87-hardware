;RetCom87: TMS9118 board for W65C265 microcontroller 
;Text mode demo
;Aaron Lanterman, Oct. 24, 2023
.65816
.org 0x1000

;ports for TMS9118
VDATA EQU 0xDFC0          ;VRAM data sequential reads/writers
VREG EQU 0xDFC1           ;Register read/writes and initial VRAM address 

start:
  ;Disable interrupts when writing to the VDP!!!!!
  ;If an interrupts something disturbs the process of writing
  ;bytes to the VDP, you'll get out of sync with it and horrible things can
  ;randomly happen! I think the monitor uses interrupts, so we will need to
  ;re-enable them to run monitor routines (like printing for debugging) while
  ;remembering to disable them after we're done!
  sei

  sep #0x20               ;Set A to 8-bit
  sep #0x10               ;Set X/Y to 8-bit

  ;Initialize VDG to text mode
  ldx.b #0x00           ;index into data table
  ldy.b #0x80           ;code for register 0, will increment
init_loop:
  lda TEXTMODE_INIT, X  ;get data from table
  sta VREG              ;write data
  nop                   ;cannot write too fast or VDP can't keep up!!!!
  sty VREG              ;write register identifier
  ;;Printouts for debugging -- warning; by enabling interrupts
  ;;we could wind up confusing the VDP! So you can use this to check
  ;;what values are in the 65816 registers as we go through the loop,
  ;;but there's no guarantee the VDP will be happy about this.
  ;cli         ;enable interrupts so monitor routines will work
  ;rep #0x10   ;monitor routines require 16-bit X/Y mode
  ;jsl $00e06c ;output hex byte in accumulator -- show data being writtem
  ;jsl $00e069 ;output space
  ;sep #0x10   ;go back to 8-bit X/Y mode
  ;txa         ;transfer x to a to see the register being written to
  ;rep #0x10   ;monitor routines require 16-bit X/Y mode
  ;jsl $00e06c ;output hex byte in accumulator -- show register being written to
  ;jsl $00e069 ;output space
  ;sep #0x10   ;go back into 8-bit X/Y mode
  ;sei         ;disable interrups again to avoid confusing VDP
  inx                    ;increment index into data table
  iny                    ;increment register code
  cpy.b #0x88            ;if we ran out of registers, exit loop
  bne init_loop

  ;still in X/Y 8 bit mode
  ;load pattern data for letter "A" in VRAM at 0x0000 in FIRST pattern spot
  lda.b #0x00               ;Low byte of VRAM address
  sta VREG
  lda.b #0x40               ;High byte of VRAM address ORed by 0x40
  sta VREG
  ldx.b #0x00               ;index into data table
pattern_loop:
  lda LETTER_DATA, x        ;fetch line of character
  sta VDATA                 ;store data in VRAM (address autoincrements)
  inx
  cpx.b #0x08               ;if we ran out of data, exit loop
  bne pattern_loop;         ;compare takes enough time that we don't need a nop

  ;fill screen 
  rep #0x10                ;Set X/Y to 16-bit
  ldx #960                 ;number of characters on screen (decimal)
  ;repeatedly load NAME for letter "A" (which is 0) in VRAM at 0x0800
  lda.b #0x00              ;Low byte of VRAM address
  sta VREG
  lda.b #0x48              ;High byte of VRAM address ORed by 0x40
  sta VREG
  lda.b #0x00              ;our "A" character is the first pattern in the pattern data
fill_loop:
  nop                      ;Can't write data to VDP too fast
  sta VDATA
  dex
  bne fill_loop

  ;testing READS from VDP
  ;move letter "A" data from VRAM at 0x0000 to 65C256 memory at 0x0200
  sep #0x10             ;Set X/Y to 8-bit
  lda.b #0x00           ;Low byte of VRAM address
  sta VREG
  lda.b #0x00           ;High byte of VRAM address -- read's don't have the OR with 0x40
  sta VREG
  ldx.b #0x00           ;index into data table on 65C256 side  
  nop                   ;If I leave out this nop the screen blanks!!!! It's like the VDP
                        ;gets confused even if you READ from VRAM too soon!
read_loop:
  lda VDATA             ;read data from VRAM (address autoincrements)
  sta 0x0200,X          ;store it in 65C256 memory
  inx
  cpx.b #0x08           ;if we ran out of data, exit loop
  bne read_loop         ;compare takes enough time that we don't need a nop

  brk

TEXTMODE_INIT:
  db 0x00 ;R0 = Text mode, no external video
  db 0xd0 ;R1 = 16K, Enable Display, Disable Interrupts
  db 0x02 ;R2 = Address of name table in VRAM = 0x0800
  db 0x80 ;R3 = Color table not used
  db 0x00 ;R4 = Register 4
  db 0x20 ;R5 = Address of Pattern Table in VRAM = 0x0000
  db 0x00 ;R6 = Register 6
  db 0xF1 ;R7 = White text on black background

LETTER_DATA:     ;Pattern data for letter "A", with extra long left side
  db 0b00100000  ;Note that in TEXT mode the rightmost 2 binary places are ignored
  db 0b01010000
  db 0b10001000
  db 0b10001000
  db 0b11111000
  db 0b10001000
  db 0b10001000
  db 0b10000000

