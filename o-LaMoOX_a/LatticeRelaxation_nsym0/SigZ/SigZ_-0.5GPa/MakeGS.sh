#!/bin/bash

# This script takes the input and output of a relaxation and makes
# an input file to just calculate the input. It takes the relaxed
# lattice vectors and cell coordinates from an ${IN} and ${OUT}
# contained one folder up from the current directory.

if [ $# -lt 2 ]; 
   then 
   printf "Not enough arguments - %d\n" $# 
   printf "Input is path to abi.in and abi.out of relaxation file calculation.\n"
   exit 0 
   fi

IN=$1
OUT=$2

printf "#input for non-centrosymmetric orthorhombic HfO2\n\n" > abi.GS
printf "ndtset    2\n\n" >> abi.GS
printf "autoparal 1\n\n" >> abi.GS

printf "#Crystal Def.\n" >> abi.GS
#printf "ntypat   2\n"    >> abi.GS
grep ^ntypat   ${IN} >> abi.GS
grep ^natom    ${IN} >> abi.GS
grep ^typat    ${IN} >> abi.GS
grep -i znucl  ${IN} | tail -n1 >> abi.GS

natom=$( grep natom ${IN} | awk '{print $2}')
z1=$(    grep znucl ${IN} | awk '{print $2}')
z2=$(    grep znucl ${IN} | awk '{print $3}')
z3=$(    grep znucl ${IN} | awk '{print $4}')
#printf "znucle $z1 $z2 $z3\n\n" >> abi.GS



# Get lattice constants in Bohr from output of Lattice relaxation
a1=$( grep acell ${OUT} | tail -n1 | awk '{print $2}' )
a2=$( grep acell ${OUT} | tail -n1 | awk '{print $3}' )
a3=$( grep acell ${OUT} | tail -n1 | awk '{print $4}' )
#printf "acell $a1 $a2 $a3\n"  >> abi.GS
printf "acell 3*1\n\n"  >> abi.GS

printf "rprim\n" >> abi.GS
grep -A3 "rprimd.*bohr" ${OUT} | tail -n 3 >> abi.GS



printf "\n" >> abi.GS
Nm1=$( echo "$natom-1" | bc )
grep -A${Nm1} xred ${OUT} | tail -n ${natom} >> abi.GS
echo  " " >> abi.GS

k=$( grep ngkpt ${IN} | awk '{print $2}' )

printf "kptopt   1\n"                  >> abi.GS
grep ' ngfft ' ${OUT} | tail -n1       >> abi.GS
grep ngkpt ${IN} >> abi.GS
grep nshiftk ${IN}                   >> abi.GS

Nshift=$(grep 'nshiftk' ${IN} | awk '{print $2}')
grep -A ${Nshift} '^shiftk ' ${IN}                     >> abi.GS


grep  '^ecut' ${IN}           >> abi.GS
grep  "^pawecutdg\b"   ${IN}  >> abi.GS
grep  "^pawxcdev\b"    ${IN}  >> abi.GS
grep  ixc    ${IN}  >> abi.GS
grep  nband  ${IN}  >> abi.GS
grep  diemac ${IN}  >> abi.GS
echo "" >> abi.GS

printf "# First SCF run       \n" >> abi.GS
printf "#irdwfk1   1\n"           >> abi.GS
printf "nstep1    100\n"          >> abi.GS
printf "iscf1     7\n"            >> abi.GS
printf "tolvrs1   1.0E-20\n\n"    >> abi.GS

printf "#Refinement using tolwfr\n" >> abi.GS
printf "nstep2    250\n"            >> abi.GS
printf "getwfk2   -1\n"             >> abi.GS
printf "iscf2     7\n"              >> abi.GS
printf "tolwfr2   1.0E-20\n\n"      >> abi.GS

printf "# Printing flags\n" >> abi.GS
printf "prtden    1\n"      >> abi.GS
printf "prteig    0\n"      >> abi.GS
printf "prtwf     1\n"      >> abi.GS
printf "prtposcar 0\n"      >> abi.GS
printf "prtcif    1\n"      >> abi.GS

