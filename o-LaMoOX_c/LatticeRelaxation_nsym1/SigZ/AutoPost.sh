#!/bin/bash

for i in SigZ_*
do
   if [ -f $i/fart.txt ] && [ -f $i/DFPT/fart.txt ]
   then

   cd $i/DFPT
   cp ~/Scripts/DFPT/PostProc/* .
   sbatch PostProc.sh
   cd ../../
   fi

done
