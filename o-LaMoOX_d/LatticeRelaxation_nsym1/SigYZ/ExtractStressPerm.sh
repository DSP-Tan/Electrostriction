#!/bin/bash
LC_NUMERIC="en_US.UTF-8"
# This script extracts the energies and stresses from OUTCARs corresponding to 
# hydrostatic strain of  (x,x,x,0,0,0). The Lagrangian stress transformations 
# are not the fully general matrix transformations 
# and will be wrong if a different type of strian is applied.

eps0x=$(grep -A3 -i "relaxed ion dielectric tensor" SigYZ_0.0GPa/DFPT/anaddb.out  | sed -n 2p | awk '{print $1}')
eps0xy=$(grep -A3 -i "relaxed ion dielectric tensor" SigYZ_0.0GPa/DFPT/anaddb.out | sed -n 2p | awk '{print $2}')
eps0xz=$(grep -A3 -i "relaxed ion dielectric tensor" SigYZ_0.0GPa/DFPT/anaddb.out | sed -n 2p | awk '{print $3}')
eps0y=$(grep -A3 -i "relaxed ion dielectric tensor" SigYZ_0.0GPa/DFPT/anaddb.out  | sed -n 3p | awk '{print $2}')
eps0yz=$(grep -A3 -i "relaxed ion dielectric tensor" SigYZ_0.0GPa/DFPT/anaddb.out | sed -n 3p | awk '{print $3}')
eps0z=$(grep -A3 -i "relaxed ion dielectric tensor" SigYZ_0.0GPa/DFPT/anaddb.out  | sed -n 4p | awk '{print $3}')

eps_e0x=$( grep -A3 'Electronic dielectric tensor'  SigYZ_0.0GPa/DFPT/anaddb.out | sed -n 2p | awk '{print $1}'  )
eps_e0y=$( grep -A3 'Electronic dielectric tensor'  SigYZ_0.0GPa/DFPT/anaddb.out | sed -n 3p | awk '{print $2}'  )
eps_e0z=$( grep -A3 'Electronic dielectric tensor'  SigYZ_0.0GPa/DFPT/anaddb.out | sed -n 4p | awk '{print $3}'  )

eta0x=$( awk -v ep="$eps0x" 'BEGIN {print 1/ep}' )
eta0y=$( awk -v ep="$eps0y" 'BEGIN {print 1/ep}' )
eta0z=$( awk -v ep="$eps0z" 'BEGIN {print 1/ep}' )

eta0_ex=$( awk -v ep="$eps_e0x" 'BEGIN {print 1/ep}' )
eta0_ey=$( awk -v ep="$eps_e0y" 'BEGIN {print 1/ep}' )
eta0_ez=$( awk -v ep="$eps_e0z" 'BEGIN {print 1/ep}' )

sed -i 's/^eps0x=.*/eps0x='$eps0x'/g' GoodFit.gp
sed -i 's/^eps0y=.*/eps0y='$eps0y'/g' GoodFit.gp
sed -i 's/^eps0z=.*/eps0z='$eps0z'/g' GoodFit.gp
sed -i 's/^eps0yz=.*/eps0yz='$eps0yz'/g' GoodFit.gp
sed -i 's/^eps0xz=.*/eps0xz='$eps0xz'/g' GoodFit.gp
sed -i 's/^eps0xy=.*/eps0xy='$eps0xy'/g' GoodFit.gp


#sed -i 's/^eta0x=.*/eta0x='$eta0x'/g' LayerFit.gp
#sed -i 's/^eta0y=.*/eta0y='$eta0y'/g' LayerFit.gp
#sed -i 's/^eta0z=.*/eta0z='$eta0z'/g' LayerFit.gp

a0x=$(grep acell SigYZ_0.0GPa/abi.out | tail -n1 | awk '{printf "%-10.7f", $2*0.5292083}')
a0y=$(grep acell SigYZ_0.0GPa/abi.out | tail -n1 | awk '{printf "%-10.7f", $3*0.5292083}')
a0z=$(grep acell SigYZ_0.0GPa/abi.out | tail -n1 | awk '{printf "%-10.7f", $4*0.5292083}')


awk  'BEGIN {printf "%-9s %-9s %-15s %-6s %-6s %-6s %-15s %-6s %-6s %-6s %-15s\n" , \
                    "sig (GPa)", "sig1", "epsX", "epsXY", "epsXZ", "epsYX", "epsY", "epsYZ",  "epsZX", "epsZY", "epsZ"}' > StressPerm.txt




