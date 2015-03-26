; =============================================================================
; Name: Wu, Yi
; Login: ywu014
; Email address: ywu014@ucr.edu
; Assignment: lab6_ex3
; Lab Section: 24
; TA: Wojtek Karas
;
; I hereby certify that the contents of this file are ENTIRELY my own original
; work.
; =============================================================================
          .ORIG x3000
          
          LD   R1, NUMBER
          
          LD   R6, SUB_RIGHT_SHIFT_3200        ; right shift the number while keeping the sign
          JSRR R6
HALT
          
          NUMBER                  .FILL   #-15
          
          SUB_RIGHT_SHIFT_3200    .FILL   x3200
          
.END          

;-----------------------------------------------------------------------------
;Subroutine:    SUB_RIGHT_SHIFT_3200
;Input (R1):    A number
;...
;Postcondition: R2 equals right-shifted number of R1
;Return (R2):   right-shifted number of R1
;-----------------------------------------------------------------------------
                .ORIG x3200
;-----------------------------------------------------------------------------
;Instruction Block
;-----------------------------------------------------------------------------
;(1) Backup all modified registers except the Return value

          ST R0, BACKUP_R0_3200
          ST R1, BACKUP_R1_3200
          ST R3, BACKUP_R3_3200
          ST R4, BACKUP_R4_3200
          ST R5, BACKUP_R5_3200
          ST R7, BACKUP_R7_3200

;(2) Algorithm

          LD     R5, ZERO_3200               ; R5 record the sign of input number, preset to 0
          LD     R3, DEC15_3200
          ADD    R2, R1, #0                  ; transfer R1 number to R2
          BRp    LOOP_3200
          LD     R5, ONE_3200                ; if input number is negative, set R5 to 1
          
LOOP_3200
          ADD    R2, R2, #0
          BRp    POS_3200                    ; record the first digit
          BRn    NEG_3200                    ; positive means 0, negative means 1
CONTINUE_3200
          ADD    R2, R2, R2                  ; left shift number
          ADD    R2, R2, R4                  ; add the shifted digit to the end
          ADD    R3, R3, #-1                 ; update counter, do it 15 times
          BRp    LOOP_3200
          BRz    DONE1_3200     
               
POS_3200  LD     R4, ZERO_3200               ; record the digit shifted out as 0
          BR     CONTINUE_3200
          
NEG_3200  LD     R4, ONE_3200                ; record the digit shifted out as 1
          BR     CONTINUE_3200
          
DONE1_3200          
          ADD    R5, R5, #0                  ; remind the sign of input number and go to the branch accordingly
          BRz    POS1_3200
          BRp    NEG1_3200
NEG1_3200
          LD     R5, NEG_SIGN_3200           ; R5 = x8000, R2 = R2 + R5 to keep the sign negative
          NOT    R2, R2
          NOT    R5, R5
          AND    R2, R2, R5
          NOT    R2, R2
          BR     DONE_3200
          
POS1_3200
          LD     R5, POS_SIGN_3200           ; R5 = x7FFF, R2 = R2 AND R5 to keep the sign positive
          AND    R2, R2, R5

DONE_3200
          

;(3) Restore registers

          LD R0, BACKUP_R0_3200
          LD R1, BACKUP_R1_3200
          LD R3, BACKUP_R3_3200
          LD R4, BACKUP_R4_3200
          LD R5, BACKUP_R5_3200
          LD R7, BACKUP_R7_3200
          
;(4) Return
                RET

;-----------------------------------------------------------------------------
;Data Block
;-----------------------------------------------------------------------------

          DEC15_3200       .FILL   #15
          ZERO_3200        .FILL   #0
          ONE_3200         .FILL   #1
          NEG_SIGN_3200    .FILL   x8000
          POS_SIGN_3200    .FILL   x7FFF
          
          BACKUP_R0_3200   .BLKW   #1
          BACKUP_R1_3200   .BLKW   #1
          BACKUP_R3_3200   .BLKW   #1
          BACKUP_R4_3200   .BLKW   #1
          BACKUP_R5_3200   .BLKW   #1
          BACKUP_R7_3200   .BLKW   #1
          
;-----------------------------------------------------------------------------
;End Subroutine
;-----------------------------------------------------------------------------
.END
