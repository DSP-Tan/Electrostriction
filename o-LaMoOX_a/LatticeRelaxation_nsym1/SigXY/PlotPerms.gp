set terminal epslatex size 4.6, 3.8 standalone color colortext 10 dashlength 2.5

set ylabel '$\epsilon$'
set xlabel '$\sigma_{6}$~(GPa)'

set output "PermStress.tex"
plot "StressPerm.txt"  using 2:3  w lp ps 1.2 lw 3 title '$\epsilon_{x}$' , \
     "StressPerm.txt"  using 2:4  w lp ps 1.2 lw 3 title '$\epsilon_{xy}$' , \
     "StressPerm.txt"  using 2:5  w lp ps 1.2 lw 3 title '$\epsilon_{xz}$' , \
     "StressPerm.txt"  using 2:7  w lp ps 1.2 lw 3 title '$\epsilon_{y}$' , \
     "StressPerm.txt"  using 2:8  w lp ps 1.2 lw 3 title '$\epsilon_{yz}$' , \
     "StressPerm.txt"  using 2:11 w lp ps 1.2 lw 3 title '$\epsilon_{z}$' , \
     
