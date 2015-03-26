; =============================================================================
; Name: Wu, Yi
; Login: ywu014 (ywu014@ucr.edu)
; Email address: ywu014@ucr.edu
; Assignment: lab5_ex2
; Lab Section: 24
; TA: Wojtek Karas
;
; I hereby certify that the contents of this file are ENTIRELY my own original
; work.
; =============================================================================

;-----------------------------------------------------------------------------
;Subroutine:    SUB_INPUT_3200
;Parameter (R0):    input from keyboard
;Postcondition: R1 holds the entire input
;Return (R1):   total input number
;...
;-----------------------------------------------------------------------------
                .ORIG x3200
;-----------------------------------------------------------------------------
;Instruction Block for SUB_TEMPLATE_3200
;-----------------------------------------------------------------------------
;(1) Backup all modified registers except the Return value

ST R0, BACKUP_R0_3200
ST R2, BACKUP_R2_3200
ST R7, BACKUP_R7_3200

;(2) Algorithm: print binary representation of number in R2

LD  R1, ZERO
LD  R2, COUNT
LEA PROMPT
PUTS

LOOP   TRAP x20
       ADD R1, R1, R1
       ADD R1, R1, R0
       ADD R2, R2, #-1
       BRp LOOP
       
HALT

;(3) Restore registers

LD R0, BACKUP_R0_3200
LD R2, BACKUP_R2_3200
LD R7, BACKUP_R7_3200

;(4) Return
                RET

;-----------------------------------------------------------------------------
;Data Block for SUB_TEMPLATE_3200
;-----------------------------------------------------------------------------

ZERO     .FILL #0
COUNT    .FILL #16
PROMPT   .STRINGZ  "input 16-bit 2's compliment binary number staring with 'b   '"

BACKUP_R0_3200     .BLKW #1
BACKUP_R2_3200     .BLKW #1
BACKUP_R7_3200     .BLKW #1


;-----------------------------------------------------------------------------
;End Subroutine: SUB_TEMPLATE_3200
;-----------------------------------------------------------------------------
