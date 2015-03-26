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

	LD    R5, DEC_65
	LD    R6, HEX_41
	LDR   R3, R5, #0
	LDR   R4, R6, #0
	ADD   R3, R3, #1
	ADD   R4, R4, #1
	STR   R3, R5, #0
	STR   R4, R6, #0

	HALT

DEC_65     .FILL     x4000
HEX_41     .FILL     x4001

LABEL_x61  .FILL     x61
LABEL_x1A  .FILL     x1A

.ORIG x4000

NEW_DEC_65 .FILL     #65
NEW_HEX_41 .FILL     x41

.END