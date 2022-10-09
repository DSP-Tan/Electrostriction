sed -i '1,/paw_pbe_standard\/O\.xml/d' abi.out  # Delete all variable echoing up to first data set.

sed -i '1,/abi-o_DS1_WFK/d' abi.out # delete to start of dfpt

sed -i '/Total pseudopotential strength Dij (hartree):/,/prteigrs : prtvol=0 or 1, do not print more k-points./d' abi.out

# in vim:
:g/ ETOT/d

# This is good becase it leaves the first ETOT
