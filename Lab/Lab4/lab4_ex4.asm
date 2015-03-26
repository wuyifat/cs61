; =============================================================================
; Name: Wu, Yi
; Login: ywu014 (ywu014@ucr.edu)
; Email address: ywu014@ucr.edu
; Assignment: lab4_ex4
; Lab Section: 24
; TA: Wojtek Karas
;
; I hereby certify that the contents of this file are ENTIRELY my own original
; work.
; =============================================================================

	 .ORIG x3000
; --------- initial the array -----------------------------------
                LD     R5, PTR
                LD     R6, COUNT
                LD     R4, ONE                    ; increment R4's number every time, load that number to R1's address

LOOP_IN         STR     R4, R5, #0                ; load R4 to remote memory
                ADD     R4, R4, R4
                ADD     R5, R5, #1                ; point to the next remote address
                ADD     R6, R6, #-1               ; decrease counter by 1
                BRp     LOOP_IN

; -------- print out the array ----------------------------------

                LD     R5, PTR                    ; reset constants
                LD     R6, COUNT
                LD     R4, DEC48

LOOP_ARR        LD     R1, COUNT_4                ; loop counter for 4 sections
                LD     R3, COUNT_4                ; loop counter for 4 bits 
                LDR    R2, R5, #0                 ; load the array number to R2
                BRzp   PRINT0                     ; print 0 if first bit is 0, which makes the whole number non-negative
                BRn    PRINT1                     ; print 1 if first bit is 1, which makes the whole number negative

                LOOP2  ADD     R2, R2, R2         ; shift bits to left
                       BRzp    PRINT0             ; print the succesive bit
                       BRn     PRINT1
                FINISH

                LD     R0, NEWLINE                ; print out '\n' when finish a hex number
                TRAP x21

                ADD    R5, R5, #1                 ; point to the next remote memory
                ADD    R6, R6, #-1                ; update counter
                BRp    LOOP_ARR
HALT

PRINT_SPACE     ADD     R1, R1, #-1               ; if space has been printed out 4 times, done. if not, print space
                BRnz    FINISH          
                LD      R3, COUNT_4               ; reset R3 = 4
                LD      R0, SPACE                 ; print space
                TRAP x21
                ADD     R1, R1, #0                ; go back to loop
                BRp     LOOP2

PRINT0          LD      R0, ZERO                  ; load 0 to R0 and print
                ADD     R0, R0, R4                ; convert to ASCII
                TRAP x21
                ADD     R3, R3, #-1               ; if has printed out numbers 4 times, print space. if not, continue
                BRp     LOOP2
                BRnz    PRINT_SPACE

PRINT1          LD      R0, ONE                   ; load 1 to R0 and print
                ADD     R0, R0, R4                ; convert to ASCII
                TRAP x21
                ADD     R3, R3, #-1
                BRp     LOOP2
                BRnz    PRINT_SPACE

; ----- constants used in calculating R2 -----------                
PTR     .FILL     x4000
COUNT   .FILL     #10
ONE     .FILL     #1
                
; ----- constants used in printing out R2 ---------------
COUNT_4  .FILL     #4
DEC48    .FILL     #48
ZERO     .FILL     #0
ONE      .FILL     #1
SPACE    .FILL     #32
NEWLINE  .FILL     #10


        .ORIG  x4000
ARRAY      .BLKW       #10

.END
