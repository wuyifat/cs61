; =============================================================================
; Name: Wu, Yi
; Login: ywu014
; Email address: ywu014@ucr.edu
; Assignment: assn5
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
          
          ADD  R3, R1, #0                    ; transfer number to R3
          ADD  R4, R2, #0                    ; transfer sign to R4
          
          LEA  R0, ASK_FOR_INPUT             ; ask user to input the second number
          PUTS
          LD   R0, NEWLINE
          TRAP x21
          LD   R6, SUB_INPUT_3200            ; store the input number to R1
          JSRR R6
          
          LD   R6, SUB_MULTIPLY_3400         ; compute R1 = R1 * R2
          JSRR R6
          
          ADD  R2, R2, #0                    ; if overflow or underflow, don't print numbers
          BRz  FINISH_3000
          
          LD   R0, NEWLINE                   ; print result to console
          TRAP x21
          LEA  R0, RESULT
          PUTS
          ADD  R2, R2, #0                    ; Print sign
          BRn  PRINT_MINUS
          BRzp PRINT_PLUS
PRINT_CONTINUE
          LD   R3, ASC0
          LD   R0, ZERO_3000
          LD   R2, N_FIFTH                   ; R1 - 10000, count how many times to get negative
LOOP5     ADD  R1, R1, R2
          BRn  DONE_FIFTH
          ADD  R0, R0, #1                    ; R0 stores the number of time, print out
          BR   LOOP5
DONE_FIFTH          
          ADD  R0, R0, R3
          TRAP x21
FIX_FIFTH          
          LD   R2, P_FIFTH                   ; add 10000 back to make R1 positive
          ADD  R1, R1, R2 

          LD   R0, ZERO_3000
          LD   R2, N_FORTH                   ; R1 - 1000, count how many times to get negative
LOOP4     ADD  R1, R1, R2
          BRn  DONE_FORTH
          ADD  R0, R0, #1                    ; print out R0, which stores the # of time
          BR   LOOP4
DONE_FORTH          
          ADD  R0, R3, R0
          TRAP x21
FIX_FORTH          
          LD   R2, P_FORTH                   ; add 1000 back to make R1 positive
          ADD  R1, R1, R2 
          
          LD   R0, ZERO_3000
          LD   R2, N_THIRD                   ; R1 - 100, count how many times to get negative
LOOP3     ADD  R1, R1, R2
          BRn  DONE_THIRD
          ADD  R0, R0, #1                    ; print out R0, which stores the # of time
          BR   LOOP3
DONE_THIRD          
          ADD  R0, R3, R0
          TRAP x21
FIX_THIRD          
          LD   R2, P_THIRD                   ; add 100 back to make R1 positive
          ADD  R1, R1, R2 

          LD   R0, ZERO_3000          
          LD   R2, N_SECOND                  ; R1 - 10, count how many times to get negative
LOOP2     ADD  R1, R1, R2
          BRn  DONE_SECOND
          ADD  R0, R0, #1                    ; print out R0, which stores the # of times
          BR   LOOP2
DONE_SECOND          
          ADD  R0, R3, R0
          TRAP x21
FIX_SECOND
          LD   R2, P_SECOND                  ; add 10 back to make R1 positive
          ADD  R1, R1, R2 
          
          LD   R0, ZERO_3000
          LD   R2, N_FIRST                   ; R1 - 1, count how many times to get negative
LOOP1     ADD  R1, R1, R2
          BRn  DONE_FIRST
          ADD  R0, R0, #1                    ; print out R0, which stores the # of times
          BR   LOOP1
DONE_FIRST          
          ADD  R0, R3, R0
          TRAP x21
          
FINISH_3000
HALT

PRINT_MINUS
          LD   R0, ASC_MINUS
          TRAP x21
          BR   PRINT_CONTINUE
          
PRINT_PLUS
          LD   R0, ASC_PLUS
          TRAP x21
          BR   PRINT_CONTINUE
          
          ZERO_3000               .FILL   #0
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
          NEWLINE                 .FILL   #10
          ASC_PLUS                .FILL   #43
          ASC_MINUS               .FILL   #45
          ASC0                    .FILL   #48
          ASK_FOR_INPUT           .STRINGZ   "input a decimal number between -32767 and +32767"
          RESULT                  .STRINGZ   "Result is: "
          
          SUB_INPUT_3200          .FILL   x3200
          SUB_MULTIPLY_3400       .FILL   x3400
.END          
;-----------------------------------------------------------------------------
;Subroutine:    SUB_INPUT_3200
;Input (R0):    input from keyboard
;...
;Postcondition: store input number to R1, sign to R2
;Return (R1, R2):   R1 <-- keyboard input number
;...                R2 <-- input's sign
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
          LD     R2, ONE
          
