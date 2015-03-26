; =============================================================================
; Name: Wu, Yi
; Login: ywu014 (ywu014@ucr.edu)
; Email address: ywu014@ucr.edu
; Assignment: lab3_ex3
; Lab Section: 24
; TA: Wojtek Karas
;
; I hereby certify that the contents of this file are ENTIRELY my own original
; work.
; =============================================================================

.ORIG  x3000

LD       R1, PTR             
LD       R2, COUNT
LEA      R0, PROMPT
PUTS



IN_LOOP  TRAP x20            ; get a letter
         STR     R0, R1, #0  ; store the letter to remote memory
         ADD     R1, R1, #1  ; move to the next memory location
         ADD     R2, R2, #-1 ; update counter
         BRp     IN_LOOP

LD       R1, PTR             ; reload the pointer
LD       R2, COUNT           ; reset counter

LD       R0, NEWLINE
         TRAP x21            ; start to output from a new line

OUT_LOOP LDR     R0, R1, #0
         TRAP x21            ; print a letter
         LD      R0, NEWLINE
         TRAP x21            ; print an empty line
         ADD     R1, R1, #1  ; move to the next letter location
         ADD     R2, R2, #-1 ; update the counter
         BRp     OUT_LOOP

HALT
         
PTR       .FILL     x4000 ;  point to array
COUNT     .FILL     #10
PROMPT    .STRINGZ  "INPUT 10 LETTERS"
NEWLINE   .FILL     #10

.ORIG  x4000
ARRAY     .BLKW     #10

.END
