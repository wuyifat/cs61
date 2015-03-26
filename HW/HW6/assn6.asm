; =============================================================================
; Name: Wu, Yi
; Login: ywu014
; Email address: ywu014@ucr.edu
; Assignment: assn6
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
          
          LD   R6, SUB_DEC_TO_HEX_3600
          JSRR R6
          
          LD   R6, SUB_PRINT_3400            ; print out hex number to console
          JSRR R6
          
HALT

          NEWLINE                 .FILL   #10
          ASK_FOR_INPUT           .STRINGZ   "input a positive decimal number under 65535 start with #"
          
          SUB_INPUT_3200          .FILL   x3200
          SUB_PRINT_3400          .FILL   x3400
          SUB_DEC_TO_HEX_3600     .FILL   x3600
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

          LD     R1, DEC0_3200               ; reset registers
          
          TRAP x20                           ; capture "#"
          TRAP x21
          
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

          DEC0_3200     .FILL   #0
          DEC9          .FILL   #9
          DEC_48        .FILL   #-48
          
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
;Input (R2):    the pointer pointing to the array which stores the number
;Postcondition: the hexdecimal number is printed to the console
;Return (none):   
;-----------------------------------------------------------------------------
                .ORIG x3400
;-----------------------------------------------------------------------------
;Instruction Block
;-----------------------------------------------------------------------------
;(1) Backup all modified registers except the Return value

          ST R0, BACKUP_R0_3400
          ST R2, BACKUP_R2_3400
          ST R3, BACKUP_R3_3400
          ST R4, BACKUP_R4_3400
          ST R7, BACKUP_R7_3400

;(2) Algorithm
          
          LD   R0, ASC_x_3400                ; print 'x'
          TRAP x21
          LD   R3, DEC4_3400                 ; R3 = 4, is the counter
          
LOOP_3400                                    ; print each digit
          LDR  R0, R2, #0
          BR   PRINT_DIGIT_3400
CONTINUE_3400
          ADD  R2, R2, #1                    ; point to the next array element
          ADD  R3, R3, #-1                   ; update counter
          BRp  LOOP_3400
          BRz  DONE_3400
          
PRINT_DIGIT_3400          
          ADD  R4, R0, #-10                  ; if digit value less than 10, print
          BRn  PRINT_NUMBER_3400             ; number. if digit value larger than
          BRzp PRINT_LETTER_3400             ; or equal to 10, print letter
          
PRINT_NUMBER_3400          
          LD   R4, DEC48_3400
          ADD  R0, R0, R4                    ; convert to ascii number char by adding 48
          TRAP x21
          BR   CONTINUE_3400
          
PRINT_LETTER_3400          
          LD   R4, DEC55_3400
          ADD  R0, R0, R4                    ; conver to ascii letter char by adding 55
          TRAP x21
          BR   CONTINUE_3400
          
DONE_3400          
;(3) Restore registers

          LD   R0, BACKUP_R0_3400
          LD   R2, BACKUP_R2_3400
          LD   R3, BACKUP_R3_3400
          LD   R4, BACKUP_R4_3400
          LD   R7, BACKUP_R7_3400

;(4) Return
                RET

;-----------------------------------------------------------------------------
;Data Block
;-----------------------------------------------------------------------------
          ASC_x_3400     .FILL   #120
          DEC4_3400      .FILL   #4
          DEC48_3400     .FILL   #48
          DEC55_3400     .FILL   #55                  

                    
          BACKUP_R0_3400   .BLKW   #1
          BACKUP_R2_3400   .BLKW   #1
          BACKUP_R3_3400   .BLKW   #1
          BACKUP_R4_3400   .BLKW   #1
          BACKUP_R7_3400   .BLKW   #1
          
;-----------------------------------------------------------------------------
;End Subroutine
;-----------------------------------------------------------------------------
.END

;-----------------------------------------------------------------------------
;Subroutine:    SUB_DEC_TO_HEX_3600
;Input (R1):    R1 is the number to be converted
;Postcondition: convert R1 to hexdecimal number. store it as a in an array located at x4000
;Return (R2):   R2 stores the pointer points to the array
;                  
;-----------------------------------------------------------------------------
                .ORIG x3600
;-----------------------------------------------------------------------------
;Instruction Block
;-----------------------------------------------------------------------------
;(1) Backup all modified registers except the Return value

          ST R0, BACKUP_R0_3600
          ST R1, BACKUP_R1_3600
          ST R3, BACKUP_R3_3600
          ST R4, BACKUP_R4_3600
          ST R5, BACKUP_R5_3600
          ST R6, BACKUP_R6_3600
          ST R7, BACKUP_R7_3600

;(2) Algorithm

          LD    R2, ARR_PTR                  ; load R2 with the pointer pointing to the array
          LD    R3, DEC0_3600
          LD    R5, DEC0_3600                ; initial R3 to be 0. R3 records the time of subtraction until R1 becomes positive if originally negative
          
; convert the number          
          ADD   R1, R1, #0
          BRn   NEG_3600
          BRz   ZERO_3600
          BRp   POS_3600
          
ZERO_3600                                    ; if number is 0, finish convertion
          BR    DONE_3600
          
