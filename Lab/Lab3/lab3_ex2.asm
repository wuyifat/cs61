; =============================================================================
; Name: Wu, Yi
; Login: ywu014 (ywu014@ucr.edu)
; Email address: ywu014@ucr.edu
; Assignment: lab3_ex2
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

LOOP     TRAP x20            ; get a character
         TRAP x21            ; output the letter to console. not neccesory for this code
         STR     R0, R1, #0  ; store the number to remote memory
         ADD     R1, R1, #1  ; move the next memory location
         ADD     R2, R2, #-1 ; update counter
         BRp     LOOP

HALT
         
PTR       .FILL     x4000    ;  point to array
COUNT     .FILL     #10
PROMPT    .STRINGZ  "INPUT 10 LETTERS"

.ORIG  x4000
ARRAY     .BLKW     #10

.END