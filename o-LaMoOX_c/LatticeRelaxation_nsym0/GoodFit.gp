eps01=26.59730458
eta=0.0375978
eps_free=8.85418782e-12

# Fit dielectric constant to stress
f(x)= eps01*eps_free + 2*x*Mh
fit f(x) "<(sed -n '/^-0\.001/,/^0\.001/p' PhonAndDielec_Anaddb.txt)" using ($2*10**9):($8*eps_free) via Mh
#fit f(x) "<(sed -n '/^-0\.003/,/^0\.003/p' PhonAndDielec_Anaddb.txt)" using ($2*10**9):($8*eps_free) via Mh
#fit f(x) "<(sed -n '/^-0\.005/,/^0\.005/p' PhonAndDielec_Anaddb.txt)" using ($2*10**9):($8*eps_free) via Mh
#fit f(x) "<(sed -n '/-0\.010/,/^0\.010/p' PhonAndDielec_Anaddb.txt)" using ($2*10**9):($8*eps_free) via Mh

f(x)= eps01*eps_free + 2*x*mh
fit f(x) "<(sed -n '/^-0\.001/,/^0\.001/p' PhonAndDielec_Anaddb.txt)" using 1:($8*eps_free) via mh
#fit f(x) "<(sed -n '/^-0\.003/,/^0\.003/p' PhonAndDielec_Anaddb.txt)" using 1:($8*eps_free) via mh
#fit f(x) "<(sed -n '/^-0\.005/,/^0\.005/p' PhonAndDielec_Anaddb.txt)" using 1:($8*eps_free) via mh
#fit f(x) "<(sed -n '/^-0\.010/,/^0\.010/p' PhonAndDielec_Anaddb.txt)" using 1:($8*eps_free) via mh

g(x)= eta/eps_free - 2*x*Qh
fit g(x) "<(sed -n '/^-0\.001/,/^0\.001/p' PhonAndDielec_Anaddb.txt)" using ($2*10**9):(1 / ($8*eps_free) ) via Qh
#fit g(x) "<(sed -n '/^-0\.003/,/^0\.003/p' PhonAndDielec_Anaddb.txt)" using ($2*10**9):(1 / ($8*eps_free) ) via Qh
#fit g(x) "<(sed -n '/^-0\.005/,/^0\.005/p' PhonAndDielec_Anaddb.txt)" using ($2*10**9):(1 / ($8*eps_free) ) via Qh
#fit g(x) "<(sed -n '/^-0\.010/,/^0\.010/p' PhonAndDielec_Anaddb.txt)" using ($2*10**9):(1 / ($8*eps_free) ) via Qh

g(x)= eta/eps_free - 2*x*qh
fit g(x) "<(sed -n '/^-0\.001/,/^0\.001/p' PhonAndDielec_Anaddb.txt)" using 1:(1 / ($8*eps_free) ) via qh
#fit g(x) "<(sed -n '/^-0\.003/,/^0\.003/p' PhonAndDielec_Anaddb.txt)" using 1:(1 / ($8*eps_free) ) via qh
#fit g(x) "<(sed -n '/^-0\.005/,/^0\.005/p' PhonAndDielec_Anaddb.txt)" using 1:(1 / ($8*eps_free) ) via qh
#fit g(x) "<(sed -n '/^-0\.010/,/^0\.010/p' PhonAndDielec_Anaddb.txt)" using 1:(1 / ($8*eps_free) ) via qh

