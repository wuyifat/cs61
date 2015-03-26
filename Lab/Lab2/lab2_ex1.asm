; =============================================================================
; Name: Wu, Yi
; Login: ywu014 (ywu014@ucr.edu)
; Email address: ywu014@ucr.edu
; Assignment: lab2_ex1
; Lab Section: 24
; TA: Wojtek Karas
;
; I hereby certify that the contents of this file are ENTIRELY my own original
; work.
; =============================================================================
	.ORIG  x3000

	LD  R3, DEC_65
	LD  R4, HEX_41

	HALT

DEC_65  .FILL  #65
HEX_41  .FILL  x41

.END