#!/bin/bash -l

echo "starting solvent relaxation"
echo "starting 1min"

$1/amber22/bin/pmemd -O -i Relaxation/1min.in -o Relaxation/1min.out -p TXS-vert8.prmtop -c TXS-vert8.inpcrd -r Relaxation/1min.rst7 -inf Relaxation/1min.info -ref TXS-vert8.inpcrd -x Relaxation/mdcrd.1min

echo "ending 1min"

echo "starting 2mdheat"

$1/amber22/bin/pmemd -O -i Relaxation/2mdheat.in -o Relaxation/2mdheat.out -p TXS-vert8.prmtop -c Relaxation/1min.rst7 -r Relaxation/2mdheat.rst7 -inf Relaxation/2mdheat.info -ref Relaxation/1min.rst7 -x Relaxation/mdcrd.2mdheat
echo "ending 2mdheat"

echo "starting 3md"

$1/amber22/bin/pmemd -O -i Relaxation/3md.in\
            -o Relaxation/3md.out -p TXS-vert8.prmtop -c Relaxation/2mdheat.rst7 -r Relaxation/3md.rst7\
            -inf Relaxation/3md.info -ref Relaxation/2mdheat.rst7 -x Relaxation/mdcrd.3md
echo "ending 3md"

echo "starting 4md'"

$1/amber22/bin/pmemd -O -i Relaxation/4md.in\
            -o Relaxation/4md.out -p TXS-vert8.prmtop -c Relaxation/3md.rst7 -r Relaxation/4md.rst7\
            -inf Relaxation/4md.info -ref Relaxation/3md.rst7 -x Relaxation/mdcrd.4md
echo "ending 4md"
echo "ending solvent relaxation"

echo "starting sidechain relaxation"
echo "starting 5min"

$1/amber22/bin/pmemd -O -i Relaxation/5min.in\
            -o Relaxation/5min.out -p TXS-vert8.prmtop -c Relaxation/4md.rst7 -r Relaxation/5min.rst7\
            -inf Relaxation/5min.info -ref Relaxation/4md.rst7 -x Relaxation/mdcrd.5min
echo "ending 5min"

echo "starting 6md"

$1/amber22/bin/pmemd -O -i Relaxation/6md.in\
            -o Relaxation/6md.out -p TXS-vert8.prmtop -c Relaxation/5min.rst7 -r Relaxation/6md.rst7\
            -inf Relaxation/6md.info -ref Relaxation/5min.rst7 -x Relaxation/mdcrd.6md
echo "ending 6md"

echo "starting 7md"

$1/amber22/bin/pmemd -O -i Relaxation/7md.in\
            -o Relaxation/7md.out -p TXS-vert8.prmtop -c Relaxation/6md.rst7 -r Relaxation/7md.rst7\
            -inf Relaxation/7md.info -ref Relaxation/6md.rst7 -x Relaxation/mdcrd.7md
echo "ending 7md"
echo "ending sidechain relaxation"

echo "starting unrestrained relaxation"
echo "starting 9md"

$1/amber22/bin/pmemd -O -i Relaxation/9md.in\
            -o Relaxation/9md.out -p TXS-vert8.prmtop -c Relaxation/7md.rst7 -r Relaxation/TXS-vert8_relaxed.rst7\
            -inf Relaxation/9md.info -ref Relaxation/7md.rst7 -x Relaxation/mdcrd.9md
echo "ending 9md"
echo "Finished system relaxation"

$1/amber22/bin/cpptraj Relaxation/to_pdb.in > Relaxation/cpptraj.out &
