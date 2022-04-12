awk -v eps0=8.854187822e-12 -v epsZ2=56.69158966 -v epsZ1=71.70101282 -v sig2=6.5*10^-7e9 -v sig1=-0.49999e9 'BEGIN {print 0.5/eps0*(1/epsZ2-1/epsZ1)/(sig2-sig1)}'

awk -v eps0=8.854187822e-12 -v epsZ2=56.69158966 -v epsZ1=71.70101282 -v sig2=6.5*10^-7e9 -v sig1=-0.49999e9 'BEGIN {print 0.5*eps0*(epsZ2-epsZ1)/(sig2-sig1)}'
