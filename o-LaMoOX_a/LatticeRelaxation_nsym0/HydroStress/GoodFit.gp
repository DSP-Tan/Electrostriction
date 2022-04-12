eps0x=27.08427541
eps0y=53.21428755
eps0z=19.36946162
eps0yz=13.23244077
eps0xz=0.00000000
eps0xy=0.00000000

eps_free=8.85418782e-12

# Fit dielectric constant to stress
f(x)= eps0x*eps_free + 2*x*M1h
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressPerm.txt)" using ($2*10**9):($3*eps_free) via M1h

f(x)= eps0y*eps_free + 2*x*M2h
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressPerm.txt)" using ($2*10**9):($7*eps_free) via M2h

f(x)= eps0z*eps_free + 2*x*M3h
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressPerm.txt)" using ($2*10**9):($11*eps_free) via M3h

f(x)= eps0yz*eps_free + 2*x*M4h
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressPerm.txt)" using ($2*10**9):($8*eps_free) via M4h

#f(x)= eps0xz*eps_free + 2*x*M51
#fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressPerm.txt)" using ($2*10**9):($5*eps_free) via M51

#f(x)= eps0xy*eps_free + 2*x*M61
#fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressPerm.txt)" using ($2*10**9):($4*eps_free) via M61

