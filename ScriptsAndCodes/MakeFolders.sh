#!/bin/bash

for i in `seq 1 8 104` 
   do 
   
   j=$(awk -v fart="$i" 'BEGIN {print fart+7}') 
   name=$(printf "%dTo%d\n" $i $j)
   
   mkdir -p $name
   sed    's&abi-i&../abi-i&g'                    abi.files > ${name}/abi.files

   sed    's/^ndtset.*/ndtset 2/g'                   abi.in > ${name}/abi.in
   sed -i '/^# Data Set 2/,/^# Data set 3/d'                  ${name}/abi.in
   sed -i '/^rfelfd/d'                                        ${name}/abi.in
   sed -i '/^rfstrs/d'                                        ${name}/abi.in
   sed -i 's/rfphon3/rfphon2/g'                               ${name}/abi.in
   sed -i 's/rfdir3/rfdir2/g'                                 ${name}/abi.in
   sed -i 's/^rfatpol3  1   .*/rfatpol2 '$i' '$j'/g'          ${name}/abi.in
   sed -i "/nqpt3/,/tolvrs3/s/3/2/g"                          ${name}/abi.in
   
   sed 's/#SBATCH --job-name=.*/#SBATCH --job-name='$name'/g' Run.sh       > ${name}/Run.sh
   sed -i 's/#SBATCH --time=.*/#SBATCH --time=48:00:00/g'                  ${name}/Run.sh
   sed -i 's/#SBATCH --mem-per-cpu=.*/#SBATCH --mem-per-cpu=5548/g'        ${name}/Run.sh
   
   echo $name 
   done

name=ddk_elec
mkdir -p ${name}

sed    's&abi-i&../abi-i&g'                    abi.files > ${name}/abi.files

sed    '/^rfphon/d'                            abi.in    > ${name}/abi.in
sed -i '/^rfstrs/d'                                        ${name}/abi.in
sed -i '/^rfatpol/d'                                       ${name}/abi.in
printf "prtwf3  0\n"                                       >> ${name}/abi.in
printf "prtden3 0\n"                                      >> ${name}/abi.in

sed 's/#SBATCH --job-name=.*/#SBATCH --job-name='$name'/g' Run.sh     > ${name}/Run.sh
sed -i 's/#SBATCH --time=.*/#SBATCH --time=16:00:00/g'                  ${name}/Run.sh
sed -i 's/#SBATCH --mem-per-cpu=.*/#SBATCH --mem-per-cpu=5548/g'        ${name}/Run.sh
echo $name 

