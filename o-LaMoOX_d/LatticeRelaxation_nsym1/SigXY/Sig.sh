for i in -1.0 1.0 #-0.5 0.0 0.5 #`seq -1.0 0.5 1.0`
do
   sig=$( awk -v GPa="$i" 'BEGIN {print GPa/29421.02648438959 }')
   mkdir SigXY_${i}GPa
   
   if [ "$i" == "0.0" ]
   then
   
   cp ../fart.txt SigXY_${i}GPa
   cp -r ../DFPT SigXY_${i}GPa
   
   continue
   fi

   if [ ! -f SigXY_${i}GPa/fart.txt ]
   then
      sed '/^strtarget/s/XXXX/'$sig'/g' abi.in > SigXY_${i}GPa/abi.in
      cp abi.files SigXY_${i}GPa
      sed  '/\-job-name/s/XXXX/SigXY'${i}'/g' Run.sh > SigXY_${i}GPa/Run.sh
      cp ~/Scripts/DFPT/Make*.sh SigXY_${i}GPa/
      cp ../abi.files SigXY_${i}GPa/
      
      cd  SigXY_${i}GPa
      sbatch Run.sh
      
      cd ../
   fi

   done

