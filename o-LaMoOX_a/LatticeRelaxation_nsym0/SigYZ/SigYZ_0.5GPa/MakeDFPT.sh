#!/bin/bash

ScrpHome=/home/ulg/phythema/dtanner/Scripts
mkdir DFPT

cd DFPT


printf "#input for KTaO3\n\n" > abi.in
printf "ndtset    3\n\n" >> abi.in
printf "autoparal 1\n\n" >> abi.in

printf "#Crystal Def.\n" >> abi.in
grep ^ntypat  ../abi.GS            >> abi.in
grep ^natom   ../abi.GS            >> abi.in
grep ^typat   ../abi.GS            >> abi.in
grep -i znucl ../abi.GS | tail -n1 >> abi.in

natom=$( grep natom ../abi.GS | awk '{print $2}')
z1=$(    grep znucl ../abi.GS | awk '{print $2}')
z2=$(    grep znucl ../abi.GS | awk '{print $3}')


# Get lattice constants in Bohr from output of Lattice relaxation
a1=$( grep acell ../abi.GS | tail -n1 | awk '{print $2}' )
a2=$( grep acell ../abi.GS | tail -n1 | awk '{print $3}' )
a3=$( grep acell ../abi.GS | tail -n1 | awk '{print $4}' )
grep '^acell' ../abi.GS  >> abi.in

printf "\n\n"    >> abi.in
printf "rprim\n" >> abi.in
grep -A3 rprim ../abi.GS | tail -n 3 >> abi.in

printf "\n" >> abi.in
Nm1=$( echo "$natom-1" | bc )
grep -A${Nm1} xred ../abi.GS | tail -n ${natom} >> abi.in
echo  " " >> abi.in





k=$( grep ngkpt      ../abi.in | awk '{print $2}')
ecut=$(grep 'ecut\b' ../abi.in | awk '{print $2}')
nband=$(grep nband   ../abi.in | awk '{print $2}')
diemac=$(grep diemac ../abi.in | awk '{print $2}')
nshiftk=$(grep nshiftk ../abi.in | awk '{print $2}')

sed -n '/chksymbreak/,$p' $ScrpHome/DFPT/abi.DFPT >> abi.in

sed -i "/ngkpt/s/KK/$k/g"          abi.in
sed -i "/ecut/s/EEE/$ecut/g"       abi.in
sed -i "/nband/s/nnn/$nband/g"     abi.in
sed -i "/diemac/s/-eps-/$diemac/g" abi.in
sed -i "/^rfatpol/s/2/$natom/g"    abi.in
sed -i "/^nshiftk/s/nshiftk.*/nshiftk $nshiftk/g"    abi.in

grep ecutsm ../abi.in     >> abi.in
grep ngfft ../abi.GS      >> abi.in
grep ^pawecutdg ../abi.in >> abi.in
grep ^pawxcdev ../abi.in  >> abi.in

cp ../abi.files   .
cp ../qscript.pbs .

mv ../abi-o_DS2_DEN abi-i_DS1_DEN
mv ../abi-o_DS2_WFK abi-i_DS1_WFK

sed -i "/PBS -N/s/.*/#PBS -N k${k}E${ecut}DFPT/g"                              qscript.pbs
sed -i "/PBS -l walltime/s/.*/#PBS -l walltime=4:00:00/g"                      qscript.pbs
sed -i "/PBS -l select/s/.*/#PBS -l select=6:ncpus=24:mpiprocs=24:mem=12gb/g"  qscript.pbs

sed -i "/mpiexec_mpt/s/.*/mpiexec_mpt -n 144 abinit < abi.files \&\& echo \"fart\" > fart.txt/g" qscript.pbs

cd ../
