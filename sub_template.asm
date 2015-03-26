;-----------------------------------------------------------------------------
;Subroutine:    SUB_TEMPLATE_3200
;Input (Rn):    purpose of value in Rn for use in this subroutine
;...
;Postcondition: what is the state of things after completion of subroutine
;Return (Rn):   purpose of value in Rn for use by the calling program
;...
;-----------------------------------------------------------------------------
                .ORIG x3200
;-----------------------------------------------------------------------------
;Instruction Block
;-----------------------------------------------------------------------------
;(1) Backup all modified registers except the Return value

          ST R0, BACKUP_R0_3200
          ST R7, BACKUP_R7_3200

;(2) Algorithm


;(3) Restore registers

          LD R0, BACKUP_R0_3200
          LD R7, BACKUP_R7_3200

;(4) Return
                RET

;-----------------------------------------------------------------------------
;Data Block
;-----------------------------------------------------------------------------
      
          BACKUP_R0_3200   .BLKW   #1
          BACKUP_R7_3200   .BLKW   #1

;-----------------------------------------------------------------------------
;End Subroutine
;-----------------------------------------------------------------------------
.END