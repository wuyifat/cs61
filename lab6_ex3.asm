; =============================================================================
; Name: Wu, Yi
; Login: ywu014
; Email address: ywu014@ucr.edu
; Assignment: lab6_ex2
; Lab Section: 24
; TA: Wojtek Karas
;
; I hereby certify that the contents of this file are ENTIRELY my own original
; work.
; =============================================================================
          .ORIG x3000
          
          LEA  R0, ASK_FOR_INPUT             ; ask user to input the first number
          PUTS
          LD   R0, NEWLINE
          TRAP x21           
          TRAP x20                           ; get an input char and echo to the console
          TRAP x21
          
          LD   R6, SUB_COUNT_ONE_3200        ; count the number of binary 1's
          JSRR R6
          
          LD   R0, NEWLINE
          TRAP x21
          LEA  R0, RESULT                    ; print output 
          PUTS
          LD   R2, DEC48          
          ADD  R0, R1, R2                    ; convert the number to string, load to R0 for printing
          TRAP x21
HALT
          
          ASK_FOR_INPUT           .STRINGZ   "input a single character"
          RESULT                  .STRINGZ   "The number of 1's is: "
          NEWLINE                 .FILL      #10
          DEC48                   .FILL      #48
          
          SUB_COUNT_ONE_3200      .FILL   x3200
          
.END          

;-----------------------------------------------------------------------------
;Subroutine:    SUB_COUNT_ONE_3200
;Input (R0):    A character from input
;...
;Postcondition: R1 equals the number of binary 1's
;Return (R1):   the number of binary 1's in the input character
;-----------------------------------------------------------------------------
                .ORIG x3200
;-----------------------------------------------------------------------------
;Instruction Block
;-----------------------------------------------------------------------------
;(1) Backup all modified registers except the Return value

          ST R0, BACKUP_R0_3200
          ST R2, BACKUP_R2_3200
          ST R7, BACKUP_R7_3200

;(2) Algorithm

          LD     R2, DEC15_3200
          LD     R1, ZERO_3200
          
          ADD    R0, R0, #0                  ; check if the first digit is 1 by checking if the number is positive or negative
          BRp    LOOP_3200                   ; if positive, go ahead and check the second digit
          ADD    R1, R1, #1                  ; increment the 1's counter every time see a negative number
LOOP_3200
          ADD    R0, R0, R0                  ; left shift the number
          BRp    CONTINUE_3200
          ADD    R1, R1, #1
CONTINUE_3200
          ADD    R2, R2, #-1
          BRp    LOOP_3200
          

;(3) Restore registers

          LD R0, BACKUP_R0_3200
          LD R2, BACKUP_R2_3200
          LD R7, BACKUP_R7_3200
          
;(4) Return
                RET

;-----------------------------------------------------------------------------
;Data Block
;-----------------------------------------------------------------------------

          DEC15_3200    .FILL   #15
          ZERO_3200     .FILL   #0
          
          BACKUP_R0_3200   .BLKW   #1
          BACKUP_R2_3200   .BLKW   #1
          BACKUP_R7_3200   .BLKW   #1
          
;-----------------------------------------------------------------------------
;End Subroutine
;-----------------------------------------------------------------------------
.END
