eps0x=27.33846491
eps0y=56.69158966
eps0z=19.57313071
eps0yz=13.23244077
eps0xz=0.00000000
eps0xy=0.00000000

eta0x=0.036578
eta0y=0.020943
eta0z=0.060659
eta0yz=-0.014156
eta0xz=-0.000000
eta0xy=0.000000

eps_free=8.85418782e-12

# Fit dielectric constant to stress
f(x)= eps0x*eps_free + 2*x*M13
fit f(x) "<(sed -n '/^-1\.0/,/^1\.0/p' StressPerm.txt)" using ($2*10**9):($3*eps_free) via M13

f(x)= eps0y*eps_free + 2*x*M23
fit f(x) "<(sed -n '/^-1\.0/,/^1\.0/p' StressPerm.txt)" using ($2*10**9):($7*eps_free) via M23

f(x)= eps0z*eps_free + 2*x*M33
fit f(x) "<(sed -n '/^-1\.0/,/^1\.0/p' StressPerm.txt)" using ($2*10**9):($11*eps_free) via M33

f(x)= eps0yz*eps_free + 2*x*M43
fit f(x) "<(sed -n '/^-1\.0/,/^1\.0/p' StressPerm.txt)" using ($2*10**9):($8*eps_free) via M43

f(x)= eps0xz*eps_free + 2*x*M53
#fit f(x) "<(sed -n '/^-1\.0/,/^1\.0/p' StressPerm.txt)" using ($2*10**9):($5*eps_free) via M53

f(x)= eps0xy*eps_free + 2*x*M63
#fit f(x) "<(sed -n '/^-1\.0/,/^1\.0/p' StressPerm.txt)" using ($2*10**9):($4*eps_free) via M63


# Fit electric rigidity to stress
f(x)= eta0x/eps_free + 2*x*Q13
fit f(x) "<(sed -n '/^-1\.0/,/^1\.0/p' StressRigid.txt)" using ($2*10**9):($3/eps_free) via Q13

f(x)= eta0y/eps_free + 2*x*Q23
fit f(x) "<(sed -n '/^-1\.0/,/^1\.0/p' StressRigid.txt)" using ($2*10**9):($7/eps_free) via Q23

f(x)= eta0z/eps_free + 2*x*Q33
fit f(x) "<(sed -n '/^-1\.0/,/^1\.0/p' StressRigid.txt)" using ($2*10**9):($11/eps_free) via Q33

f(x)= eta0yz/eps_free + 2*x*Q43
fit f(x) "<(sed -n '/^-1\.0/,/^1\.0/p' StressRigid.txt)" using ($2*10**9):($8/eps_free) via Q43

f(x)= eta0xz/eps_free + 2*x*Q53
#fit f(x) "<(sed -n '/^-1\.0/,/^1\.0/p' StressRigid.txt)" using ($2*10**9):($5/eps_free) via Q53

f(x)= eta0xy/eps_free + 2*x*Q63
#fit f(x) "<(sed -n '/^-1\.0/,/^1\.0/p' StressRigid.txt)" using ($2*10**9):($4/eps_free) via Q63




