eps0x=26.69821703
eps0y=22.25199967
eps0z=19.25442559
eps0yz=-0.89988428
eps0xz=4.25665125
eps0xy=-0.93837292

eta0x=0.038864
eta0y=0.045068
eta0z=0.053910
eta0yz=0.001820
eta0xz=-0.008538
eta0xy=0.001296

eps_free=8.85418782e-12

# Fit dielectric constant to stress
f(x)= eps0x*eps_free + 2*x*M11
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressPerm.txt)" using ($2*10**9):($3*eps_free) via M11

f(x)= eps0y*eps_free + 2*x*M21
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressPerm.txt)" using ($2*10**9):($7*eps_free) via M21

f(x)= eps0z*eps_free + 2*x*M31
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressPerm.txt)" using ($2*10**9):($11*eps_free) via M31

f(x)= eps0yz*eps_free + 2*x*M41
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressPerm.txt)" using ($2*10**9):($8*eps_free) via M41

f(x)= eps0xz*eps_free + 2*x*M51
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressPerm.txt)" using ($2*10**9):($5*eps_free) via M51

f(x)= eps0xy*eps_free + 2*x*M61
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressPerm.txt)" using ($2*10**9):($4*eps_free) via M61


# Fit electric rigidity to stress
f(x)= eta0x/eps_free + 2*x*Q11
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressRigid.txt)" using ($2*10**9):($3/eps_free) via Q11

f(x)= eta0y/eps_free + 2*x*Q21
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressRigid.txt)" using ($2*10**9):($7/eps_free) via Q21

f(x)= eta0z/eps_free + 2*x*Q31
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressRigid.txt)" using ($2*10**9):($11/eps_free) via Q31

f(x)= eta0yz/eps_free + 2*x*Q41
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressRigid.txt)" using ($2*10**9):($8/eps_free) via Q41

f(x)= eta0xz/eps_free + 2*x*Q51
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressRigid.txt)" using ($2*10**9):($5/eps_free) via Q51

f(x)= eta0xy/eps_free + 2*x*Q61
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressRigid.txt)" using ($2*10**9):($4/eps_free) via Q61




