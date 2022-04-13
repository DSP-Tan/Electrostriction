for i in `seq -0.5 0.5 0.5`
do
   sig=$( awk -v GPa="$i" 'BEGIN {print GPa/29421.02648438959 }')
   mkdir SigZ_${i}GPa
   
   if [ "$i" == "0.0" ]
   then
   #cp -r ../SigZ/SigZ_0.0GPa ./SigZ_0.0GPa
   continue
   fi

   if [ ! -f SigZ_${i}GPa/fart.txt ]
   then
      sed '/^strtarget/s/XXXX/'$sig'/g' abi.in > SigZ_${i}GPa/abi.in
      cp abi.files SigZ_${i}GPa
      sed  '/\-job-name/s/XXXX/SigZ'${i}'/g' Run.sh > SigZ_${i}GPa/Run.sh
      cp ~/Scripts/DFPT/Make*.sh SigZ_${i}GPa/
      cd  SigZ_${i}GPa
      sbatch Run.sh
      cd ../
   fi

   done

