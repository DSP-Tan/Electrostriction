#!/bin/bash
LC_NUMERIC="en_US.UTF-8"



######################################################################################################################################
##################### Extract permitivity and stresses from anaddb.out in each folder. ###############################################
######################################################################################################################################



# The directory we run this from is the name of the sort
# of stress we apply, and this is also the root of the name
# of the subdirectories. So for example, we can be in SigX,
# and all subdirectories will be similar to: SigX_0.5GPa
branch=$(pwd | tr "\/" "\n" | tail -n1)

## TO DO: Use a bash array to make this less disgusting.
if [ $branch == "SigX" ]
  then
  voigt=1
  line=1
  column=4
elif [ $branch == "SigY" ]
  then
  voigt=2
  line=2
  column=4
elif [ $branch == "SigZ" ]
  then
  voigt=3
  line=3
  column=4
elif [ $branch == "SigYZ" ]
  then
  voigt=4
  line=1
  column=7
elif [ $branch == "SigXZ" ]
  then
  voigt=5
  line=2
  column=7
elif [ $branch == "SigXY" ]
  then
  voigt=6
  line=3
  column=7
fi


awk  'BEGIN {printf "%-9s %-9s %-15s %-6s %-6s %-6s %-15s %-6s %-6s %-6s %-15s\n" , \
                    "sig (GPa)", "'$branch'", "epsX", "epsXY", "epsXZ", "epsYX", "epsY", "epsYZ",  "epsZX", "epsZY", "epsZ"}' > StressPerm.txt

for j in `ls | grep ${branch}_ | cut -d '_' -f 2 | cut -d 'G' -f 1 | sort -n`
do
if [ -f ${branch}_${j}GPa/DFPT/anaddb.in ]
then
  energy=$(  grep '>>>>>>>>> Etotal='       ${branch}_${j}GPa/DFPT/abi.out  | tail -n 1 | awk '{printf "%-20.14f\n", $3*27.2113834}')
  stress=$(  grep -A3 'stress tensor (GPa)' ${branch}_${j}GPa/DFPT/abi.out  | tail -n 3 | sed -n "${line}"p | awk '{print $'$column'}' )                
  
  # To Do: Use array for this. For now just doing this with vim is faster.
  epsX=$(grep  -A3 -i "relaxed ion dielectric tensor"  ${branch}_${j}GPa/DFPT/anaddb.out | sed -n 2p | awk '{print $1}')
  epsXY=$(grep -A3 -i "relaxed ion dielectric tensor"  ${branch}_${j}GPa/DFPT/anaddb.out | sed -n 2p | awk '{print $2}')
  epsXZ=$(grep -A3 -i "relaxed ion dielectric tensor"  ${branch}_${j}GPa/DFPT/anaddb.out | sed -n 2p | awk '{print $3}')
  epsYX=$(grep -A3 -i "relaxed ion dielectric tensor"  ${branch}_${j}GPa/DFPT/anaddb.out | sed -n 3p | awk '{print $1}')
  epsY=$(grep  -A3 -i "relaxed ion dielectric tensor"  ${branch}_${j}GPa/DFPT/anaddb.out | sed -n 3p | awk '{print $2}')
  epsYZ=$(grep -A3 -i "relaxed ion dielectric tensor"  ${branch}_${j}GPa/DFPT/anaddb.out | sed -n 3p | awk '{print $3}')
  epsZX=$(grep -A3 -i "relaxed ion dielectric tensor"  ${branch}_${j}GPa/DFPT/anaddb.out | sed -n 4p | awk '{print $1}')
  epsZY=$(grep -A3 -i "relaxed ion dielectric tensor"  ${branch}_${j}GPa/DFPT/anaddb.out | sed -n 4p | awk '{print $2}')
  epsZ=$(grep  -A3 -i "relaxed ion dielectric tensor"  ${branch}_${j}GPa/DFPT/anaddb.out | sed -n 4p | awk '{print $3}')

  awk -v j="$j" -v sig="$stress" \
      -v epsX="$epsX" -v epsY="$epsY" -v epsZ="$epsZ" -v epsXY="$epsXY" -v epsXZ="$epsXZ" -v epsYX="$epsYX" -v epsYZ="$epsYZ" -v epsZX="$epsZX" -v epsZY="$epsZY" \
  'BEGIN {printf "%-9s %-9.6f %-15.4f %-6.2f %-6.2f %-6.2f %-15.4f %-6.2f %-6.2f %-6.2f %-15.4f\n" , \
                  j, sig,  epsX, epsXY, epsXZ, epsYX, epsY, epsYZ,  epsZX, epsZY, epsZ}' >> StressPerm.txt
