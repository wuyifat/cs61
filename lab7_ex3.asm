; =============================================================================
; Name: Wu, Yi
; Login: ywu014
; Email address: ywu014@ucr.edu
; Assignment: lab7_ex2
; Lab Section: 24
; TA: Wojtek Karas
;
; I hereby certify that the contents of this file are ENTIRELY my own original
; work.
; =============================================================================
          .ORIG x3000
          
          LD    R0, ADDRESS
          LD    R6, SUB_GET_STRING
          JSRR  R6
          
          LD    R6, SUB_IS_A_PALINDROME
          JSRR  R6
HALT

          ADDRESS                 .FILL   x4000
          SUB_GET_STRING          .FILL   x3200
          SUB_IS_A_PALINDROME     .FILL   x3400
.END          
;-----------------------------------------------------------------------------
;Subroutine:    SUB_GET_STRING
;Input (R0):    the address of where to start storing the string
;Postcondition: The subroutine has allowed the user to input a string,
;               terminated by the [ENTER] key, and has stored it in an
;               array that starts at (R0) and is NULL-terminated
;Return (R1):   R5 <- The number of non-sentinel characters read from the user
;-----------------------------------------------------------------------------
                .ORIG x3200
;-----------------------------------------------------------------------------
;Instruction Block
;-----------------------------------------------------------------------------
;(1) Backup all modified registers except the Return value

          ST R0, BACKUP_R0_3200
          ST R1, BACKUP_R1_3200
          ST R2, BACKUP_R2_3200
          ST R7, BACKUP_R7_3200

;(2) Algorithm

          LD     R1, BACKUP_R0_3200          ; R1 holds the address write strings to
          LD     R5, DEC0_3200               ; initiate counter
          LEA    R0, INPUT_PROMPT_3200
          PUTS
          LD     R0, NEWLINE_3200
          TRAP x21
          
INPUT_LOOP_3200          
          TRAP x20
          TRAP x21
          ADD    R2, R0, #-10                ; if input "ENTER", finish input
          BRz    DONE_INPUT_3200
          STR    R0, R1, #0                  ; store the char to (R1)
          ADD    R1, R1, #1                  ; point to the next memory location
          ADD    R5, R5, #1                  ; increment counter
          BR     INPUT_LOOP_3200
DONE_INPUT_3200          

          ADD    R1, R1, #1                  ; add 0 to the end of string
          LD     R0, DEC0_3200
          STR    R0, R1, #0
          
          LD     R0, NEWLINE_3200
          TRAP x21

;(3) Restore registers

          LD R0, BACKUP_R0_3200
          LD R1, BACKUP_R1_3200
          LD R2, BACKUP_R2_3200
          LD R7, BACKUP_R7_3200
          
;(4) Return
                RET

;-----------------------------------------------------------------------------
;Data Block
;-----------------------------------------------------------------------------

          DEC0_3200     .FILL   #0
          NEWLINE_3200  .FILL   #10
          INPUT_PROMPT_3200    .STRINGZ   "input a string, end with hitting enter"
          
          BACKUP_R0_3200   .BLKW   #1
          BACKUP_R1_3200   .BLKW   #1
          BACKUP_R2_3200   .BLKW   #1
          BACKUP_R7_3200   .BLKW   #1
          
;-----------------------------------------------------------------------------
;End Subroutine
;-----------------------------------------------------------------------------
.END

;-----------------------------------------------------------------------------
;Subroutine: SUB_IS_A_PALINDROME
;Parameter (R0): The address of a string
;Parameter (R5): The number of characters in the array
;Postcondition: The subroutine has determined whether the string at (R0)
;               is a palindrome or not returned a flag indicating such
;Return (R4):  R4 <- 1 if the string is a palindrome, 0 otherwise
;...
;-----------------------------------------------------------------------------
                .ORIG x3400
;-----------------------------------------------------------------------------
;Instruction Block
;-----------------------------------------------------------------------------
;(1) Backup all modified registers except the Return value

          ST R0, BACKUP_R0_3400
          ST R2, BACKUP_R2_3400
          ST R3, BACKUP_R3_3400
          ST R5, BACKUP_R5_3400
          ST R6, BACKUP_R6_3400
          ST R7, BACKUP_R7_3400

;(2) Algorithm

          LD     R4, DEC1_3400               ; pre-set R4 = 1. ie. presume it's a palindrome
          ADD    R6, R0, R5                  ; point R6 to the end of the string
          ADD    R6, R6, #-1
          
COMPARE_LOOP_3400          
; compute R6 - R0, if not positive, finish compare loop
          ADD    R2, R0, #0                  ; R2 = -R0
          NOT    R2, R2
          ADD    R2, R2, #1
          ADD    R3, R2, R6                  ; R3 = R6 - R0
          BRnz   DONE_3400
; compare (R0) and (R6), if not equal, the string is not palindrome          
          LDR    R2, R0, #0                  ; R2 <- (R0)
          LDR    R3, R6, #0                  ; R3 <- (R6)
          NOT    R3, R3                      ; compute R2 - R3, if not 0, it's not a palindrome
          ADD    R3, R3, #1
          ADD    R2, R2, R3
          BRnp    NOT_PALINDROME
          ADD    R0, R0, #1                  ; move R0 and R6 both to the middle, compare the next pair
          ADD    R6, R6, #-1
          BR     COMPARE_LOOP_3400
             
NOT_PALINDROME                               ; change R4 to 0 if string isn't a palindrome
          LD     R4, DEC0_3400
          
DONE_3400
;(3) Restore registers

          LD R0, BACKUP_R0_3400
          LD R2, BACKUP_R2_3400
          LD R3, BACKUP_R3_3400
          LD R5, BACKUP_R5_3400
          LD R6, BACKUP_R6_3400
          LD R7, BACKUP_R7_3400

;(4) Return
                RET

;-----------------------------------------------------------------------------
;Data Block
;-----------------------------------------------------------------------------
      
          DEC0_3400        .FILL   #0
          DEC1_3400        .FILL   #1
          
          BACKUP_R0_3400   .BLKW   #1
          BACKUP_R2_3400   .BLKW   #1
          BACKUP_R3_3400   .BLKW   #1
          BACKUP_R5_3400   .BLKW   #1
          BACKUP_R6_3400   .BLKW   #1
          BACKUP_R7_3400   .BLKW   #1

;-----------------------------------------------------------------------------
;End Subroutine
;-----------------------------------------------------------------------------
.END
