; =============================================================================
; Name: Wu, Yi
; Login: ywu014 (ywu014@ucr.edu)
; Email address: ywu014@ucr.edu
; Assignment: lab3_ex4
; Lab Section: 24
; TA: Wojtek Karas
;
; I hereby certify that the contents of this file are ENTIRELY my own original
; work.
; =============================================================================

.ORIG  x3000

LD       R1, PTR             


IN_LOOP  TRAP x20                ; get a character
         STR     R0, R1, #0      ; store the letter to remote memory
         ADD     R1, R1, #1      ; move to the next memory location
         ADD     R0, R0, #-10    ; if hit "enter", break
         BRnp    IN_LOOP

LD       R1, PTR                 ; reload pointer

LD       R0, NEWLINE
         TRAP x21                ; print in a new line

OUT_LOOP LDR      R0, R1, #0
         TRAP x21                ; print the letter in remote memory
         ADD      R1, R1, #1     ; move to the next letter
         BRp      OUT_LOOP       ; if the next memory stores "0", break

HALT
         
PTR       .FILL     x4000        ; pointer the remote memory location
COUNT     .FILL     #10
NEWLINE   .FILL     #10


.END