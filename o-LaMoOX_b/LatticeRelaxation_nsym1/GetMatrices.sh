#!/bin/bash


printf "Dielectric\n"
grep -A3 -i 'relaxed ion dielectric' anaddb.out  | tail -n3 | awk '{printf  "%6.2lf  %6.2lf  %6.2lf\n", $1, $2, $3}'

printf "Lattice vectors\n"
grep -A3 rprimd abi.out | tail -n3 | awk '{printf "%7.4lf  %7.4lf  %7.4lf\n" , $1*0.529177, $2*0.529177, $3*0.529177}'

