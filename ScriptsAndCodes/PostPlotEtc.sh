#!/bin/bash



for i in X Y Z YZ XZ XY
do
   cd Sig$i
   
   mkdir -p Sig${i}_0.0GPa/DFPT
   touch Sig${i}_0.0GPa/fart.txt
   touch Sig${i}_0.0GPa/DFPT/fart.txt
   touch Sig${i}_0.0GPa/DFPT/PpFin.txt
   
   cp ../DFPT/anaddb.out Sig${i}_0.0GPa/DFPT
   cp ../DFPT/anaddb.in  Sig${i}_0.0GPa/DFPT
   cp ../DFPT/abi.out    Sig${i}_0.0GPa/DFPT
  

   ../../../ScriptsAndCodes/ExtractFitStressPermRigid.sh

   cd ../
done
