#!/bin/bash
# Submission script for nic5
#SBATCH --job-name=SigYZ0.5
#SBATCH --time=06:00:00
#SBATCH --ntasks=60
#SBATCH --mem-per-cpu=774
#SBATCH --partition=batch
#SBATCH --mail-user=danielsptanner@gmail.com

# Infos
echo " -------- Abinit job -------- "
echo ""
echo "### Info"
echo " Job ID                              = $SLURM_JOB_ID"
echo " Directory job was submitted from    = $SLURM_SUBMIT_DIR"
echo " File containing allocated hostnames = $SLURM_JOB_NODELIST"
echo " Hostname job was submitted from     = $SLURM_SUBMIT_HOST"
echo ""

# Modules


module load releases/2020b
module load imkl/2020.4.304-iimpi-2020b
module load Python/3.8.6-GCCcore-10.2.0 
module load netCDF-Fortran/4.5.3-iimpi-2020b iimpi/2020b
module load HDF5/1.10.7-iimpi-2020b 
module load libxc/4.3.4-iccifort-2020.4.304


EXE=/CECI/proj/phythema/abinit/9.4.0/bin/abinit
echo " exe = $EXE"
MPIRUN="mpirun"
echo " mpirun = $MPIRUN"
LOG="log.${SLURM_JOB_ID}"

if [ -f fart.txt ]
   then
   rm fart.txt
fi

$MPIRUN $EXE <abi.files > $LOG 2> err && echo "fart" > fart.txt

echo ""
echo " ----------- End ----------- "
