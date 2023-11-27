#!/bin/bash

source $1/amber22/amber.sh

parmchk2 -i ligand_files/PPO.mol2 -f mol2 -o ligand_files/PPO.frcmod
parmchk2 -i ligand_files/VRT.mol2 -f mol2 -o ligand_files/VRT.frcmod

cd Prep_environment
$1/amber22/bin/tleap -f PPO.in
$1/amber22/bin/tleap -f VRT.in
$1/amber22/bin/tleap -f complex.in
cd ..

ambpdb -p TXS-vert8.prmtop -c TXS-vert8.inpcrd > TXS-vert8_solvated.pdb
