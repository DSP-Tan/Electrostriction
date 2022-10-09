eps0x=56.39313012
eps0y=19.55581381
eps0z=27.46626045
eps0yz=0.15311867
eps0xz=0.59955568
eps0xy=13.16201066

eta0x=0.021040
eta0y=0.060662
eta0z=0.036417
eta0yz=-0.000022
eta0xz=-0.000382
eta0xy=-0.014156

eps_free=8.85418782e-12

# Fit dielectric constant to stress
f(x)= eps0x*eps_free + 2*x*M14
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressPerm.txt)" using ($2*10**9):($3*eps_free) via M14

f(x)= eps0y*eps_free + 2*x*M24
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressPerm.txt)" using ($2*10**9):($7*eps_free) via M24

f(x)= eps0z*eps_free + 2*x*M34
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressPerm.txt)" using ($2*10**9):($11*eps_free) via M34

f(x)= eps0yz*eps_free + 2*x*M44
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressPerm.txt)" using ($2*10**9):($8*eps_free) via M44

f(x)= eps0xz*eps_free + 2*x*M54
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressPerm.txt)" using ($2*10**9):($5*eps_free) via M54

f(x)= eps0xy*eps_free + 2*x*M64
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressPerm.txt)" using ($2*10**9):($4*eps_free) via M64


# Fit electric rigidity to stress
f(x)= eta0x/eps_free + 2*x*Q14
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressRigid.txt)" using ($2*10**9):($3/eps_free) via Q14

f(x)= eta0y/eps_free + 2*x*Q24
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressRigid.txt)" using ($2*10**9):($7/eps_free) via Q24

f(x)= eta0z/eps_free + 2*x*Q34
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressRigid.txt)" using ($2*10**9):($11/eps_free) via Q34

f(x)= eta0yz/eps_free + 2*x*Q44
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressRigid.txt)" using ($2*10**9):($8/eps_free) via Q44

f(x)= eta0xz/eps_free + 2*x*Q54
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressRigid.txt)" using ($2*10**9):($5/eps_free) via Q54

f(x)= eta0xy/eps_free + 2*x*Q64
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressRigid.txt)" using ($2*10**9):($4/eps_free) via Q64




