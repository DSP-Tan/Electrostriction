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
f(x)= eps0x*eps_free + 2*x*M16
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressPerm.txt)" using ($2*10**9):($3*eps_free) via M16

f(x)= eps0y*eps_free + 2*x*M26
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressPerm.txt)" using ($2*10**9):($7*eps_free) via M26

f(x)= eps0z*eps_free + 2*x*M36
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressPerm.txt)" using ($2*10**9):($11*eps_free) via M36

f(x)= eps0yz*eps_free + 2*x*M46
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressPerm.txt)" using ($2*10**9):($8*eps_free) via M46

f(x)= eps0xz*eps_free + 2*x*M56
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressPerm.txt)" using ($2*10**9):($5*eps_free) via M56

f(x)= eps0xy*eps_free + 2*x*M66
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressPerm.txt)" using ($2*10**9):($4*eps_free) via M66


# Fit electric rigidity to stress
f(x)= eta0x/eps_free + 2*x*Q16
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressRigid.txt)" using ($2*10**9):($3/eps_free) via Q16

f(x)= eta0y/eps_free + 2*x*Q26
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressRigid.txt)" using ($2*10**9):($7/eps_free) via Q26

f(x)= eta0z/eps_free + 2*x*Q36
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressRigid.txt)" using ($2*10**9):($11/eps_free) via Q36

f(x)= eta0yz/eps_free + 2*x*Q46
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressRigid.txt)" using ($2*10**9):($8/eps_free) via Q46

f(x)= eta0xz/eps_free + 2*x*Q56
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressRigid.txt)" using ($2*10**9):($5/eps_free) via Q56

f(x)= eta0xy/eps_free + 2*x*Q66
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressRigid.txt)" using ($2*10**9):($4/eps_free) via Q66




