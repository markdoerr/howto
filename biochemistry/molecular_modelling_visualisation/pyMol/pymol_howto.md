
# pymol howto

## fetch a file from PDB 

fetch 1bl8

## align structures

align 1CLL, calmodulin_gallus_gallus_2M3S

## Exporting images

## set background coulor

How do I get a white background?

   set bg_rgb=[1,1,1] # these are [red,blue,green] components

  In version 0.61 or later, simply use the bg_color command.

   bg_color white

Usually you're want to turn off depth cueing and fog too

   set depth_cue=0
   set ray_trace_fog=0

## render

ray

## output as png

png my_image.png


