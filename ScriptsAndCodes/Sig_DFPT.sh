#!/bin/bash

# This script first checks to see if the relaxation is finished,
# and that the DFPT has not already been done. If these two conditions
# hold true, then it makes the DFPT abi.in input file, using the scripts
# MakeGS.sh and MakeDFPT.sh.

# Because the DFPT runs require more memory and time than the relaxations 
# generally, more time and memory are defined in the Run.sh.

for i in Sig[XYZ]*_*GPa
do

if [ -f $i/fart.txt ] && [ ! -f $i/DFPT/fart.txt ]
then
   cd $i
   rm *-o* abi.out0* log\.* slurm\.* 

   ~/Scripts/DFPT/MakeGS.sh abi.in abi.out
   ~/Scripts/DFPT/MakeDFPT.sh .
   
   sed  '/mem-per-cpu/s/774/1548/g'  ../Run.sh > DFPT/Run.sh 
   sed  -i '/\-job-name/s/XXXX/'${i}'DFPT/g' DFPT/Run.sh
   sed -i 's/time=10/time=12/g' DFPT/Run.sh

   cd DFPT
   sbatch Run.sh
   cd ../../
fi
done

