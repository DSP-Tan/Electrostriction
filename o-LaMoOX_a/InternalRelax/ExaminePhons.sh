
printf "%10s %10s %10s %10s %10s %10s %10s %10s %10s %10s %10s\n" \
	"w (cm-1)" "a0 (A)" "s11 (GPa)" "s32 (GPa)" "s22 (GPa)" "s33 (GPa)" "epsX" "epsY" "epsZ" "epsYZ" "epsZY" > PhonLatPresh.txt

for i in HydroStrain/Hydro_-0.001/DFPT Unstrained/DFPT HydroStrain/Hydro_0.001/DFPT HydroStrain/Hydro_0.005/DFPT HydroStrain/Hydro_0.006/DFPT HydroStrain/Hydro_0.008/DFPT
do
   w=$(grep -A1 'Phonon frequencies in cm-1' $i/anaddb.out | tail -n1 | awk '{print $2}')
   a0=$(grep -A1 'Real(R)' $i/abi.out | tail -n1 | awk '{print $2*0.529177}')
   s11=$(grep -A3 'stress tensor.*GPa' $i/abi.out | sed -n '2p' | awk '{print $4}')
   s32=$(grep -A3 'stress tensor.*GPa' $i/abi.out | sed -n '2p' | awk '{print $7}')
   s22=$(grep -A3 'stress tensor.*GPa' $i/abi.out | sed -n '3p' | awk '{print $4}')
   s33=$(grep -A3 'stress tensor.*GPa' $i/abi.out | sed -n '4p' | awk '{print $4}')
   epsX=$(grep -A3 'Relaxed.*dielec'  $i/anaddb.out | sed -n 2p | awk '{print $1}')
   epsY=$(grep -A3 'Relaxed.*dielec'  $i/anaddb.out | sed -n 3p | awk '{print $2}')
   epsZ=$(grep -A3 'Relaxed.*dielec'  $i/anaddb.out | sed -n 4p | awk '{print $3}')
   epsZY=$(grep -A3 'Relaxed.*dielec' $i/anaddb.out | sed -n 4p | awk '{print $2}')
   epsYZ=$(grep -A3 'Relaxed.*dielec' $i/anaddb.out | sed -n 3p | awk '{print $3}')
   printf "%10.4g %10.4g %10.4g %10.4g %10.4g %10.4g %10.4g %10.4g %10.4g %10.4g %10.4g\n" "$w" "$a0" "$s11" "$s32" "$s22" "$s33" "$epsX" "$epsY" "$epsZ" "$epsYZ" "$epsZY" >> PhonLatPresh.txt
done
