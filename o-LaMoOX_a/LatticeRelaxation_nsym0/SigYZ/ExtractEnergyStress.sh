#!/bin/bash
LC_NUMERIC="en_US.UTF-8"
# This script extracts the energies and stresses from OUTCARs corresponding to 
# hydrostatic strain of  (x,x,x,0,0,0). The Lagrangian stress transformations 
# are not the fully general matrix transformations 
# and will be wrong if a different type of strian is applied.

eps01=$(grep -A3 -i "relaxed ion dielectric tensor" ../Unstrained/DFPT/anaddb.out | sed -n 2p | awk '{print $1}')
eta0=$( awk -v ep="$eps01" 'BEGIN {print 1/ep}' )

sed -i -e 's/^eps01=.*/eps01='$eps01'/g' -e 's/^eta=.*/eta='$eta0'/g'   GoodFit.gp

a0=$(grep acell Shear_0.000/DFPT/abi.out | tail -n1 | awk '{printf "%-10.7f", $2*0.5292083}')
V0=`awk -v a="$a0" 'BEGIN {print 10^(-30)*a^3/4}'` ## in m^3
E0=$( grep '>>>>>>>>> Etotal=' Shear_0.000/DFPT/abi.out  | tail -n 1 | awk '{printf "%-20.14f", $3*27.2113834}') # Free energy of unstrained state in eV


echo "a0: $a0 V0:$V0 E0:$E0"

printf "%-7s\t%-20s\t%-20s\t%-10s\t%-10s\t%-10s\t%-10s\t%-10s\n" "#alpha" "U (GPa)"  "stress1 (GPa)" "w_TA (cm-1)" "w_LA (cm-1)" "w_TO (cm-1)" "w_LO (cm-1)" "dielectric"  > StrainEnergyDensStress.txt

printf "%-7s\t%-20s\t%-20s\n" "#alpha" "t1 (GPa)"  "U (GPa)"      > LagrangianStress.txt

printf "%-9s\t%-20s\t%-15s\t%-15s\t%-10s\t%-10s\t%-10s\t%-10s\t%-10s\n" "#alpha" "stress1 (GPa)" "w_TA (cm-1)" "w_LA (cm-1)" "w_TO (cm-1)" "w_LO (cm-1)" "eps_e" "eps_f1" "eps_f2" > PhonAndDielec_Anaddb.txt

