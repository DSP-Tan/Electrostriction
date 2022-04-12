#!/bin/bash

for i in Sig[XYZ]*_*GPa
do
   if [ -f $i/fart.txt ] && [ -f $i/DFPT/fart.txt ] && [ ! -f $i/DFPT/PpFin.txt ]
   then

   cd $i/DFPT
   cp ~/Scripts/DFPT/PostProc/* .
   sbatch PostProc.sh
   cd ../../
   fi

done
