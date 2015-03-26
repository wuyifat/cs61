; =============================================================================
; Name: Wu, Yi
; Login: ywu014 (ywu014@ucr.edu)
; Email address: ywu014@ucr.edu
; Assignment: assn1
; Lab Section: 24
; TA: Wojtek Karas
;
; I hereby certify that the contents of this file are ENTIRELY my own original
; work.
; =============================================================================
; -----------------------------------------------------------------------------
; REG VALUES     R0     R1     R2     R3     R4     R5     R6     R7
; Pre-loop
; Iteration 01
; Iteration 02
; Iteration 03
; Iteration 04
; Iteration 05
; Iteration 06
; End of program
;-----------------------------------------------------------------------------------
; Subroutine: SUB_MAIN_30000
; Input: None.
; Postcondition: None.
; Return Value: None.
; -----------------------------------------------------------------------------
.ORIG x3000 ;start at memory address x3000
;------------------------------------------------------------------------------
;Instruction Block for SUB_MAIN_30000
;------------------------------------------------------------------------------
          LD R1, DEC_6      ;initialize values
          LD R2, DEC_12
          LD R3, DEC_0

DO_WHILE  ADD R3, R3, R2   ; multiply 12 by 6
          ADD R1, R1, #-1
          BRp DO_WHILE

HALT


DEC_0     .FILL #0
DEC_6     .FILL #6
DEC_12    .FILL #12
  
;------------------------------------------------------------------------------
;Data Block for SUB_MAIN_3000
;------------------------------------------------------------------------------
 MSG_TO_PRINT .STRINGZ "Hello world!!!\n"
;------------------------------------------------------------------------------
;End Subroutine: SUB_MAIN_3000
;------------------------------------------------------------------------------
.END ;stop reading source code