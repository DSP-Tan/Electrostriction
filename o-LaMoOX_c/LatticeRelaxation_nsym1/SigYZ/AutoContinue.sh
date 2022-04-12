for i in Sig[XYZ]*_*GPa
do

if [ "$i" == "SigYZ_0.0GPa" ]
then
continue
fi

	
if [ ! -f $i/fart.txt ] 
then
cd $i
../ContinueRelaxation.sh
sbatch Run.sh
cd ../
fi

if [  -f $i/fart.txt ] && [ ! -f $i/DFPT/fart.txt ]
then
printf "%10s %10s %10s\n" "$i" "yes" "no"
fi

if [ -f $i/fart.txt ] && [ -f $i/DFPT/fart.txt ]
then
printf "%10s %10s %10s\n" "$i" "yes" "yes"
fi

done
