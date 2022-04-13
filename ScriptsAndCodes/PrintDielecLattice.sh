#!/bin/bash

# This is just a script for the fast analysis of certain aspects of structures. It can be modified easily
# to print different things.

# Run this in the same directory where there is an anaddb.out to get the relaxed ion dielectric constant.
# Run it on a file with the relaxed positions to print the relaxed lattice constants.


printf "Dielectric\n"
grep -A3 -i 'relaxed ion dielectric' anaddb.out  | tail -n3 | awk '{printf  "%6.2lf  %6.2lf  %6.2lf\n", $1, $2, $3}'

printf "Lattice vectors\n"
grep -A3 rprimd abiRelaxedPos.out | tail -n3 | awk '{printf "%7.4lf  %7.4lf  %7.4lf\n" , $1*0.529177, $2*0.529177, $3*0.529177}'

