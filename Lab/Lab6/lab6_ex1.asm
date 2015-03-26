; =============================================================================
; Name: Wu, Yi
; Login: ywu014
; Email address: ywu014@ucr.edu
; Assignment: lab6_ex1
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
          LD   R6, SUB_INPUT_3200            ; store the input number to R1
          JSRR R6
          
          ADD  R1, R1, #1                    ; add input number by 1
          
          LD   R6, SUB_PRINT_3400            ; print out number to console
          JSRR R6
          
HALT

          NEWLINE                 .FILL   #10
          ASK_FOR_INPUT           .STRINGZ   "input a positive decimal number under 32767"
          
          SUB_INPUT_3200          .FILL   x3200
          SUB_PRINT_3400          .FILL   x3400
.END          
;-----------------------------------------------------------------------------
;Subroutine:    SUB_INPUT_3200
;Input (R0):    input from keyboard
;...
;Postcondition: store input number to R1
;Return (R1):   R1 <-- keyboard input number
;-----------------------------------------------------------------------------
                .ORIG x3200
;-----------------------------------------------------------------------------
;Instruction Block
;-----------------------------------------------------------------------------
;(1) Backup all modified registers except the Return value

          ST R0, BACKUP_R0_3200
          ST R3, BACKUP_R3_3200
          ST R4, BACKUP_R4_3200
          ST R7, BACKUP_R7_3200

;(2) Algorithm

          LD     R1, ZERO                    ; reset registers
          
LOOP      TRAP x20    
          TRAP x21
          
          ADD    R4, R0, #-10                ; if input "enter", finish input
          BRz    FINISH_3200
          
          LD     R3, DEC_48                  ; calculate input number
          ADD    R0, R0, R3
          BR     MULTI10                     ; R1 = 10 * R1 + R0
DONE10          
          ADD    R1, R1, R0
          BR     LOOP
                    
MULTI10   LD     R3, DEC9                    ; add R1 to itself 9 times
          ADD    R4, R1, #0                    
          REPEAT ADD   R1, R1, R4
                 ADD   R3, R3, #-1
                 BRp   REPEAT
          BR     DONE10

FINISH_3200          

;(3) Restore registers

          LD R0, BACKUP_R0_3200
          LD R3, BACKUP_R3_3200
          LD R4, BACKUP_R4_3200
          LD R7, BACKUP_R7_3200
          
;(4) Return
                RET

;-----------------------------------------------------------------------------
;Data Block
;-----------------------------------------------------------------------------

          ZERO     .FILL   #0
          DEC9     .FILL   #9
          DEC_48   .FILL   #-48
          
          BACKUP_R0_3200   .BLKW   #1
          BACKUP_R3_3200   .BLKW   #1
          BACKUP_R4_3200   .BLKW   #1
          BACKUP_R7_3200   .BLKW   #1
          
;-----------------------------------------------------------------------------
;End Subroutine
;-----------------------------------------------------------------------------
.END

;-----------------------------------------------------------------------------
;Subroutine:    SUB_PRINT_3400
;Input (R1):    the number stored in R1
;Postcondition: R1's content is printed to the console
;Return (none):   
;-----------------------------------------------------------------------------
                .ORIG x3400
;-----------------------------------------------------------------------------
;Instruction Block
;-----------------------------------------------------------------------------
;(1) Backup all modified registers except the Return value

          ST R0, BACKUP_R0_3400
          ST R1, BACKUP_R1_3400
          ST R2, BACKUP_R2_3400
          ST R3, BACKUP_R3_3400
          ST R6, BACKUP_R6_3400
          ST R7, BACKUP_R7_3400

;(2) Algorithm
          LD   R3, ZERO_3400                 ; R3 indicates if any effective print before
          
          LD   R2, N_FIFTH                   ; print the digit on ten-thousand
          LD   R6, SUB_PRINT_DIGIT_3600
          JSRR R6
          LD   R2, P_FIFTH                   ; make R1 positive again by adding back 10,000
          ADD  R1, R1, R2
          
          LD   R2, N_FORTH                   ; print the digit on thousand
          LD   R6, SUB_PRINT_DIGIT_3600
          JSRR R6
          LD   R2, P_FORTH
          ADD  R1, R1, R2
          
          LD   R2, N_THIRD                   ; print the digit on hundred
          LD   R6, SUB_PRINT_DIGIT_3600
          JSRR R6
          LD   R2, P_THIRD
          ADD  R1, R1, R2
          
          LD   R2, N_SECOND                  ; print the digit on ten
          LD   R6, SUB_PRINT_DIGIT_3600
          JSRR R6
          LD   R2, P_SECOND
          ADD  R1, R1, R2
          
          LD   R2, N_FIRST                   ; print the digit on one
          LD   R6, SUB_PRINT_DIGIT_3600
          JSRR R6
          LD   R2, P_FIRST
          ADD  R1, R1, R2
          
          
