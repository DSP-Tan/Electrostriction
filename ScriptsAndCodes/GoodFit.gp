eps0x=27.38318886
eps0y=57.64323276
eps0z=19.67412371
eps0yz=13.50923491
eps0xz=0.03746694
eps0xy=0.23126061

eta0x=0.036520
eta0y=0.020676
eta0z=0.060578
eta0yz=-0.014198
eta0xz=0.000031
eta0xy=-0.000153

eps_free=8.85418782e-12

# Fit dielectric constant to stress
f(x)= eps0x*eps_free + 2*x*M1XXXX
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressPerm.txt)" using ($2*10**9):($3*eps_free) via M1XXXX

f(x)= eps0y*eps_free + 2*x*M2XXXX
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressPerm.txt)" using ($2*10**9):($7*eps_free) via M2XXXX

f(x)= eps0z*eps_free + 2*x*M3XXXX
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressPerm.txt)" using ($2*10**9):($11*eps_free) via M3XXXX

f(x)= eps0yz*eps_free + 2*x*M4XXXX
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressPerm.txt)" using ($2*10**9):($8*eps_free) via M4XXXX

f(x)= eps0xz*eps_free + 2*x*M5XXXX
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressPerm.txt)" using ($2*10**9):($5*eps_free) via M5XXXX

f(x)= eps0xy*eps_free + 2*x*M6XXXX
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressPerm.txt)" using ($2*10**9):($4*eps_free) via M6XXXX


# Fit electric rigidity to stress
f(x)= eta0x/eps_free + 2*x*Q1XXXX
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressRigid.txt)" using ($2*10**9):($3/eps_free) via Q1XXXX

f(x)= eta0y/eps_free + 2*x*Q2XXXX
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressRigid.txt)" using ($2*10**9):($7/eps_free) via Q2XXXX

f(x)= eta0z/eps_free + 2*x*Q3XXXX
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressRigid.txt)" using ($2*10**9):($11/eps_free) via Q3XXXX

f(x)= eta0yz/eps_free + 2*x*Q4XXXX
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressRigid.txt)" using ($2*10**9):($8/eps_free) via Q4XXXX

f(x)= eta0xz/eps_free + 2*x*Q5XXXX
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressRigid.txt)" using ($2*10**9):($5/eps_free) via Q5XXXX

f(x)= eta0xy/eps_free + 2*x*Q6XXXX
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressRigid.txt)" using ($2*10**9):($4/eps_free) via Q6XXXX




