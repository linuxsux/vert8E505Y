#!/bin/bash
#SBATCH --ntasks=8 
#SBATCH --cpus-per-task=1 
#SBATCH --gpus-per-task=1
#SBATCH --mem-per-cpu=4000 
#SBATCH --time=30:00:00

module purge
module load StdEnv/2020 gcc/9.3.0 cuda/11.4 openmpi/4.0.3 ambertools/21

source $EBROOTAMBERTOOLS/amber.sh

srun sander.quick.cuda.MPI -O -i QM_MM/qmmm.in -o QM_MM/qmmm.out -p TXS-vert8.prmtop -c Relaxation/TXS-vert8_relaxed.rst7 -r QM_MM/TXS-vert8_qmmm.rst7 -x QM_MM/TXS-vert8_qmmm.mdcrd

cpptraj -i QM_MM/to_pdb.in
