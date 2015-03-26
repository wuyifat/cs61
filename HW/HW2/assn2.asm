; =============================================================================
; Name: Wu, Yi
; Login: ywu014
; Email address: ywu014@ucr.edu
; Assignment: assn2
; Lab Section: 24
; TA: Wojtek Karas
;
; I hereby certify that the contents of this file are ENTIRELY my own original
; work.
; =============================================================================
.ORIG x3000

     LD R5, DEC48
     LD R6, DEC_48

;----- step 1, get numbers-----------------------

     TRAP x20          ; get a number
     ADD R1, R0, #0    ; transfer the first number to R1
     TRAP x20          ; get the second number
     ADD R2, R0, #0    ; transfer the second number to R2

;----- step 2, convert to real numbers ---------------------

     ADD R2, R2, R6
     ADD R1, R1, R6

;----- step 3, 1st number - 2nd number--------------------

     NOT R2, R2
     ADD R2, R2, #1    ; convert the 2nd number to negative according to two's complement
     ADD R3, R1, R2    ; perform substraction, write result to R3

;----- step 4, determine the sign of result, enter different branches accordingly---

     BRn RESULT        ; if R3 is negative, go to RESULT

;----- step 5, print out result directly if positive. Go to RESULT if negative-----
; if positve
     ADD R0, R3, #0    ; transfer result to R0
     ADD R0, R0, R5    ; convert number to ASCII code
     TRAP x21
     HALT

; if negative
RESULT   LD R0, SIGN
         TRAP x21      ; output "-"
         ADD R3, R3, #-1
         NOT R3, R3    ; convert R3 to a positive number according to two's complement
         ADD R0, R3, #0; transfer the number to R0
         ADD R0, R0, R5; convert number to ASCII code
         TRAP x21      ; output the number
  
         HALT



SIGN     .FILL     #45 ;     minus sign
DEC48    .FILL     #48
DEC_48   .FILL     #-48

.END