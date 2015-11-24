---
Title:       "Section 6.4 Dual Printing"
Description: "Welcome to the i3 Berlin building manual"
Tags:        [ "manual", "i3-berlin" ]
date:        "2015-11-24"
Authors:     "Bram de Vries"
Slug:        "Section-6.4-Dual-Printing"
Prev:        "/manual_i3_berlin/section-6.3-kisslicer"
Next:        "/manual_i3_berlin/"
---

It’s highly recommended to start printing with only one printhead until you are comfortable with it. Printing with two nozzles involves some extra things to take care of, but also allows you to combine multiple materials in one printed object.

Two things should be calibrated first: the height of the second nozzle and the offset in the X and Y direction.

First thing to do is to level the right nozzle. \* Adjust the platform accurately to the LEFT nozzle with a piece of paper, as described in [Section 5.4](/manual_i3_berlin/section-5.4-calibrating-the-print-platform). \* put the extruder in the middle of the platform \* loosen the two m3 counter sunk screws that hold the right hotend. **push it down until it has the same feeling on the paper as the left nozzle.** tighten the two screws again, and check again with the paper.

To calibrate the X and Y offset you need to print a small test object. This can be found on the SD card that came with the printer and can be found in SD-Card/Examples/calibration\_line/

-   Load line0.stl and line1.stl to Cura

-   Right click in the 3D window and confirm *dual print merge*

-   Save the gcode to the SD Card and print the test object

    -   It is best to load two contrasting colors to the printer.

-   Take a close look at the print result

    -   Adjust the X and Y offset in *Machine&gt;Machine Settings*

    -   Please note that an offset of X 0,85 and Y 39,57 is allready in the firmware.

-   Repeat the test print until the lines are nicely on top of eachother.

-   This calibration has to be done every time you disassemble the right hand extruder.

Tip: \* While doing a dual print, turn on wipe tower and ooze shield. **wipe tower is an extra pillar that is use to clear the nozzle before starting** ooze shield is an extra wall that is printed around the object to catch pieces of plastic that ooze out while the other nozzle is printing.
