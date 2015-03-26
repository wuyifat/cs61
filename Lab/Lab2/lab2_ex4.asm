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

	LD   R0, LABEL_x61
	LD   R1, LABEL_x1A
LOOP    OUT
	ADD  R0, R0, #1
	ADD  R1, R1, #-1
	BRp  LOOP

	HALT

LABEL_x61  .FILL     x61
LABEL_x1A  .FILL     x1A

.END