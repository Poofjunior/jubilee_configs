; Runs after freeing the previous tool if the next tool is tool-0.
; Note: tool offsets are not applied at this point!

G0 X285 Y335 F25000         ; Rapid to the approach position without any current tool.
G1 Y355 F10000              ; Controlled move to the pickup position with tool-0.
M98 P"/macros/tool_lock.g"  ; Lock the tool
G1 Y318 F6000               ; Retract the entire tool.
G60 S2                      ; Save this position as the reference point from which to later apply new tool offsets.
