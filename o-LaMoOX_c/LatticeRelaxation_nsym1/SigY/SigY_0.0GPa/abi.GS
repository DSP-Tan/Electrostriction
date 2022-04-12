#input for non-centrosymmetric orthorhombic HfO2

ndtset    2

autoparal 1

#Crystal Def.
ntypat   3
natom    26
typat    4*1 4*2 18*3
znucl    57 42 8
acell 3*1

rprim

 
kptopt   1
ngkpt    2 2 2
nshiftk 1
shiftk 
0.5 0.5 0.5
ecut       30
ecutsm  0.5
pawecutdg  30
pawxcdev   0
ixc      -116133
nband    104
diemac   4

# First SCF run       
#irdwfk1   1
nstep1    100
iscf1     7
tolvrs1   1.0E-20

#Refinement using tolwfr
nstep2    250
getwfk2   -1
iscf2     7
tolwfr2   1.0E-20

# Printing flags
prtden    1
prteig    0
prtwf     1
prtposcar 0
prtcif    1
