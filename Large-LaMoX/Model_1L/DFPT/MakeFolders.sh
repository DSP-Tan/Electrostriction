#!/bin/bash

for i in `seq 1 3 108` 
   do 
   j=$(awk -v fart="$i" 'BEGIN {print fart+2}') 
   name=$(printf "%dTo%d\n" $i $j)
   if [ $name == "1To3" ]
   then
	   continue
   fi
   
   #mkdir -p $name
   #sed 's&abi-i&../abi-i&g' abi.files > ${name}/abi.files
   #sed 's/^rfatpol2  1   .*/rfatpol2 '$i' '$j'/g' abi.in > ${name}/abi.in
   #sed 's/#SBATCH --job-name=LaM_1L/#SBATCH --job-name='$name'/g' Run.sh > ${name}/Run.sh
   sed -i 's/#SBATCH --time=24:00:00/#SBATCH --time=16:00:00/g' ${name}/Run.sh
   grep "time=16" ${name}/Run.sh
   
   echo $name 
   done


