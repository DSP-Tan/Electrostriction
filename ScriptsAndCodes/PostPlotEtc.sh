#!/bin/bash



for i in XY #Y #X  Y Z YZ XZ XY
do
   cd Sig$i
   
   mkdir Sig${i}_0.0GPa/DFPT
   touch Sig${i}_0.0GPa/fart.txt
   touch Sig${i}_0.0GPa/DFPT/fart.txt
   touch Sig${i}_0.0GPa/DFPT/PpFin.txt
   
   cp ../DFPT/anaddb.out Sig${i}_0.0GPa/DFPT
   cp ../DFPT/anaddb.in  Sig${i}_0.0GPa/DFPT
   cp ../DFPT/abi.out    Sig${i}_0.0GPa/
   cp ../DFPT/abi.out    Sig${i}_0.0GPa/DFPT
  

   cp ../../ScriptsAndCodes/Extract${i}StressPerm.sh .
   cp ../../ScriptsAndCodes/Good${i}Fit.gp ./GoodFit.gp
   ./Extract${i}StressPerm.sh
   ../../ScriptsAndCodes/gslinv
   ./Extract${i}StressPerm.sh

   cd ../
done
