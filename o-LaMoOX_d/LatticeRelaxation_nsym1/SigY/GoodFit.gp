eps0x=54.27256689
eps0y=19.30963618
eps0z=27.28993087
eps0yz=0.09402647
eps0xz=-0.21345752
eps0xy=-12.52423524

eta0x=0.021667
eta0y=0.060896
eta0z=0.036645
eta0yz=-0.000093
eta0xz=0.000120
eta0xy=0.014048

eps_free=8.85418782e-12

# Fit dielectric constant to stress
f(x)= eps0x*eps_free + 2*x*M12
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressPerm.txt)" using ($2*10**9):($3*eps_free) via M12

f(x)= eps0y*eps_free + 2*x*M22
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressPerm.txt)" using ($2*10**9):($7*eps_free) via M22

f(x)= eps0z*eps_free + 2*x*M32
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressPerm.txt)" using ($2*10**9):($11*eps_free) via M32

f(x)= eps0yz*eps_free + 2*x*M42
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressPerm.txt)" using ($2*10**9):($8*eps_free) via M42

f(x)= eps0xz*eps_free + 2*x*M52
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressPerm.txt)" using ($2*10**9):($5*eps_free) via M52

f(x)= eps0xy*eps_free + 2*x*M62
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressPerm.txt)" using ($2*10**9):($4*eps_free) via M62


# Fit electric rigidity to stress
f(x)= eta0x/eps_free + 2*x*Q12
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressRigid.txt)" using ($2*10**9):($3/eps_free) via Q12

f(x)= eta0y/eps_free + 2*x*Q22
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressRigid.txt)" using ($2*10**9):($7/eps_free) via Q22

f(x)= eta0z/eps_free + 2*x*Q32
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressRigid.txt)" using ($2*10**9):($11/eps_free) via Q32

f(x)= eta0yz/eps_free + 2*x*Q42
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressRigid.txt)" using ($2*10**9):($8/eps_free) via Q42

f(x)= eta0xz/eps_free + 2*x*Q52
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressRigid.txt)" using ($2*10**9):($5/eps_free) via Q52

f(x)= eta0xy/eps_free + 2*x*Q62
fit f(x) "<(sed -n '/^-0\.5/,/^0\.5/p' StressRigid.txt)" using ($2*10**9):($4/eps_free) via Q62




