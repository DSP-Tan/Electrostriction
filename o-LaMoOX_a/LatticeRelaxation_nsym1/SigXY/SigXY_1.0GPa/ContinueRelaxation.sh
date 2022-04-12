#!/bin/bash

## Get latest xred and rprimd from abi.out
natom=$(grep natom abi.in | awk '{print $2}')
echo $natom

grep -A ${natom} xred abi.out | tail -n $natom > xred.txt
grep -A 3 rprimd abi.out | tail -n 3 > rprimd.txt

sed -i -e '/rprim/{n;N;N;N;d}' abi.in
sed -i '/rprim/G' abi.in
sed -i '/rprim/r rprimd.txt' abi.in


#Ok we are just going to do this now for speed's sake
##                   1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6
sed -i -e '/xred/{n;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;d}' abi.in
sed -i '/xred/r xred.txt' abi.in

rm xred.txt rprimd.txt
