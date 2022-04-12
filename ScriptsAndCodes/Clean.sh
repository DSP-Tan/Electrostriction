#!/bin/bash

## This cleaning script is made for the purpose of cleaning
## the Lamox directories where the different stresses were
## applied to a particular 26 atom Lamox structure in order to 
## calculate the electrostriction tensor.

## The root directory would be one in which the system has first been 
## relaxed before the stresses are applied. So for example it will be named
## LatticeRelaxation_nsym0, where the nsym0 gives the value that nsym is set
## to in the initial relaxation.

## The rest of the directory tree will then be ordered as:


# Clear out the unstressed DFPT folder
if [ -f DFPT/PpFin.txt ]
  then
  
  rm -v DFPT/__ABI_MPIABORTFILE__.lock
  rm -v DFPT/*-[oi]*
  rm -v DFPT/err
  rm -v DFPT/slurm-[0-9]*.out
  rm -v DFPT/log.[0-9]*
  rm -v DFPT/anaddb.log

fi

# Loop over directories in which a particular stress component
# is varied
for i in Sig[XYZ]*
  do

  cd $i
  
  # Loop over particular stress (-0.5 GPa etc.) relaxations and
  # subsequent permitivity calculations. 
  for j in Sig[XYZ]*_*GPa
    do
    
    # If the relaxation is finished, clean the relaxation folder.
    if [ -f $j/fart.txt ]
      then
      rm -v $j/__ABI_MPIABORTFILE__.lock
      rm -v $j/*-[oi]*
      rm -v $j/err
      rm -v $j/slurm-[0-9]*.out
      rm -v $j/log.[0-9]*
      

    fi
    
    # If the DFPT calculation is finished, clean the DFPT folder.
    if [ -f $j/DFPT/PpFin.txt ]
      then

      # If we have the DFPT done, and we have the relaxed
      # positions recorded in abi.GS (and in the abi.in of the
      # DFPT), then we don't need to contain the big relaxation
      # output.
      if [ -f $j/abi.GS ]
        then
	rm -v $j/abi.out
      fi

      rm -v $j/DFPT/__ABI_MPIABORTFILE__.lock
      rm -v $j/DFPT/*-[oi]*
      rm -v $j/DFPT/err
      rm -v $j/DFPT/slurm-[0-9]*.out
      rm -v $j/DFPT/log.[0-9]*
      rm -v $j/DFPT/anaddb.log
    fi

    done

  cd ../

  done
