# Electrostriction
This repository contains the bash scripts, C codes, ABINIT input files, and gnuplot plotting scripts that were used to investigate the electrostrictive properties of different materials.

## Calculational procedure
### Preprocessing, DFT, and DFPT calculations.
- Create directory named after structure, including .cif file and other information
- Create a directory for the LatticeRelaxation. This describes the type of relaxation we will do before calculating the 
  electrostrictive properties. For example, in o-LaMoOX_a, we have calculated electrostriction for the case where we only relax
  the internal coordinates, and where we do full relaxations. There are also relaxations with nsym either equal to 1
  or to 0. Nsym=0 preserves the crystal symmetry, and tends to give cleaner relaxations, whilst nsym1 allows us to be certain
  we are not missing any phase transitions/etc. and are getting a true groundstate.
- Relax the ground state structure (possibly after taking positions/lattice from .cif file)
- Now calculate the groundstate dielectric,electronic,elastic,etc. properties. In this repository, these calculations are
  done in the DFPT folder. 
    -  This may be achieved automatically using: 
           ```
           ./MakeGS.sh abi.in abi.out
           ``` 
       which will make a file
       called abi.GS, which will be an abinit input read to calculate GS wavefunctions or which can be modified to calculate band
       structures or whatever you want. When abi.GS is made, you may delete the large abi.out file, which contains all the steps of
       the relaxation, as we do not need this anymore with the relaxed coordinates contained in abi.GS
    -  With abi.GS in the folder, you may execute: ```./MakeDFPT.sh```. This will create a DFPT folder, and also the input files needed
       to run a DFPT calculation. You may then, in the DFPT folder, submit the job for calculation,  using the created abi.in.

- With the groundstate, and groundstate properties obtained, we can now apply the relevant stresses/strains to calculate the electrostrictive
  tensors (M and Q for stress, m and q for strains). We begin describing only the stress method, since for the LaMoX repository we are in,
  this is all there is. The strain calculations may be found in other repositories.
    - Create the stress branch directories: "mkdir SigX, SigY, SigZ, SigYZ, SigXZ, SigXY"
    - To calculate the change in permitivity for a given stress, cd into that stress directory.
    - Then you will use the abi.in which has eg. "strtarget XXXX 5*0". You will use Sig.sh which will change this XXXX to a given stress value
      and create directories like SigX_0.5GPa, SigX_-0.5GPa, with strtarget being the atomic unit equivalent of 0.5GPa and -0.5GPa in each one.
    - You then relax the cells in these directories till the stress tensor has the specified values.
    - When they are finished you can run Sig_DFPT.sh, which itself runs MakeGS.sh and MakeDFPT.sh, and this will create and run the DFPT calculations.
    - When these calculations are done you have the permitivity as a funciton of changing x stress.
    - Repeat this for every stress branch.

### Postprocessing, data extraction and gathering
- First check that all the calculations are finished. In the directory where you relaxed the structure, containing the GS DFPT calculation folder, 
  as well as all the stress branch folders (e.g. Electrostriction/o-LaMoOX_a/LatticeRelaxation_nsym1), use the following for loop in conjunction with "Check.sh":
 

```bash   
    #or: for i in Sig[XYZ]*
    for i in SigX, SigY, SigZ, SigYZ, SigXZ, SigXY  
        do
        echo $i
        cd $i
        ../../../ScriptsAndCodes/Check.sh
        cd ../
        done
```

- If they are all finished, you can run PostPlotEtc.sh, and this will use ExtractFitStressPermRigid.sh, to extract the permitivities as 
  a function of stress, calculate the rigidities (using gslinv.c) by inverting these permitivity matrices, and it will then do all the
  fittings to obtain every component of Mijkl and Qijkl.



