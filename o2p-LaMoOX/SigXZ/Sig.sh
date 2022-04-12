for i in `seq -0.5 0.5 0.5`
do
   sig=$( awk -v GPa="$i" 'BEGIN {print GPa/29421.02648438959 }')
   mkdir SigXZ_${i}GPa
   
   if [ "$i" == "0.0" ]
   then
   #cp -r ../SigXZ/SigXZ_0.0GPa ./SigXZ_0.0GPa
   continue
   fi

   if [ ! -f SigXZ_${i}GPa/fart.txt ]
   then
      sed '/^strtarget/s/XXXX/'$sig'/g' abi.in > SigXZ_${i}GPa/abi.in
      cp abi.files SigXZ_${i}GPa
      sed  '/\-job-name/s/XXXX/SigXZ'${i}'/g' Run.sh > SigXZ_${i}GPa/Run.sh
      cp ~/Scripts/DFPT/Make*.sh SigXZ_${i}GPa/
      cd  SigXZ_${i}GPa
      sbatch Run.sh
      cd ../
   fi

   done