fi      
done


######################################################################################################################################
##################### Calculate rigidities using C code and gsl inversion  ###########################################################
######################################################################################################################################

# Load libaries necessary to use gsl libraries used by gslinv in ScriptsAndCodes.
module load releases/2020a
module load GSL/2.6-GCC-9.3.0

../../../ScriptsAndCodes/gslinv

######################################################################################################################################
##################### Fit Q and M to StressPerm.txt and StressRigid.txt ##############################################################
######################################################################################################################################

module load gnuplot/5.2.8-GCCcore-9.3.0
cp ../../../ScriptsAndCodes/GoodFit.gp .

# First put in the equilibrium values in the fitting script.
eps0x=$(grep  -A3 -i "relaxed ion dielectric tensor" ${branch}_0.0GPa/DFPT/anaddb.out | sed -n 2p | awk '{print $1}')
eps0xy=$(grep -A3 -i "relaxed ion dielectric tensor" ${branch}_0.0GPa/DFPT/anaddb.out | sed -n 2p | awk '{print $2}')
eps0xz=$(grep -A3 -i "relaxed ion dielectric tensor" ${branch}_0.0GPa/DFPT/anaddb.out | sed -n 2p | awk '{print $3}')
eps0y=$(grep  -A3 -i "relaxed ion dielectric tensor" ${branch}_0.0GPa/DFPT/anaddb.out | sed -n 3p | awk '{print $2}')
eps0yz=$(grep -A3 -i "relaxed ion dielectric tensor" ${branch}_0.0GPa/DFPT/anaddb.out | sed -n 3p | awk '{print $3}')
eps0z=$(grep  -A3 -i "relaxed ion dielectric tensor" ${branch}_0.0GPa/DFPT/anaddb.out | sed -n 4p | awk '{print $3}')

eta0x=$(  grep "^0.0 " StressRigid.txt  | awk '{print $3}')
eta0xy=$( grep "^0.0 " StressRigid.txt  | awk '{print $4}')
eta0xz=$( grep "^0.0 " StressRigid.txt  | awk '{print $5}')
eta0y=$(  grep "^0.0 " StressRigid.txt  | awk '{print $7}')
eta0yz=$( grep "^0.0 " StressRigid.txt  | awk '{print $8}')
eta0z=$(  grep "^0.0 " StressRigid.txt  | awk '{print $11}')

sed -i 's/^eps0x=.*/eps0x='$eps0x'/g'    GoodFit.gp
sed -i 's/^eps0y=.*/eps0y='$eps0y'/g'    GoodFit.gp
sed -i 's/^eps0z=.*/eps0z='$eps0z'/g'    GoodFit.gp
sed -i 's/^eps0yz=.*/eps0yz='$eps0yz'/g' GoodFit.gp
sed -i 's/^eps0xz=.*/eps0xz='$eps0xz'/g' GoodFit.gp
sed -i 's/^eps0xy=.*/eps0xy='$eps0xy'/g' GoodFit.gp

sed -i 's/^eta0x=.*/eta0x='$eta0x'/g'    GoodFit.gp
sed -i 's/^eta0y=.*/eta0y='$eta0y'/g'    GoodFit.gp
sed -i 's/^eta0z=.*/eta0z='$eta0z'/g'    GoodFit.gp
sed -i 's/^eta0yz=.*/eta0yz='$eta0yz'/g' GoodFit.gp
sed -i 's/^eta0xz=.*/eta0xz='$eta0xz'/g' GoodFit.gp
sed -i 's/^eta0xy=.*/eta0xy='$eta0xy'/g' GoodFit.gp


#######################################################################
######## Now name coefficients in script according to branch ##########
#######################################################################


sed -i "s/XXXX/$voigt/g" GoodFit.gp

#######################################################################
######## Now Run this gnuplot script according to stress range ########
#######################################################################

rm fit.log
gnuplot GoodFit.gp
grep +/- fit.log > HalfGPaFit.log
rm fit.log

if [ -f ${branch}_1.0GPa/DFPT/PpFin.txt ] && [ -f ${branch}_-1.0GPa/DFPT/PpFin.txt ]
  then
  sed 's@\^-0\\\.5/,/\^0\\\.5@\^-1\\\.0\/,\/\^1\\\.0@g' GoodFit.gp > 1GPaFit.gp
  gnuplot 1GPaFit.gp 
  grep +/- fit.log > OneGPaFit.log
fi
