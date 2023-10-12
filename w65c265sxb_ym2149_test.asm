; YM2149 test code by Daniel Geng

.65816
.org 0x1000

;ports for sound chip
;YMDATAA EQU 0xdf10
;YMREGA EQU 0xdf11
;YMDATAB EQU 0xdf12
;YMREGB EQU 0xdf13


start:
  clc ; set native mode
  xce

  sep #0x20 ; set Accumulator to 8 bit
  rep #0x10 ; set Index regs to 16 bit

  lda.b #0x01
  sta 0xdf40 ; BCR0 = 1

mainA:
  lda.b #0x07 ;I/O port and mixer Settings
  sta YMREGA
  lda.b #0x3e ;Enable Channel A Tone Generator
  sta YMDATAA
  lda.b #0x08 ;Channel A volume
  sta YMREGA
  lda.b #0x0f ;Max volume
  sta YMDATAA

mainB:
  lda.b #0x07 ;I/O port and mixer Settings
  sta YMREGB
  lda.b #0x3e ;Enable Channel A Tone Generator
  sta YMDATAB
  lda.b #0x08 ;Channel A volume
  sta YMREGB
  lda.b #0x0f ;Max volume
  sta YMDATAB


init:
  ldx #0x01 ;Set countB to 1
  stx COUNTB
  ldx #0x07 ;Set countA to 7
  stx COUNTA

loop:
 lda.b #0
 ldx #tone_string
 jsl $00e04e


  ldx COUNTA
  jsr playA  ;play sound
    ldx COUNTB
  jsr playB  ;play sound

  jsr delay

  ldx COUNTB ;
  inx      ;increment COUNTB
  stx COUNTB

  ldx COUNTA
  dex       ;decrement countA
  stx COUNTA
  bne loop  ;play next sound
  jmp init  ;restart loop

playA:
  lda.b #0x00 ;Register 0
  sta YMREGA

  lda NOTESF,X ;Fine Tone
  sta YMDATAA

  lda.b #0x01 ;Register 1
  sta YMREGA

  lda NOTESC,X ;Coarse Tone
  sta YMDATAA

  rts

playB:
  lda.b #0x00 ;Register 0
  sta YMREGB

  lda NOTESF,X ;Fine Tone
  sta YMDATAB

  lda.b #0x01 ;Register 1
  sta YMREGB

  lda NOTESC,X ;Coarse Tone
  sta YMDATAB

  rts

delay:
  ldy #0x5f
delay_outer:
  ldx #0x1000
delay_inner:
  dex
  bne delay_inner
  dey
  bne delay_outer
  rts

NOTESF:
  db 0x00,0xe9,0x07,0x27,0x4b,0x5e,0x89,0xb9 ;B4 to C4 Fine Tone

NOTESC:
  db 0x00,0x00,0x01,0x01,0x01,0x01,0x01,0x01 ;B4 to C4 Course Tone

COUNTA:
  dw 0

COUNTB:
  dw 0

tone_string: .asciiz "Tone" ; stores a null-terminated string
