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
rm -v $j/slurm.[0-9]*
rm -v $j/log.[0-9]*
fi

if [ -f $j/DFPT/PpFin.txt ]
then
rm -v $j/DFPT/*-[oi]*
rm -v $j/DFPT/err
rm -v $j/DFPT/log.[0-9]*
rm -v $j/DFPT/slurm.[0-9]*
fi

done

cd ../

done