for j in `ls | grep SigYZ_ | cut -d '_' -f 2 | cut -d 'G' -f 1 | sort -n`
do
if [ -f SigYZ_${j}GPa/DFPT/anaddb.in ]
then
  energy=$(  grep '>>>>>>>>> Etotal='       SigYZ_${j}GPa/DFPT/abi.out | tail -n 1 | awk '{printf "%-20.14f\n", $3*27.2113834}')
  stress1=$( grep -A3 'stress tensor (GPa)' SigYZ_${j}GPa/DFPT/abi.out  | tail -n 3 | sed -n 1p | awk '{print $4}' )
  stress2=$( grep -A3 'stress tensor (GPa)' SigYZ_${j}GPa/DFPT/abi.out  | tail -n 3 | sed -n 2p | awk '{print $4}' )
  stress3=$( grep -A3 'stress tensor (GPa)' SigYZ_${j}GPa/DFPT/abi.out  | tail -n 3 | sed -n 3p | awk '{print $4}' )
  stress4=$( grep -A3 'stress tensor (GPa)' SigYZ_${j}GPa/DFPT/abi.out  | tail -n 3 | sed -n 1p | awk '{print $7}' )
  stress5=$( grep -A3 'stress tensor (GPa)' SigYZ_${j}GPa/DFPT/abi.out  | tail -n 3 | sed -n 2p | awk '{print $7}' )
  stress6=$( grep -A3 'stress tensor (GPa)' SigYZ_${j}GPa/DFPT/abi.out  | tail -n 3 | sed -n 3p | awk '{print $7}' )
                
  
  epsX=$(grep -A3 -i "relaxed ion dielectric tensor"  SigYZ_${j}GPa/DFPT/anaddb.out  | sed -n 2p | awk '{print $1}')
  epsXY=$(grep -A3 -i "relaxed ion dielectric tensor" SigYZ_${j}GPa/DFPT/anaddb.out | sed -n 2p | awk '{print $2}')
  epsXZ=$(grep -A3 -i "relaxed ion dielectric tensor" SigYZ_${j}GPa/DFPT/anaddb.out | sed -n 2p | awk '{print $3}')
  epsYX=$(grep -A3 -i "relaxed ion dielectric tensor" SigYZ_${j}GPa/DFPT/anaddb.out | sed -n 3p | awk '{print $1}')
  epsY=$(grep -A3 -i "relaxed ion dielectric tensor"  SigYZ_${j}GPa/DFPT/anaddb.out  | sed -n 3p | awk '{print $2}')
  epsYZ=$(grep -A3 -i "relaxed ion dielectric tensor" SigYZ_${j}GPa/DFPT/anaddb.out | sed -n 3p | awk '{print $3}')
  epsZX=$(grep -A3 -i "relaxed ion dielectric tensor" SigYZ_${j}GPa/DFPT/anaddb.out | sed -n 4p | awk '{print $1}')
  epsZY=$(grep -A3 -i "relaxed ion dielectric tensor" SigYZ_${j}GPa/DFPT/anaddb.out | sed -n 4p | awk '{print $2}')
  epsZ=$(grep -A3 -i "relaxed ion dielectric tensor"  SigYZ_${j}GPa/DFPT/anaddb.out  | sed -n 4p | awk '{print $3}')

  eps_ex=$( grep -A3 'Electronic dielectric tensor'  SigYZ_${j}GPa/DFPT/anaddb.out | sed -n 2p | awk '{print $1}'  )
  eps_ey=$( grep -A3 'Electronic dielectric tensor'  SigYZ_${j}GPa/DFPT/anaddb.out | sed -n 3p | awk '{print $2}'  )
  eps_ez=$( grep -A3 'Electronic dielectric tensor'  SigYZ_${j}GPa/DFPT/anaddb.out | sed -n 4p | awk '{print $3}'  )
 
 
  w_TA=$(  grep -A2 -i "Phonon frequencies in cm-1" SigYZ_${j}GPa/DFPT/anaddb.out | tail -n 3 | sed -n 2p | awk '{print $2}' )
  w_LA=$(  grep -A2 -i "Phonon frequencies in cm-1" SigYZ_${j}GPa/DFPT/anaddb.out | tail -n 3 | sed -n 2p | awk '{print $4}' )
  w_TO=$(  grep -A2 -i "Phonon frequencies in cm-1" SigYZ_${j}GPa/DFPT/anaddb.out | tail -n 3 | sed -n 2p | awk '{print $5}' )
  w_LO=$(  grep -A2 -i "Phonon frequencies in cm-1" SigYZ_${j}GPa/DFPT/anaddb.out | tail -n 3 | sed -n 3p | awk '{print $2}' )

  
  awk -v j="$j" -v sig1="$stress1" -v sig2="$stress2" -v sig3="$stress3" -v sig4="$stress4" -v sig5="$stress5" -v sig6="$stress6" \
      -v eps_ex="$eps_ex" -v eps_ey="$eps_ey" -v eps_ez="$eps_ez" \
      -v epsX="$epsX" -v epsY="$epsY" -v epsZ="$epsZ" -v epsXY="$epsXY" -v epsXZ="$epsXZ" -v epsYX="$epsYX" -v epsYZ="$epsYZ" -v epsZX="$epsZX" -v epsZY="$epsZY" \
  'BEGIN {printf "%-9s %-9.6f %-15.4f %-6.2f %-6.2f %-6.2f %-15.4f %-6.2f %-6.2f %-6.2f %-15.4f\n" , \
                    j, sig1,  epsX, epsXY, epsXZ, epsYX, epsY, epsYZ,  epsZX, epsZY, epsZ}' >> StressPerm.txt
fi      
done

