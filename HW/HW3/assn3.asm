; =============================================================================
; Name: Wu, Yi
; Login: ywu014
; Email address: ywu014@ucr.edu
; Assignment: assn3
; Lab Section: 24
; TA: Wojtek Karas
;
; I hereby certify that the contents of this file are ENTIRELY my own original
; work.
; =============================================================================
.ORIG x3000

LD     R2, COUNT_4                 ; loop counter for 4 sections
LD     R3, COUNT_4                 ; loop counter for 4 bits 
LD     R4, DEC48

LD     R1, HEX                     ; load hex number to R1
BRzp   PRINT0                      ; print 0 if first bit is 0, which makes the whole number non-negative
BRn    PRINT1                      ; print 1 if first bit is 1, which makes the whole number negative

LOOP   ADD     R1, R1, R1          ; shift bits to left
       BRzp    PRINT0              ; print the succesive bit
       BRn     PRINT1

FINISH
HALT

PRINT_SPACE     ADD     R2, R2, #-1   ; if space has been printed out 4 times, done. if not, print space
                BRnz    FINISH          
                LD      R3, COUNT_4   ; reset R3 = 4
                LD      R0, SPACE     ; print space
                TRAP x21
                ADD     R2, R2, #0    ; go back to loop
                BRp     LOOP

PRINT0          LD      R0, ZERO      ; load 0 to R0 and print
                ADD     R0, R0, R4    ; convert to ASCII
                TRAP x21
                ADD     R3, R3, #-1   ; if has printed out numbers 4 times, print space. if not, continue
                BRp     LOOP
                BRnz    PRINT_SPACE

PRINT1          LD      R0, ONE       ; load 1 to R0 and print
                ADD     R0, R0, R4    ; convert to ASCII
                TRAP x21
                ADD     R3, R3, #-1
                BRp     LOOP
                BRnz    PRINT_SPACE
                
                
COUNT_4  .FILL     #4
DEC48    .FILL     #48
ZERO     .FILL     #0
ONE      .FILL     #1
HEX      .FILL     xABCD
SPACE    .FILL     #32

.END
