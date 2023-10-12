PDD5 EQU 0xDF25
PD5 EQU 0xDF21
T1CL EQU 0xDF62
T1CH EQU 0xDF63
TER EQU 0xDF43
TIER EQU 0xDF46
IRQT1 EQU 0x124

.65816
.org 0x1000              

start:
 clc  ; set native mode
 xce
 sep #0x20 ; set Accumulator to 8 bit
 rep #0x10 ; set Index regs to 16 bit

 lda.b #0
 ldx #my_string
 jsl $00e04e

 lda.l PDD5
 ora.b #3
 sta.l PDD5	; pin51=output(select)
 lda.l PD5
 ora.b #3
 sta.l PD5

 lda.l 0xDF40 ;bcr0=1
 ora.b #1
 sta.l 0xDF40

loop:
 lda.l 0xDF00
 sta.l tmp
 lda.l tmp
 
 and.b #1
 bne down
 lda.b #0
 ldx #my_up
 jsl $00e04e

down:
 lda.l tmp
 and.b #2
 bne left
 lda.b #0
 ldx #my_down
 jsl $00e04e

left:
 lda.l tmp
 and.b #4
 bne right
 lda.b #0
 ldx #my_left
 jsl $00e04e

right:
 lda.l tmp
 and.b #8
 bne bbb
 lda.b #0
 ldx #my_right
 jsl $00e04e

bbb:
 lda.l tmp
 and.b #16
 bne ccc
 lda.b #0
 ldx #my_B
 jsl $00e04e

ccc:
 lda.l tmp
 and.b #32
 bne sss
 lda.b #0
 ldx #my_C
 jsl $00e04e


sss:
 lda.l PD5
 and.b #253
 sta.l PD5

 lda.l 0xDF00
 sta.l tmp
 lda.l tmp
 and.b #32
 bne aaa
 lda.b #0
 ldx #my_S
 jsl $00e04e

aaa:
 lda.l tmp
 and.b #16
 bne end
 lda.b #0
 ldx #my_A
 jsl $00e04e

end:
 lda.l PD5
 ora.b #3
 sta.l PD5

; second controller
 lda.l 0xDF01
 sta.l tmp
 lda.l tmp
 
 and.b #1
 bne down1
 lda.b #0
 ldx #my_up1
 jsl $00e04e

down1:
 lda.l tmp
 and.b #2
 bne left1
 lda.b #0
 ldx #my_down1
 jsl $00e04e

left1:
 lda.l tmp
 and.b #4
 bne right1
 lda.b #0
 ldx #my_left1
 jsl $00e04e

right1:
 lda.l tmp
 and.b #8
 bne bbb1
 lda.b #0
 ldx #my_right1
 jsl $00e04e

bbb1:
 lda.l tmp
 and.b #16
 bne ccc1
 lda.b #0
 ldx #my_B1
 jsl $00e04e

ccc1:
 lda.l tmp
 and.b #32
 bne sss1
 lda.b #0
 ldx #my_C1
 jsl $00e04e


sss1:
 lda.l PD5
 and.b #253
 sta.l PD5

 lda.l 0xDF01
 sta.l tmp
 lda.l tmp
 and.b #32
 bne aaa1
 lda.b #0
 ldx #my_S1
 jsl $00e04e

aaa1:
 lda.l tmp
 and.b #16
 bne end1
 lda.b #0
 ldx #my_A1
 jsl $00e04e

end1:
 lda.l PD5
 ora.b #3
 sta.l PD5
 
 jml loop

; .org 0x250
tmp: .db 0
my_string: .asciiz "Hello, world!"

my_up: .asciiz "U" ; stores a null-terminated string
my_down: .asciiz "D"
my_left: .asciiz "L"
my_right: .asciiz "R"
my_A: .asciiz "A"
my_B: .asciiz "B"
my_C: .asciiz "C"
my_S: .asciiz "S"
my_E: .asciiz "E"

my_up1: .asciiz "u" ; stores a null-terminated string
my_down1: .asciiz "d"
my_left1: .asciiz "l"
my_right1: .asciiz "r"
my_A1: .asciiz "a"
my_B1: .asciiz "b"
my_C1: .asciiz "c"
my_S1: .asciiz "s"
my_E1: .asciiz "e"