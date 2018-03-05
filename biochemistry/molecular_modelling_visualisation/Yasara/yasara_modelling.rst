
Yasara modelling
=================

Preparing structure for modelling
__________________________________

Fixing residues
----------------

Changing Se-Met to Met:

SwapRes Mse,Met,Isomer=L


Cleaning structure
-------------------

Edit->Clean


## Simulation

Selecting Force field
Forcefield Yamber3

Simulate -> Initialize
Scene as Yasara Scene : WTsce

Simulation -> define simulation cell
-> extend: 10A around all atoms
Cell bounderies: periodic

Simulation -> fill cell with water -> OK

SaveScene WT_water

## running macro on server

Config file

Processors
HUD sim
Macrotarget _.sce
Playmacro _.mcr
sim off / sim pause / sim continue
