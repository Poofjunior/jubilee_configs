; tpost1.g
; called after tool 1 has been selected
; Note: tool offsets are applied at this point!

G1 R2 X0 Y0 Z0  ; Restore prior position now accounting for new tool offset
M116 P1         ; Wait for set temperatures to be reached
M106 R2         ; restore print cooling fan speed