;(3) Restore registers

          LD   R0, BACKUP_R0_3400
          LD   R1, BACKUP_R1_3400
          LD   R2, BACKUP_R2_3400
          LD   R3, BACKUP_R3_3400
          LD   R6, BACKUP_R6_3400
          LD   R7, BACKUP_R7_3400

;(4) Return
                RET

;-----------------------------------------------------------------------------
;Data Block
;-----------------------------------------------------------------------------
          ZERO_3400     .FILL   #0                  
          N_FIFTH                 .FILL   #-10000
          N_FORTH                 .FILL   #-1000
          N_THIRD                 .FILL   #-100
          N_SECOND                .FILL   #-10
          N_FIRST                 .FILL   #-1
          P_FIFTH                 .FILL   #10000
          P_FORTH                 .FILL   #1000
          P_THIRD                 .FILL   #100
          P_SECOND                .FILL   #10
          P_FIRST                 .FILL   #1
                    
          BACKUP_R0_3400   .BLKW   #1
          BACKUP_R1_3400   .BLKW   #1
          BACKUP_R2_3400   .BLKW   #1
          BACKUP_R3_3400   .BLKW   #1
          BACKUP_R6_3400   .BLKW   #1
          BACKUP_R7_3400   .BLKW   #1
          
          SUB_PRINT_DIGIT_3600   .FILL   x3600

;-----------------------------------------------------------------------------
;End Subroutine
;-----------------------------------------------------------------------------
.END

;-----------------------------------------------------------------------------
;Subroutine:    SUB_PRINT_DIGIT_3600
;Input (R1, R2, R3):   R1 is the number to be print, R3 indicates if any number is printed before
;...                   R2 is the highest weight
;Postcondition: print the first decimal digit of R1 to console. R1 becomes a negative number.
;               R3 remains 0 if still no effective number printed. R3 becomes 1 if print a number.
;Return (R1, R3):  return R1 as a negative number when consectively substracting the highest weight.
;                  R3 indicates if this digit is one of the leading zeros.
;-----------------------------------------------------------------------------
                .ORIG x3600
;-----------------------------------------------------------------------------
;Instruction Block
;-----------------------------------------------------------------------------
;(1) Backup all modified registers except the Return value

          ST R0, BACKUP_R0_3600
          ST R2, BACKUP_R2_3600
          ST R4, BACKUP_R4_3600
          ST R5, BACKUP_R5_3600
          ST R7, BACKUP_R7_3600

;(2) Algorithm
          
          LD    R4, ZERO_3600                ; reset counter
LOOP_3600                                    ; keep substracting the highest number until R1 becomes negative
          ADD   R1, R1, R2
          BRn   DONE_LOOP_3600               ; if R1 becomes negative, break
          ADD   R4, R4, #1                   ; increment counter
          BR    LOOP_3600
DONE_LOOP_3600
          ADD   R0, R3, R4                   ; if no number has been printed before and this is a zero
          BRz   DONE_3600                    ; don't print anything. Otherwise print the counter
          LD    R5, DEC48_3600
          ADD   R0, R4, R5
          TRAP x21
          LD    R3, ONE_3600                 ; record this one as an effective output by setting R3 = 1
DONE_3600

;(3) Restore registers

          LD R0, BACKUP_R0_3600
          LD R2, BACKUP_R2_3600
          LD R4, BACKUP_R4_3600
          LD R5, BACKUP_R5_3600
          LD R7, BACKUP_R7_3600
          
;(4) Return
                RET

;-----------------------------------------------------------------------------
;Data Block
;-----------------------------------------------------------------------------

          ZERO_3600     .FILL   #0
          ONE_3600      .FILL   #1
          DEC48_3600    .FILL   #48
          
          BACKUP_R0_3600   .BLKW   #1
          BACKUP_R2_3600   .BLKW   #1
          BACKUP_R4_3600   .BLKW   #1
          BACKUP_R5_3600   .BLKW   #1
          BACKUP_R7_3600   .BLKW   #1
          
;-----------------------------------------------------------------------------
;End Subroutine
;-----------------------------------------------------------------------------
.END
