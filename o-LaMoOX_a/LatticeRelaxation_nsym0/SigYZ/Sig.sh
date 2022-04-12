for i in -1.1 -1.2 #`seq -1.5 0.5 1.5`
do
   sig=$( awk -v GPa="$i" 'BEGIN {print GPa/29421.02648438959 }')
   mkdir Shear_${i}GPa

   if [ ! -f Shear_${i}GPa/fart.txt ]
   then
      sed '/^strtarget/s/XXXX/'$sig'/g' abi.in > Shear_${i}GPa/abi.in
      cp abi.files Shear_${i}GPa
      sed  '/\-job-name/s/XXXX/Shear'${i}'/g' Run.sh > Shear_${i}GPa/Run.sh
      cp ~/Scripts/DFPT/Make*.sh Shear_${i}GPa/
      cd  Shear_${i}GPa
      sbatch Run.sh
      cd ../
   fi

   done

