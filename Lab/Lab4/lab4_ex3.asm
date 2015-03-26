; =============================================================================
; Name: Wu, Yi
; Login: ywu014 (ywu014@ucr.edu)
; Email address: ywu014@ucr.edu
; Assignment: lab4_ex3
; Lab Section: 24
; TA: Wojtek Karas
;
; I hereby certify that the contents of this file are ENTIRELY my own original
; work.
; =============================================================================

	 .ORIG x3000

LD     R1, PTR
LD     R3, COUNT
LD     R4, ONE                    ; increment R4's number every time, load that number to R1's address

LOOP   STR     R4, R1, #0         ; load R4 to R1's address
       ADD     R4, R4, R4
       ADD     R1, R1, #1         ; point to the next remote address
       ADD     R3, R3, #-1        ; decrease counter by 1
       BRp     LOOP

LD     R1, PTR                    ; reset R1 to point to x4000
LDR    R2, R1, #6                 ; load the seventh number to R2
       

HALT


PTR     .FILL     x4000
COUNT   .FILL     #10
ONE     .FILL     #1

     .ORIG  x4000
ARRAY      .BLKW       #10

.END
