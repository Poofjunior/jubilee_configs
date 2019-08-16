; Jubilee 1.0 Config File
; drawing inspiration from the Railcore 300ZL config file

; Name and Identification
M550 P"Jubilee"                         ; Machine name and Netbios name

; Networking
M552 P192.168.1.2 S1                    ; Use Ethernet with a static IP
M554 192.168.1.3                        ; Gateway
M553 P255.255.255.0                     ; Netmask
M586 P2 S1                              ; Enable Telnet

; Debugging
M111 S0                                 ; Debug off
M929 P"eventlog.txt" S1                 ; Start logging to file eventlog.txt

; General Preferences
M555 P2                                 ; Set Marlin-style output
G21                                     ; Set dimensions to millimetres
G90                                     ; Send absolute coordinates...
M83                                     ; ...but relative extruder moves

; Joints
M584 X0 Y1 Z6:7:8 E3:4 U2   ; Map Z to drivers 6, 7, 8. Map extruders to 3 and 4. Create Toolchanger Lock axis.

M569 P0 S0                  ; Drive 0 direction | X stepper
M569 P1 S0                  ; Drive 1 direction | Y Stepper

M569 P6 S0                  ; Drive 6 direction | Front Left Z
M569 P7 S0                  ; Drive 7 direction | Front Right Z
M569 P8 S0                  ; Drive 8 direction | Back Z

M569 P2 S1                  ; Drive 2 direction | Toolchanger Actuator

M569 P3 S0                  ; Drive 3 direction | Extruder 0
M569 P4 S0                  ; Drive 4 direction | Extruder 1

; Joint Kinematics
M669 K1                                 ; CoreXY mode

; Leadscrew locations extracted from CAD model assuming lower left build plate corner is (0, 0)
M671 X300:5:152.5 Y316:316:-14 S5 ; Front Left: (300, 316) | Front Right: (5, 316) | Back: (-14, 152.5)

; Axis and motor configuration
M350 X16 Y16 Z16 E16 U4 I1              ; Set 16x microstepping for axes & extruder, 4x for toolchanger lock. Use interpolation.
M574 X1 Y1 Z1 S1                        ; Set homing switch configuration x low-end, y low-end, z low-end, all active-high (NC)
M574 U1 S1                              ; Set homing switch configuration for toolchange lock. Both switches should be wired NC and in series.
M906 X1500 Y1500 Z800 E1250 U900 I60    ; Motor currents (mA)
M201 X800 Y800 Z10 E1000 U1000          ; Accelerations (mm/s^2)
M203 X25000 Y25000 Z400 E4000 U10000    ; Maximum speeds (mm/min)
M566 X1400 Y1400 Z2 E3000 U200          ; Maximum jerk speeds mm/minute
M92 X200 Y200 U11.429                   ; Steps/mm for X,Y,U
M92 Z3200                               ; Steps/mm for Z - TR8*4 / 0.9 deg stepper
M92 E837                                ; Extruder - 0.9 deg/step

; Set axis software limits and min/max switch-triggering positions. Adjust such that (0,0) lies at the lower left corner of the build plate.
M208 X-5:305 Y-10:355 Z-0.5:220
M208 U0:180

; Thermistors
M305 P0 S"Bed" T100000 B3950 R4700 H0 L0  ; BOM thermistor values. Put your own H and/or L values here to set the bed thermistor ADC correction
M305 P1 X200                              ; Extruder 0 sensor maps to PT100 Channel 0
M305 P2 X201                              ; Extruder 1 sensor maps to PT100 channel 1

; Heaters
M143 H0 S80                                ; Maximum H0 (Bed) heater temperature (Conservative)
M143 H1 S240                               ; Maximum H1 (Extruder) heater temperature (Conservative and in case extruder has PTFE lining)
M143 H2 S240

; Default heater model
M307 H0 A270.7 C90.4 D6.7 B0 S1.0          ; Default Bed Heater Parameters, before tuning / if config-override.g is missing

; Tool definitions
M563 P0 S"Extruder 0" D0 H1 F0  ; Define tool 0
G10 P0 Z-3.75                   ; Set tool 0 offset from the bed
G10 P0 S190 R170                ; Set tool 0 operating and standby temperatures(-273 = "off")
M572 D0 S0.1				    ; Set pressure advance on Extruder Drive 0

M563 P1 S"Extruder 1" D1 H2 F2  ; Define tool 1
G10 P1 X0.1 Y1.8 Z-2.65         ; Set tool 1 offset from the bed with tool-0 as a reference.
G10 P1 S190 R170                ; Set tool 1 operating and standby temperatures(-273 = "off")
M572 D1 S0.1				    ; Set pressure advance on Extruder Drive 1

; Fans
M106 P0 S0  ; Turn off fan 0
M106 P1 S0  ; Turn off fan 1

; Z probe
M558 P4 C2 H2 A1 T3000  S0.02   ; Z probe - raise probe height.
					            ; H10 - dive height
					            ; A bigger dive height prevents a situation where the bed is out of alignment by more than the dive height
					            ; on any corner, which can crash the hot-end into the bed while moving the head in XY.
					            ; Probing speed and travel speed are similarly reduced in case the Z probe isn't connected properly (or
					            ; disconnects later after moving to a point) giving the user more time to stop.

M98 P"config-user.g"    ; Load custom user config if one exists.

M501                    ; Load saved parameters from non-volatile memory

; Note: you will need to tune the bed heater, and both extruder cartridges before printing.
; See the following link for more details. https://duet3d.dozuki.com/Wiki/Tuning_the_heater_temperature_control