#for j in `seq -0.04 0.01 0.04`
for j in `ls | grep Shear_ | cut -d '_' -f 2 | sort -n`
do

  energy=$(  grep '>>>>>>>>> Etotal='       Shear_${j}/DFPT/abi.out | tail -n 1 | awk '{printf "%-20.14f\n", $3*27.2113834}')
  stress1=$( grep -A3 'stress tensor (GPa)' Shear_${j}/DFPT/abi.out  | tail -n 3 | sed -n 1p | awk '{print $4}' )
  stress2=$( grep -A3 'stress tensor (GPa)' Shear_${j}/DFPT/abi.out  | tail -n 3 | sed -n 2p | awk '{print $4}' )
  stress3=$( grep -A3 'stress tensor (GPa)' Shear_${j}/DFPT/abi.out  | tail -n 3 | sed -n 3p | awk '{print $4}' )
  stress4=$( grep -A3 'stress tensor (GPa)' Shear_${j}/DFPT/abi.out  | tail -n 3 | sed -n 1p | awk '{print $7}' )
  stress5=$( grep -A3 'stress tensor (GPa)' Shear_${j}/DFPT/abi.out  | tail -n 3 | sed -n 2p | awk '{print $7}' )
  stress6=$( grep -A3 'stress tensor (GPa)' Shear_${j}/DFPT/abi.out  | tail -n 3 | sed -n 3p | awk '{print $7}' )
                
  eps=$(     grep -A4 'Dielectric tensor' Shear_$j/DFPT/abi.out | tail -n1 | awk '{print $5}' )
  
  w_TA=$(  grep -A2 'Phonon frequencies in cm-1' Shear_$j/DFPT/abi.out   | tail -n3 | sed -n 2p | awk '{print $2}')
  w_LA=$(  grep -A2 'Phonon frequencies in cm-1' Shear_$j/DFPT/abi.out   | tail -n3 | sed -n 2p | awk '{print $4}')
  w_TO=$(  grep -A2 'Phonon frequencies in cm-1' Shear_$j/DFPT/abi.out   | tail -n3 | sed -n 2p | awk '{print $5}')
  w_LO=$(  grep -A2 'Phonon frequencies in cm-1' Shear_$j/DFPT/abi.out   | tail -n3 | sed -n 3p | awk '{print $2}')
  
  
  eps_e=$(     grep -A3 'Electronic dielectric tensor'  Shear_$j/DFPT/anaddb.out | tail -n1 | awk '{print $3}' )

  eps_f1=$( grep -A3 -i "relaxed ion dielectric tensor" Shear_$j/DFPT/anaddb.out | sed -n 2p | awk '{print $1}' )
  eps_f2=$( grep -A3 -i "relaxed ion dielectric tensor" Shear_$j/DFPT/anaddb.out | sed -n 3p | awk '{print $2}' )
  eps_f3=$( grep -A3 -i "relaxed ion dielectric tensor" Shear_$j/DFPT/anaddb.out | sed -n 4p | awk '{print $3}' )

  w_TA_ana=$(  grep -A2 -i "Phonon frequencies in cm-1" Shear_$j/DFPT/anaddb.out | tail -n 3 | sed -n 2p | awk '{print $2}' )
  w_LA_ana=$(  grep -A2 -i "Phonon frequencies in cm-1" Shear_$j/DFPT/anaddb.out | tail -n 3 | sed -n 2p | awk '{print $4}' )
  w_TO_ana=$(  grep -A2 -i "Phonon frequencies in cm-1" Shear_$j/DFPT/anaddb.out | tail -n 3 | sed -n 2p | awk '{print $5}' )
  w_LO_ana=$(  grep -A2 -i "Phonon frequencies in cm-1" Shear_$j/DFPT/anaddb.out | tail -n 3 | sed -n 3p | awk '{print $2}' )

  t1=$( awk  -v s1="$stress1" -v alpha="$j" 'BEGIN {print s1*(1+alpha)}')   
  t2=$( awk  -v s2="$stress2" -v alpha="$j" 'BEGIN {print s2*(1+alpha)}')
  t3=$( awk  -v s3="$stress3" -v alpha="$j" 'BEGIN {print s3*(1+alpha)}')
  t4=$( awk  -v s4="$stress4" -v alpha="$j" 'BEGIN {print s4}')
  t5=$( awk  -v s5="$stress5" -v alpha="$j" 'BEGIN {print s5}')
  t6=$( awk  -v s6="$stress6" -v alpha="$j" 'BEGIN {print s6}')
  
  awk -v a="$j" -v E="${energy}" -v V0="$V0" -v E0="$E0" -v strass1="$stress1"  -v w_TA="$w_TA" -v w_LA="$w_LA" -v w_TO="$w_TO" -v w_LO="$w_LO" -v eps="$eps"  \
  'BEGIN {printf "%-7.4f\t%-20.14f\t%-20.10f\t%-10s\t%-10s\t%-10s\t%-10s\t%-10s\n", \
   a, 1.60217662*10^(-28)*(E-E0)/V0, strass1, w_TA, w_LA, w_TO, w_LO, eps  }' >> StrainEnergyDensStress.txt 

  # Density in GPa (e to get to J, /V0 to Pa, 10^-9 to G Pa)
  
  awk -v a="$j" -v E="${energy}" -v E0="${E0}" -v V0="$V0" -v t1="$t1"  \
  'BEGIN {printf "%-7.4f\t%-20.14f\t%-20.10f\n", a, t1, 1.60217662*10^(-28)*(E-E0)/V0 }' >> LagrangianStress.txt
  
  awk -v j="$j" -v sig1="$stress1" -v wTA="$w_TA_ana" -v wLA="$w_LA_ana" -v wTO="$w_TO_ana" -v wLO="$w_LO_ana" -v epse="$eps_e" -v epsf1="$eps_f1" -v epsf3="$eps_f3" \
  'BEGIN {printf "%-9.6f\t%-20.10f\t%-15.6f\t%-15.6f\t%-10.6f\t%-10.6f\t%-10.6f\t%-10.6f\t%-10.6f\n", \
  j, sig1, wTA, wLA, wTO, wLO, epse, epsf1, epsf3}' >> PhonAndDielec_Anaddb.txt
      
done

