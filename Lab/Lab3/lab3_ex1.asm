; =============================================================================
; Name: Wu, Yi
; Login: ywu014 (ywu014@ucr.edu)
; Email address: ywu014@ucr.edu
; Assignment: lab3_ex1
; Lab Section: 24
; TA: Wojtek Karas
;
; I hereby certify that the contents of this file are ENTIRELY my own original
; work.
; =============================================================================

	 .ORIG x3000

	 LD    R1, DATA_PTR       ; load number to R3
        LDR   R3, R1, #0
        ADD   R1, R1, #1         ; increment memory location by 1
        LDR   R4, R1, #0         ; load number to R4

	 ADD   R3, R3, #1         ; increment numbers by 1
	 ADD   R4, R4, #1

        LD    R1, DATA_PTR       ; store numbers back to x4000
	 STR   R3, R1, #0
        ADD   R1, R1, #0
	 STR   R4, R1, #0

	 HALT


DATA_PTR     .FILL     x4000

        .ORIG  x4000
DEC_65       .FILL     #65
HEX_41       .FILL     x41

.END