for i in `seq -0.5 0.5 0.5`
do
   sig=$( awk -v GPa="$i" 'BEGIN {print GPa/29421.02648438959 }')
   mkdir SigY_${i}GPa
   
   if [ "$i" == "0.0" ]
   then
   #cp -r ../SigY/SigY_0.0GPa ./SigY_0.0GPa
   continue
   fi

   if [ ! -f SigY_${i}GPa/fart.txt ]
   then
      sed '/^strtarget/s/XXXX/'$sig'/g' abi.in > SigY_${i}GPa/abi.in
      cp abi.files SigY_${i}GPa
      sed  '/\-job-name/s/XXXX/SigY'${i}'/g' Run.sh > SigY_${i}GPa/Run.sh
      cp ~/Scripts/DFPT/Make*.sh SigY_${i}GPa/
      cd  SigY_${i}GPa
      sbatch Run.sh
      cd ../
   fi

   done