NEG_3600
          LD    R4, N_FORTH
          ADD   R5, R5, #1
          ADD   R1, R1, R4
          BRn   NEG_3600
          BRz   ZERO_3600
          BRp   POS_3600
          
POS_3600
          LD    R4, N_FORTH                  ; compute the hex number on 16^3 position
          LD    R6, SUB_CONVERT_DIGIT_3800
          JSRR  R6
          LD    R4, P_FORTH                  ; make R1 positive again by adding back 16^3
          ADD   R1, R1, R4
          ADD   R2, R2, #1                   ; point the pointer to the next element
          
          LD    R4, N_THIRD                  ; compute the hex number on 16^2 position
          LD    R6, SUB_CONVERT_DIGIT_3800
          JSRR  R6
          LD    R4, P_THIRD                  ; make R1 positive again by adding back 16^2
          ADD   R1, R1, R4          
          ADD   R2, R2, #1
          
          LD    R4, N_SECOND                 ; compute the hex number on 16^1 position
          LD    R6, SUB_CONVERT_DIGIT_3800
          JSRR  R6
          LD    R4, P_SECOND                 ; make R1 positive again by adding back 16^1
          ADD   R1, R1, R4
          ADD   R2, R2, #1          
          
          LD    R4, N_FIRST                  ; compute the hex number on 16^0 position
          LD    R6, SUB_CONVERT_DIGIT_3800
          JSRR  R6
          LD    R4, P_FIRST                  ; make R1 positive again by adding back 16^0
          ADD   R1, R1, R4 
                   
DONE_3600          
          LD    R2, ARR_PTR
          LDR   R3, R2, #0                   ; add negative counter(R5) to the first element
          ADD   R3, R5, R3
          STR   R3, R2, #0

;(3) Restore registers

          LD R0, BACKUP_R0_3600
          LD R1, BACKUP_R1_3600
          LD R3, BACKUP_R3_3600
          LD R4, BACKUP_R4_3600
          LD R5, BACKUP_R5_3600
          LD R6, BACKUP_R6_3600
          LD R7, BACKUP_R7_3600
          
;(4) Return
                RET

;-----------------------------------------------------------------------------
;Data Block
;-----------------------------------------------------------------------------

          DEC0_3600     .FILL   #0
          DEC4_3600     .FILL   #4
          N_FORTH       .FILL   #-4096
          N_THIRD       .FILL   #-256
          N_SECOND      .FILL   #-16
          N_FIRST       .FILL   #-1
          P_FORTH       .FILL   #4096
          P_THIRD       .FILL   #256
          P_SECOND      .FILL   #16
          P_FIRST       .FILL   #1
          ARR_PTR       .FILL   x4000
          
          BACKUP_R0_3600   .BLKW   #1
          BACKUP_R1_3600   .BLKW   #1
          BACKUP_R3_3600   .BLKW   #1
          BACKUP_R4_3600   .BLKW   #1
          BACKUP_R5_3600   .BLKW   #1
          BACKUP_R6_3600   .BLKW   #1
          BACKUP_R7_3600   .BLKW   #1
          
          SUB_CONVERT_DIGIT_3800     .FILL  x3800
          
          .ORIG x4000
          ARR           .BLKW      #4
          
;-----------------------------------------------------------------------------
;End Subroutine
;-----------------------------------------------------------------------------
.END

;-----------------------------------------------------------------------------
;Subroutine:    SUB_CONVERT_DIGIT_3800
;Input (R1, R2, R4):    R1 is the number to be converted, R2 is the pointer pointing 
;...                    to the array, R4 is the highest weight
;Postcondition: the element pointed to by R2 is the hexdemical representation of the number
;Return (R1, R2):   R1 is the largest negative number after sucessively substracting the weight
;...                number. R2 is the pointer to the element in the array
;-----------------------------------------------------------------------------
                .ORIG x3800
;-----------------------------------------------------------------------------
;Instruction Block
;-----------------------------------------------------------------------------
;(1) Backup all modified registers except the Return value

          ST R0, BACKUP_R0_3800
          ST R3, BACKUP_R3_3800
          ST R4, BACKUP_R4_3800
          ST R7, BACKUP_R7_3800

;(2) Algorithm

          LD    R3, DEC0_3800                ; reset counter to be 0
LOOP_3800
          ADD   R1, R1, R4
          BRn   DONE_3800
          ADD   R3, R3, #1
          BR    LOOP_3800
DONE_3800

          STR   R3, R2, #0                    

;(3) Restore registers

          LD R0, BACKUP_R0_3800
          LD R3, BACKUP_R3_3800
          LD R4, BACKUP_R4_3800
          LD R7, BACKUP_R7_3800

;(4) Return
                RET

;-----------------------------------------------------------------------------
;Data Block
;-----------------------------------------------------------------------------

          DEC0_3800        .FILL   #0
          
          BACKUP_R0_3800   .BLKW   #1
          BACKUP_R3_3800   .BLKW   #1
          BACKUP_R4_3800   .BLKW   #1
          BACKUP_R7_3800   .BLKW   #1

;-----------------------------------------------------------------------------
;End Subroutine
;-----------------------------------------------------------------------------
.END
