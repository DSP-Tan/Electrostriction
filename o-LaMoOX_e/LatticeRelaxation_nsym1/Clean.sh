for i in Sig[XYZ]*
do

cd $i

for j in Sig[XYZ]*_*GPa
do

if [ -f $j/fart ]
then
rm -v $j/*-o*
rm -v $j/*-i*
rm -v $j/err
fi

if [ -f $j/DFPT/PpFin.txt ]
then
rm -v $j/DFPT/*-[oi]*
rm -v $j/DFPT/err
fi

done

cd ../

done
