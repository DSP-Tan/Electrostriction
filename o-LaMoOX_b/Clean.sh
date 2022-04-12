for i in Sig[XYZ]*
do

cd $i

for j in Sig*
do

if [ -f $j/fart ]
then
rm $j/*-o*
rm $j/*-i*
rm $j/err
fi

if [ -f $j/DFPT/PpFin.txt ]
then
rm $j/DFPT/*-o*
rm $j/DFPT/err
fi

done

cd ../

done
