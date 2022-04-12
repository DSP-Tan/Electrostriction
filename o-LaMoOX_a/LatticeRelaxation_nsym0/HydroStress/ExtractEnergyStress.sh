#!/bin/bash
LC_NUMERIC="en_US.UTF-8"
# This script extracts the energies and stresses from OUTCARs corresponding to 
# hydrostatic strain of  (x,x,x,0,0,0). The Lagrangian stress transformations 
# are not the fully general matrix transformations 
# and will be wrong if a different type of strian is applied.

eps0x=$(grep -A3 -i "relaxed ion dielectric tensor" ../Unstrained/DFPT/anaddb.out | sed -n 2p | awk '{print $1}')
eps0y=$(grep -A3 -i "relaxed ion dielectric tensor" ../Unstrained/DFPT/anaddb.out | sed -n 3p | awk '{print $2}')
eps0z=$(grep -A3 -i "relaxed ion dielectric tensor" ../Unstrained/DFPT/anaddb.out | sed -n 4p | awk '{print $3}')

eps_e0x=$( grep -A3 'Electronic dielectric tensor'  ../Unstrained/DFPT/anaddb.out | sed -n 2p | awk '{print $1}'  )
eps_e0y=$( grep -A3 'Electronic dielectric tensor'  ../Unstrained/DFPT/anaddb.out | sed -n 3p | awk '{print $2}'  )
eps_e0z=$( grep -A3 'Electronic dielectric tensor'  ../Unstrained/DFPT/anaddb.out | sed -n 4p | awk '{print $3}'  )

eta0x=$( awk -v ep="$eps0x" 'BEGIN {print 1/ep}' )
eta0y=$( awk -v ep="$eps0y" 'BEGIN {print 1/ep}' )
eta0z=$( awk -v ep="$eps0z" 'BEGIN {print 1/ep}' )

eta0_ex=$( awk -v ep="$eps_e0x" 'BEGIN {print 1/ep}' )
eta0_ey=$( awk -v ep="$eps_e0y" 'BEGIN {print 1/ep}' )
eta0_ez=$( awk -v ep="$eps_e0z" 'BEGIN {print 1/ep}' )

sed -i 's/^eps0x=.*/eps0x='$eps0x'/g' ShearFit.gp
sed -i 's/^eps0y=.*/eps0y='$eps0y'/g' ShearFit.gp
sed -i 's/^eps0z=.*/eps0z='$eps0z'/g' ShearFit.gp

sed -i 's/^eta0x=.*/eta0x='$eta0x'/g' ShearFit.gp
sed -i 's/^eta0y=.*/eta0y='$eta0y'/g' ShearFit.gp
sed -i 's/^eta0z=.*/eta0z='$eta0z'/g' ShearFit.gp

a0x=$(grep acell ../Unstrained/abi.out | tail -n1 | awk '{printf "%-10.7f", $2*0.5292083}')
a0y=$(grep acell ../Unstrained/abi.out | tail -n1 | awk '{printf "%-10.7f", $3*0.5292083}')
a0z=$(grep acell ../Unstrained/abi.out | tail -n1 | awk '{printf "%-10.7f", $4*0.5292083}')

V0=`awk -v ax="$a0x" -v ay="$a0y" -v az="$a0z" 'BEGIN {print 10^(-30)*(ax*ay*az)}'` ## in m^3
E0=$( grep '>>>>>>>>> Etotal=' epsZ_0.000/abi.out  | tail -n 1 | awk '{printf "%-20.14f", $3*27.2113834}') # Free energy of unstrained state in eV


echo "a0: $a0 V0:$V0 E0:$E0"

printf "%-9s\t%-20s\t%-20s\t%-10s\t%-10s\t%-10s\t%-10s\t%-10s\n" "#StrainZ" "U (GPa)"  "sig1 (GPa)" "sig3 (GPa)" "w_TA (cm-1)" "w_LA (cm-1)" "w_TO (cm-1)" "w_LO (cm-1)"   > StrainEnergyDensStress.txt


printf "%-20s\t%-20s\t%-20s\t%-15s\t%-15s\t%-15s\t%-15s\n" "#Sig4 (GPa)" "sig1 (GPa)" "sig3 (GPa)" "eps_ey" "eps_ez" "epsY" "epsZ" > PhonAndDielec_Anaddb.txt
#printf "%-9s\t%-20s\t%-15s\t%-15s\t%-10s\t%-10s\t%-10s\t%-10s\t%-10s\n" "#epsZ" "sig1 (GPa)" "w_TA (cm-1)" "w_LA (cm-1)" "w_TO (cm-1)" "w_LO (cm-1)" "eps_e" "eps_f1" "eps_f2" > PhonAndDielec_Anaddb.txt

