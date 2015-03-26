; =============================================================================
; Name: Wu, Yi
; Login: ywu014
; Email address: ywu014@ucr.edu
; Assignment: assn4
; Lab Section: 24
; TA: Wojtek Karas
;
; I hereby certify that the contents of this file are ENTIRELY my own original
; work.
; =============================================================================
.ORIG x3000

START    LD     R1, ZERO                    ; reset registers
         LD     R2, ZERO                    ; R2 stores the sign, 1 means positive, -1 means negative
;------------------------------------------------------------------------------------
; use R3 to load constant for calculation
; use R6 to load jump address
; use R7 to store temp result
;--------------------------------------------------------------------------------------
         
         LEA    R0, PROMPT                  ; ask user to input
         PUTS
         LD     R0, NEWLINE                 ; start a new line to echo input
         TRAP x21

         LOOP   TRAP x20                    ; read input character and print it to screen
                TRAP x21              

                ADD     R7, R0, #-10        ; if input "enter", finish input
                BRz     FINISH

                LD      R3, DEC_43          ; if input "+", change R2 to 1
                ADD     R7, R0, R3        
                BRz     PLUS

                LD      R3, DEC_45          ; if input "-", change R2 to -1
                ADD     R7, R0, R3        
                BRz     MINUS

                LD      R3, DEC_48          ; if input smaller than "0", start over
                ADD     R7, R0, R3        
                BRn     START

                LD      R3, DEC_57          ; if input larger than "9", start over
                ADD     R7, R0, R3        
                BRp     START

                LD      R3, DEC_48          ; calculate input number
                ADD     R0, R0, R3
                LEA     R6, MULTI10         ; R1 = 10 * R1 + R0
                JMP     R6
DONE10:
                ADD     R1, R1, R0
                BRnzp   LOOP
                



MINUS           LD      R2, MONE            ; change R2 to -1
                BRnzp   LOOP

PLUS            LD      R2, ONE             ; change R2 to 1
                BRnzp   LOOP

MULTI10:
                LD      R6, DEC9            ; add R1 to itself 9 times, R6 is the counter
                ADD     R7, R1, #0
                REPEAT  ADD     R1, R1, R7
                        ADD     R6, R6, #-1
                        BRp     REPEAT
                LEA     R6, DONE10
                JMP     R6

FINISH                
                
; convert negative by two's complement
ADD     R2, R2, #0
BRzp    DONE
NOT     R1, R1
ADD     R1, R1, #1


DONE
HALT


MONE      .FILL     #-1
ZERO      .FILL     #0
ONE       .FILL     #1
DEC10     .FILL     #10
DEC9      .FILL     #9
DEC_43    .FILL     #-43
DEC_45    .FILL     #-45
DEC_48    .FILL     #-48
DEC_57    .FILL     #-57
PROMPT    .STRINGZ  "Input a positive or negative decimal number (max 5 digits), followed by ENTER"
NEWLINE   .FILL     #10

.END
