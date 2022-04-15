# Electrostriction
This repository contains the bash scripts, C codes, ABINIT input files, and gnuplot plotting scripts that were used to investigate the electrostrictive properties of different materials.

Procedure to calculate tensors for a particular structure.
- Create directory named after structure, including .cif file and other information
- Create a directory for the LatticeRelaxation. This describes the type of relaxation we will do before calculating the 
  electrostrictive properties. For example, in o-LaMoOX_a, we have calculated electrostriction for the case where we only relax
  the internal coordinates, and where we do full relaxations. There are also relaxations with nsym either equal to 1
  or to 0. Nsym=0 preserves the crystal symmetry, and tends to give cleaner relaxations, whilst nsym1 allows us to be certain
  we are not missing any phase transitions/etc. and are getting a true groundstate.
- Relax the ground state structure (possibly after taking positions/lattice from .cif file)
- Now calculate the groundstate dielectric,electronic,elastic,etc. properties. In this repository, these calculations are
  done in the DFPT folder. 
- -  This may be achieved automatically using: "./MakeGS.sh abi.in abi.out", which will make a file
     called abi.GS, which will be an abinit input read to calculate GS wavefunctions or which can be modified to calculate band
     structures or whatever you want. When abi.GS is made, you may delete the large abi.out file, which contains all the steps of
     the relaxation, as we do not need this anymore with the relaxed coordinates contained in abi.GS
- -  With abi.GS in the folder, you may execute: "./MakeDFPT.sh". This will create a DFPT folder, and also the input files needed
     to run a DFPT calculation. You may then, in the DFPT folder, submit the job for calculation,  using the created abi.in.
-

