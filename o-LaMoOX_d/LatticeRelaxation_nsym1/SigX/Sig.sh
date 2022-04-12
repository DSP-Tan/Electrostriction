for i in `seq -1.0 0.5 1.0`
do
   sig=$( awk -v GPa="$i" 'BEGIN {print GPa/29421.02648438959 }')
   mkdir SigX_${i}GPa
   
   if [ "$i" == "0.0" ]
   then
   #cp -r ../SigX/SigX_0.0GPa ./SigX_0.0GPa
   continue
   fi

   if [ ! -f SigX_${i}GPa/fart.txt ]
   then
      sed '/^strtarget/s/XXXX/'$sig'/g' abi.in > SigX_${i}GPa/abi.in
      cp abi.files SigX_${i}GPa
      sed  '/\-job-name/s/XXXX/SigX'${i}'/g' Run.sh > SigX_${i}GPa/Run.sh
      cp ~/Scripts/DFPT/Make*.sh SigX_${i}GPa/
      cd  SigX_${i}GPa
      sbatch Run.sh
      cd ../
   fi

   done

