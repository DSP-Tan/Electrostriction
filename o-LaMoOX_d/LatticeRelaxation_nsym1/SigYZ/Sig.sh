for i in `seq -1.0 0.5 1.0`
do
   sig=$( awk -v GPa="$i" 'BEGIN {print GPa/29421.02648438959 }')
   mkdir SigYZ_${i}GPa
   
   if [ "$i" == "0.0" ]
   then
   
   cp ../fart.txt SigYZ_${i}GPa
   cp -r ../DFPT SigYZ_${i}GPa
   
   continue
   fi

   if [ ! -f SigYZ_${i}GPa/fart.txt ]
   then
      sed '/^strtarget/s/XXXX/'$sig'/g' abi.in > SigYZ_${i}GPa/abi.in
      cp abi.files SigYZ_${i}GPa
      sed  '/\-job-name/s/XXXX/SigYZ'${i}'/g' Run.sh > SigYZ_${i}GPa/Run.sh
      cp ~/Scripts/DFPT/Make*.sh SigYZ_${i}GPa/
      cp ../abi.files SigYZ_${i}GPa/
      
      cd  SigYZ_${i}GPa
      sbatch Run.sh
      
      cd ../
   fi

   done

