for i in Sig[XYZ]*_*GPa
do

if [ ! -f $i/fart.txt ] && [ ! -f $i/DFPT/fart.txt ]
then
printf "%10s %10s %10s\n" "$i" "no" "no"
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
