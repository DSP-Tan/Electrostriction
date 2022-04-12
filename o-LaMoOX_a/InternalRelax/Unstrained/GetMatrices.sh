#!/bin/bash

for i in -0.5 0.0 0.5
do
printf "\n\n$i GPa\n\n"

printf "Dielectric\n"
grep -A3 -i 'relaxed ion dielectric' SigXY_${i}GPa/DFPT/anaddb.out  | tail -n3 | awk '{printf  "%6.2lf  %6.2lf  %6.2lf\n", $1, $2, $3}'

printf "Lattice vectors\n"
grep -A3 rprimd SigXY_${i}GPa/abi.out | tail -n3 | awk '{printf "%7.4lf  %7.4lf  %7.4lf\n" , $1*0.529177, $2*0.529177, $3*0.529177}'

done
