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

REPEAT	TRAP x20
	TRAP x21
	BRnzp REPEAT

	HALT

.END