# Within a given stress branch, this will tell us the status
# of the different types of calculations going on. It will
# output something like:

# SigX_0.5GPa no no no

# This means that for the 0.5GPa stress, the relaxation is not done,
# the DFPT is not done, and the final anaddb postprocessing is not done.

# SigX_-0.5GPa yes yes no

# This means that for the -0.5GPa X-axial stress case, the relaxation is done,
# the DFPT perturbed wavefunctions and derivatives are done, and just the 
# anaddb post processing is not finished.

printf "%15s %15s %15s %15s\n" "Stress" "Relax" "Perturbations" "PostProc"
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
