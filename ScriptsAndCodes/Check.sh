for i in Sig[XYZ]*_*GPa
do

if [ ! -f $i/fart.txt ] && [ ! -f $i/DFPT/fart.txt ]
then
printf "%15s %15s %15s %15s\n" "$i" "no" "no" "no"
fi

if [  -f $i/fart.txt ] && [ ! -f $i/DFPT/fart.txt ]
then
printf "%15s %15s %15s %15s\n" "$i" "yes" "no" "no"
fi

if [ -f $i/fart.txt ] && [ -f $i/DFPT/fart.txt ] && [ ! -f $i/DFPT/PpFin.txt ]
then
printf "%15s %15s %15s %15s\n" "$i" "yes" "yes" "no"
fi

if [ -f $i/fart.txt ] && [ -f $i/DFPT/fart.txt ] && [ -f $i/DFPT/PpFin.txt ]
then
printf "%15s %15s %15s %15s\n" "$i" "yes" "yes" "yes"
fi

done
