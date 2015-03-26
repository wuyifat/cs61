; =============================================================================
; Name: Wu, Yi
; Login: ywu014 (ywu014@ucr.edu)
; Email address: ywu014@ucr.edu
; Assignment: lab4_ex2
; Lab Section: 24
; TA: Wojtek Karas
;
; I hereby certify that the contents of this file are ENTIRELY my own original
; work.
; =============================================================================

	 .ORIG x3000

LD     R1, PTR
LD     R2, DEC48
LD     R3, COUNT
LD     R4, ZERO                   ; increment R4's number every time, load that number to R1's address

LOOP   STR     R4, R1, #0         ; load R4 to R1's address
       ADD     R4, R4, #1
       ADD     R1, R1, #1         ; point to the next remote address
       ADD     R3, R3, #-1        ; decrease counter by 1
       BRp     LOOP

LD     R1, PTR
LD     R3, COUNT

PRINT  LDR     R0, R1, #0
       ADD     R0, R0, R2
       TRAP x21
       ADD     R1, R1, #1         ; point to the next remote address
       ADD     R3, R3, #-1        ; decrease counter by 1
       BRp     PRINT
       

HALT


PTR     .FILL     x4000
COUNT   .FILL     #10
ZERO    .FILL     #0
DEC48   .FILL     #48

     .ORIG  x4000
ARRAY      .BLKW       #10

.END