#for j in `seq -0.04 0.01 0.04`
for j in `ls | grep Hydro_ | cut -d '_' -f 2 | cut -d 'G' -f1 | sort -n`
do

  energy=$(  grep '>>>>>>>>> Etotal='       Hydro_${j}GPa/abi.out | tail -n 1 | awk '{printf "%-20.14f\n", $3*27.2113834}')
  stress1=$( grep -A3 'stress tensor (GPa)' Hydro_${j}GPa/abi.out  | tail -n 3 | sed -n 1p | awk '{print $4}' )
  stress2=$( grep -A3 'stress tensor (GPa)' Hydro_${j}GPa/abi.out  | tail -n 3 | sed -n 2p | awk '{print $4}' )
  stress3=$( grep -A3 'stress tensor (GPa)' Hydro_${j}GPa/abi.out  | tail -n 3 | sed -n 3p | awk '{print $4}' )
  stress4=$( grep -A3 'stress tensor (GPa)' Hydro_${j}GPa/abi.out  | tail -n 3 | sed -n 1p | awk '{print $7}' )
  stress5=$( grep -A3 'stress tensor (GPa)' Hydro_${j}GPa/abi.out  | tail -n 3 | sed -n 2p | awk '{print $7}' )
  stress6=$( grep -A3 'stress tensor (GPa)' Hydro_${j}GPa/abi.out  | tail -n 3 | sed -n 3p | awk '{print $7}' )
                
  eps=$(     grep -A4 'Dielectric tensor' Hydro_${j}GPa/DFPT/abi.out | tail -n1 | awk '{print $5}' )
  
  w_TA=$(  grep -A2 'Phonon frequencies in cm-1' Hydro_${j}GPa/DFPT/abi.out   | tail -n3 | sed -n 2p | awk '{print $2}')
  w_LA=$(  grep -A2 'Phonon frequencies in cm-1' Hydro_${j}GPa/DFPT/abi.out   | tail -n3 | sed -n 2p | awk '{print $4}')
  w_TO=$(  grep -A2 'Phonon frequencies in cm-1' Hydro_${j}GPa/DFPT/abi.out   | tail -n3 | sed -n 2p | awk '{print $5}')
  w_LO=$(  grep -A2 'Phonon frequencies in cm-1' Hydro_${j}GPa/DFPT/abi.out   | tail -n3 | sed -n 3p | awk '{print $2}')
  
  epsX=$(grep -A3 -i "relaxed ion dielectric tensor" Hydro_${j}GPa/DFPT/anaddb.out | sed -n 2p | awk '{print $1}')
  epsY=$(grep -A3 -i "relaxed ion dielectric tensor" Hydro_${j}GPa/DFPT/anaddb.out | sed -n 3p | awk '{print $2}')
  epsZ=$(grep -A3 -i "relaxed ion dielectric tensor" Hydro_${j}GPa/DFPT/anaddb.out | sed -n 4p | awk '{print $3}')

  eps_ex=$( grep -A3 'Electronic dielectric tensor'  Hydro_${j}GPa/DFPT/anaddb.out | sed -n 2p | awk '{print $1}'  )
  eps_ey=$( grep -A3 'Electronic dielectric tensor'  Hydro_${j}GPa/DFPT/anaddb.out | sed -n 3p | awk '{print $2}'  )
  eps_ez=$( grep -A3 'Electronic dielectric tensor'  Hydro_${j}GPa/DFPT/anaddb.out | sed -n 4p | awk '{print $3}'  )
 
 
  w_TA_ana=$(  grep -A2 -i "Phonon frequencies in cm-1" Hydro_${j}GPa/DFPT/anaddb.out | tail -n 3 | sed -n 2p | awk '{print $2}' )
  w_LA_ana=$(  grep -A2 -i "Phonon frequencies in cm-1" Hydro_${j}GPa/DFPT/anaddb.out | tail -n 3 | sed -n 2p | awk '{print $4}' )
  w_TO_ana=$(  grep -A2 -i "Phonon frequencies in cm-1" Hydro_${j}GPa/DFPT/anaddb.out | tail -n 3 | sed -n 2p | awk '{print $5}' )
  w_LO_ana=$(  grep -A2 -i "Phonon frequencies in cm-1" Hydro_${j}GPa/DFPT/anaddb.out | tail -n 3 | sed -n 3p | awk '{print $2}' )

  t1=$( awk  -v s1="$stress1" -v alpha="${j}GPa" 'BEGIN {print s1*(1+alpha)}')   
  t2=$( awk  -v s2="$stress2" -v alpha="${j}GPa" 'BEGIN {print s2*(1+alpha)}')
  t3=$( awk  -v s3="$stress3" -v alpha="${j}GPa" 'BEGIN {print s3*(1+alpha)}')
  t4=$( awk  -v s4="$stress4" -v alpha="${j}GPa" 'BEGIN {print s4}')
  t5=$( awk  -v s5="$stress5" -v alpha="${j}GPa" 'BEGIN {print s5}')
  t6=$( awk  -v s6="$stress6" -v alpha="${j}GPa" 'BEGIN {print s6}')
  
  awk -v a="$stress4" -v E="${energy}" -v V0="$V0" -v E0="$E0" -v strass1="$stress1"  -v w_TA="$w_TA" -v w_LA="$w_LA" -v w_TO="$w_TO" -v w_LO="$w_LO" -v eps="$eps"  \
  'BEGIN {printf "%-20.14f\t%-20.14f\t%-20.10f\t%-10s\t%-10s\t%-10s\t%-10s\t%-10s\n", \
   a, 1.60217662*10^(-28)*(E-E0)/V0, strass1, w_TA, w_LA, w_TO, w_LO, eps  }' >> StrainEnergyDensStress.txt 

  
  awk -v j="$stress4" -v sig1="$stress1" -v sig3="$stress3" -v eps_ey="$eps_ey" -v eps_ez="$eps_ez"  -v epsY="$epsY" -v epsZ="$epsZ" \
  'BEGIN {printf "%-20s\t%-20s\t%-20s\t%-15s\t%-15s\t%-15s\t%-15s\n" , \
  j, sig1, sig3, eps_ey, eps_ez, epsY, epsZ}' >> PhonAndDielec_Anaddb.txt
      
done

