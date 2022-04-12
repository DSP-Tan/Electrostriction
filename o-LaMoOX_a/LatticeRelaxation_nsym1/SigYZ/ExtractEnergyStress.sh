#!/bin/bash
LC_NUMERIC="en_US.UTF-8"
# This script extracts the energies and stresses from OUTCARs corresponding to 
# hydrostatic strain of  (x,x,x,0,0,0). The Lagrangian stress transformations 
# are not the fully general matrix transformations 
# and will be wrong if a different type of strian is applied.



printf "%-9s\t%-20s\t%-15s\t%-15s\t%-10s\t%-10s\t%-10s\t%-10s\t%-10s\n" "#alpha" "stress1 (GPa)" "w_TA (cm-1)" "w_LA (cm-1)" "w_TO (cm-1)" "w_LO (cm-1)" "eps_e" "eps_f1" "eps_f2" > PhonAndDielec_Anaddb.txt

#for j in `seq -0.04 0.01 0.04`
for j in `ls | grep SigYZ_ | cut -d '_' -f 2 | sort -n`
do

  energy=$(  grep '>>>>>>>>> Etotal='       SigYZ_${j}/DFPT/abi.out | tail -n 1 | awk '{printf "%-20.14f\n", $3*27.2113834}')
  stress1=$( grep -A3 'stress tensor (GPa)' SigYZ_${j}/DFPT/abi.out  | tail -n 3 | sed -n 1p | awk '{print $4}' )
  stress2=$( grep -A3 'stress tensor (GPa)' SigYZ_${j}/DFPT/abi.out  | tail -n 3 | sed -n 2p | awk '{print $4}' )
  stress3=$( grep -A3 'stress tensor (GPa)' SigYZ_${j}/DFPT/abi.out  | tail -n 3 | sed -n 3p | awk '{print $4}' )
  stress4=$( grep -A3 'stress tensor (GPa)' SigYZ_${j}/DFPT/abi.out  | tail -n 3 | sed -n 1p | awk '{print $7}' )
  stress5=$( grep -A3 'stress tensor (GPa)' SigYZ_${j}/DFPT/abi.out  | tail -n 3 | sed -n 2p | awk '{print $7}' )
  stress6=$( grep -A3 'stress tensor (GPa)' SigYZ_${j}/DFPT/abi.out  | tail -n 3 | sed -n 3p | awk '{print $7}' )
                
  eps=$(     grep -A4 'Dielectric tensor' SigYZ_$j/DFPT/abi.out | tail -n1 | awk '{print $5}' )
  
 
  

  eps_f1=$( grep -A3 -i "relaxed ion dielectric tensor" SigYZ_$j/DFPT/anaddb.out | sed -n 2p | awk '{print $1}' )
  eps_f2=$( grep -A3 -i "relaxed ion dielectric tensor" SigYZ_$j/DFPT/anaddb.out | sed -n 3p | awk '{print $2}' )
  eps_f3=$( grep -A3 -i "relaxed ion dielectric tensor" SigYZ_$j/DFPT/anaddb.out | sed -n 4p | awk '{print $3}' )

  w_TA_ana=$(  grep -A2 -i "Phonon frequencies in cm-1" SigYZ_$j/DFPT/anaddb.out | tail -n 3 | sed -n 2p | awk '{print $2}' )
  w_LA_ana=$(  grep -A2 -i "Phonon frequencies in cm-1" SigYZ_$j/DFPT/anaddb.out | tail -n 3 | sed -n 2p | awk '{print $4}' )
  w_TO_ana=$(  grep -A2 -i "Phonon frequencies in cm-1" SigYZ_$j/DFPT/anaddb.out | tail -n 3 | sed -n 2p | awk '{print $5}' )
  w_LO_ana=$(  grep -A2 -i "Phonon frequencies in cm-1" SigYZ_$j/DFPT/anaddb.out | tail -n 3 | sed -n 3p | awk '{print $2}' )

  
  
  awk -v j="$j" -v sig4="$stress4" -v wTA="$w_TA_ana" -v wLA="$w_LA_ana" -v wTO="$w_TO_ana" -v wLO="$w_LO_ana" -v epse="$eps_e" -v epsf1="$eps_f1" -v epsf3="$eps_f3" \
  'BEGIN {printf "%-9.6f\t%-20.10f\t%-15.6f\t%-15.6f\t%-10.6f\t%-10.6f\t%-10.6f\t%-10.6f\t%-10.6f\n", \
  j, sig1, wTA, wLA, wTO, wLO, epse, epsf1, epsf3}' >> PhonAndDielec_Anaddb.txt
      
done

