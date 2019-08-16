# Jubilee Configuration files

Config files for a fresh Jubilee printer with two extruder heads

## Connecting the Tool Lock Endstop

Note that the two limit switches must be wired together in series as per page 8 of the assembly instructions 
[PDF](https://cdn.thingiverse.com/assets/f0/56/bb/d9/a8/toolchanger_lock_assembly_instructions_1.pdf).

From here, you will take the toolchanger lock connector and install it in the E0 endstop.
(Note that you cannot use an endstop on E0 with the toolchanger lock.)

That's it! Simply load these config files onto your SD card following the folder structure, and you're set!

## Dialing in the Parking Post Locations
Note that you may need to change the parking locations in **tfreeX.g**, **tpreX.g**, and **tpostX.g**.
However, it is strongly recommended that you first try to use the hardware adjustments on the physical parking posts to set the location such that it matches those in the config files.
The main reason is that adusting the locations in hardware is easy since the posts are adjustable vertically and horizontally, while changing them is software involves changing their values in multiple files, which is subject to error.