LOOP      TRAP x20    
          TRAP x21
          
          ADD    R4, R0, #-10                ; if input "enter", finish input
          BRz    FINISH_3200
          
          LD     R3, DEC_43                  ; if input "+", ignore
          ADD    R4, R0, R3
          BRz    LOOP
          
          LD     R3, DEC_45                  ; if input "-", change R2 to -2
          ADD    R4, R0, R3
          BRz    MINUS
          
          LD     R3, DEC_48                  ; calculate input number
          ADD    R0, R0, R3
          BR     MULTI10                     ; R1 = 10 * R1 + R0
DONE10          
          ADD    R1, R1, R0
          BR     LOOP
          
          
MINUS     LD     R2, DEC_4                   ; change R2 to -4
          BR     LOOP
          
                    
MULTI10   LD     R3, DEC9
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

          DEC_4    .FILL   #-4
          ZERO     .FILL   #0
          ONE      .FILL   #1
          DEC9     .FILL   #9
          DEC_43   .FILL   #-43
          DEC_45   .FILL   #-45
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
;Subroutine:    SUB_MULTIPLY_3400
;Input (R1, R2, R3, R4):two numbers to be multiplied along with their signs
;...                    R1, R3 are two numbers, R2, R4 are two signs
;Postcondition: R1 = R1 * R3, R2 stores the sign
;Return (R1, R2):   returns R1 = R1 * R3
;...                R2 = 1 if positive, R2 = -1 if negative
;                   returns R2 = 0 if overflow or underflow
;-----------------------------------------------------------------------------
                .ORIG x3400
;-----------------------------------------------------------------------------
;Instruction Block
;-----------------------------------------------------------------------------
;(1) Backup all modified registers except the Return value

          ST R0, BACKUP_R0_3400
          ST R3, BACKUP_R3_3400
          ST R4, BACKUP_R4_3400
          ST R5, BACKUP_R5_3400
          ST R7, BACKUP_R7_3400

;(2) Algorithm
          NOT    R5, R3                      ; R5 = -R3
          ADD    R5, R5, #1
          ADD    R5, R1, R5                  ; R5 = R1 - R3
          BRzp   CHECK_ZERO                  ; use smaller number, R3, as loop counter
          BRn    EXCHANGE                    ; exchange R1 and R3 if R3 > R1
          
EXCHANGE  
          ADD    R6, R3, #0                  ; exchange R1 and R3 values
          ADD    R3, R1, #0
          ADD    R1, R6, #0
          
CHECK_ZERO
          ADD    R3, R3, #0                  ; check if R3 is 0
          BRz    ISZERO
          BRnp   COMPUTE
          
ISZERO    LD     R1, ZERO_3400
          LD     R2, ONE_3400
          BR     FINISH_3400

; Compute sign. R2, R4 stores the signs of input numbers. 1 means positive,
; -4 means negative. Add R2 and R4, if 2 or -8, positive. If -3, negative.
; Store result in R2
COMPUTE   ADD    R5, R2, R4                 
          BRzp   POSITIVE
          BRn    NEGATIVE
          
POSITIVE  LD     R2, ONE_3400
          BR     DONE_SIGN
          
NEGATIVE  ADD    R5, R5, #8                  ; if negative, check if it's -8
          BRz    POSITIVE
          LD     R2, N_ONE_3400
DONE_SIGN
          
; compute R1 = R1 * R3
          LD     R4, ZERO_3400
MULTI     ADD    R4, R4, R1
          BRnz   FLOW
          ADD    R3, R3, #-1
          BRp    MULTI
          
          ADD    R1, R4, #0
          BR     FINISH_3400

FLOW      ADD    R2, R2, #0                  
          BRp    OVER                        ; overflow if result should be pos
          BRn    UNDER                       ; underflow if result should be neg
          
OVER      LEA    R0, OVER_MSG
          PUTS
          LD     R2, ZERO_3400
          BR     FINISH_3400
          
UNDER     LEA    R0, UNDER_MSG
          PUTS
          LD     R2, ZERO_3400
          BR     FINISH_3400

FINISH_3400

;(3) Restore registers

          LD   R0, BACKUP_R0_3400
          LD   R3, BACKUP_R3_3400
          LD   R4, BACKUP_R4_3400
          LD   R5, BACKUP_R5_3400
          LD   R7, BACKUP_R7_3400

;(4) Return
                RET

;-----------------------------------------------------------------------------
;Data Block
;-----------------------------------------------------------------------------
          ZERO_3400     .FILL   #0
          ONE_3400      .FILL   #1
          N_ONE_3400    .FILL   #-1
          OVER_MSG      .STRINGZ  "Woes! Overflows!"
          UNDER_MSG     .STRINGZ  "Woahs! Underflows!"
          
         
          
          BACKUP_R0_3400   .BLKW   #1
          BACKUP_R3_3400   .BLKW   #1
          BACKUP_R4_3400   .BLKW   #1
          BACKUP_R5_3400   .BLKW   #1
          BACKUP_R7_3400   .BLKW   #1

;-----------------------------------------------------------------------------
;End Subroutine
;-----------------------------------------------------------------------------
.END
