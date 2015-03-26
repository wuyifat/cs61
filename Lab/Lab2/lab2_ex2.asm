; =============================================================================
; Name: Wu, Yi
; Login: ywu014 (ywu014@ucr.edu)
; Email address: ywu014@ucr.edu
; Assignment: lab2
; Lab Section: 24
; TA: Wojtek Karas
;
; I hereby certify that the contents of this file are ENTIRELY my own original
; work.
; =============================================================================

	.ORIG x3000
;------------------------------------------------------------------------------


; ex2
	LDI   R3, DEC_65
	LDI   R4, HEX_41
	ADD   R3, R3, #1
	ADD   R4, R4, #1
	STI   R3, DEC_65
	STI   R4, HEX_41

	HALT

DEC_65     .FILL     x4000
HEX_41     .FILL     x4001
	
	.ORIG x4000

NEW_DEC_65 .FILL     #65
NEW_HEX_41 .FILL     x41

.END