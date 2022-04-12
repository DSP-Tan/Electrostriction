#!/bin/bash
LC_NUMERIC="en_US.UTF-8"
# This script extracts the energies and stresses from OUTCARs corresponding to 
# hydrostatic strain of  (x,x,x,0,0,0). The Lagrangian stress transformations 
# are not the fully general matrix transformations 
# and will be wrong if a different type of strian is applied.

eps0x=$(grep -A3 -i "relaxed ion dielectric tensor" SigXZ_0.0GPa/DFPT/anaddb.out  | sed -n 2p | awk '{print $1}')
eps0xy=$(grep -A3 -i "relaxed ion dielectric tensor" SigXZ_0.0GPa/DFPT/anaddb.out | sed -n 2p | awk '{print $2}')
eps0xz=$(grep -A3 -i "relaxed ion dielectric tensor" SigXZ_0.0GPa/DFPT/anaddb.out | sed -n 2p | awk '{print $3}')
eps0y=$(grep -A3 -i "relaxed ion dielectric tensor" SigXZ_0.0GPa/DFPT/anaddb.out  | sed -n 3p | awk '{print $2}')
eps0yz=$(grep -A3 -i "relaxed ion dielectric tensor" SigXZ_0.0GPa/DFPT/anaddb.out | sed -n 3p | awk '{print $3}')
eps0z=$(grep -A3 -i "relaxed ion dielectric tensor" SigXZ_0.0GPa/DFPT/anaddb.out  | sed -n 4p | awk '{print $3}')

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


awk  'BEGIN {printf "%-9s %-9s %-15s %-6s %-6s %-6s %-15s %-6s %-6s %-6s %-15s\n" , \
                    "sig (GPa)", "sig5", "epsX", "epsXY", "epsXZ", "epsYX", "epsY", "epsYZ",  "epsZX", "epsZY", "epsZ"}' > StressPerm.txt




for j in `ls | grep SigXZ_ | cut -d '_' -f 2 | cut -d 'G' -f 1 | sort -n`
do
if [ -f SigXZ_${j}GPa/DFPT/anaddb.in ]
then
  energy=$(  grep '>>>>>>>>> Etotal='       SigXZ_${j}GPa/abi.out | tail -n 1 | awk '{printf "%-20.14f\n", $3*27.2113834}')
  stress1=$( grep -A3 'stress tensor (GPa)' SigXZ_${j}GPa/abi.out  | tail -n 3 | sed -n 1p | awk '{print $4}' )
  stress2=$( grep -A3 'stress tensor (GPa)' SigXZ_${j}GPa/abi.out  | tail -n 3 | sed -n 2p | awk '{print $4}' )
  stress3=$( grep -A3 'stress tensor (GPa)' SigXZ_${j}GPa/abi.out  | tail -n 3 | sed -n 3p | awk '{print $4}' )
  stress4=$( grep -A3 'stress tensor (GPa)' SigXZ_${j}GPa/abi.out  | tail -n 3 | sed -n 1p | awk '{print $7}' )
  stress5=$( grep -A3 'stress tensor (GPa)' SigXZ_${j}GPa/abi.out  | tail -n 3 | sed -n 2p | awk '{print $7}' )
  stress6=$( grep -A3 'stress tensor (GPa)' SigXZ_${j}GPa/abi.out  | tail -n 3 | sed -n 3p | awk '{print $7}' )
                
  
  epsX=$(grep -A3 -i "relaxed ion dielectric tensor"  SigXZ_${j}GPa/DFPT/anaddb.out  | sed -n 2p | awk '{print $1}')
  epsXY=$(grep -A3 -i "relaxed ion dielectric tensor" SigXZ_${j}GPa/DFPT/anaddb.out | sed -n 2p | awk '{print $2}')
  epsXZ=$(grep -A3 -i "relaxed ion dielectric tensor" SigXZ_${j}GPa/DFPT/anaddb.out | sed -n 2p | awk '{print $3}')
  epsYX=$(grep -A3 -i "relaxed ion dielectric tensor" SigXZ_${j}GPa/DFPT/anaddb.out | sed -n 3p | awk '{print $1}')
  epsY=$(grep -A3 -i "relaxed ion dielectric tensor"  SigXZ_${j}GPa/DFPT/anaddb.out  | sed -n 3p | awk '{print $2}')
  epsYZ=$(grep -A3 -i "relaxed ion dielectric tensor" SigXZ_${j}GPa/DFPT/anaddb.out | sed -n 3p | awk '{print $3}')
  epsZX=$(grep -A3 -i "relaxed ion dielectric tensor" SigXZ_${j}GPa/DFPT/anaddb.out | sed -n 4p | awk '{print $1}')
  epsZY=$(grep -A3 -i "relaxed ion dielectric tensor" SigXZ_${j}GPa/DFPT/anaddb.out | sed -n 4p | awk '{print $2}')
  epsZ=$(grep -A3 -i "relaxed ion dielectric tensor"  SigXZ_${j}GPa/DFPT/anaddb.out  | sed -n 4p | awk '{print $3}')

  awk -v j="$j" -v sig1="$stress1" -v sig2="$stress2" -v sig3="$stress3" -v sig4="$stress4" -v sig5="$stress5" -v sig6="$stress6" \
      -v eps_ex="$eps_ex" -v eps_ey="$eps_ey" -v eps_ez="$eps_ez" \
      -v epsX="$epsX" -v epsY="$epsY" -v epsZ="$epsZ" -v epsXY="$epsXY" -v epsXZ="$epsXZ" -v epsYX="$epsYX" -v epsYZ="$epsYZ" -v epsZX="$epsZX" -v epsZY="$epsZY" \
  'BEGIN {printf "%-9s %-9.6f %-15.4f %-6.2f %-6.2f %-6.2f %-15.4f %-6.2f %-6.2f %-6.2f %-15.4f\n" , \
                    j, sig5,  epsX, epsXY, epsXZ, epsYX, epsY, epsYZ,  epsZX, epsZY, epsZ}' >> StressPerm.txt
fi      
done


sed 's@\^-0\\\.5/,/\^0\\\.5@\^-1\\\.0\/,\/\^1\\\.0@g' GoodFit.gp > 1GPaFit.gp

rm fit.log
gnuplot GoodFit.gp
grep +/- fit.log > HalfGPaFit.log
rm fit.log

gnuplot 1GPaFit.gp 
grep +/- fit.log > OneGPaFit.log
