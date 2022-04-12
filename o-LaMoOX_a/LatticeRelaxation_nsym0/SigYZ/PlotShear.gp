
set terminal epslatex size 4.6, 3.8 standalone color colortext 10 dashlength 2.5


set style line 1 lt 1 lw 3 pt 6 ps 1.5 lc rgb 'black'  # Black, linespoints, solid, open cirlces
set style line 2 lt 1 lw 3 pt 4 ps 1.5 lc rgb 'blue'   # Black, linespoints, dashed, closed cirlces
set style line 3 lt 1 lw 3 pt 7 ps 1.5 lc rgb 'blue'   # Black, linespoints, solid, open circles



set key top left

set ylabel '\scalebox{1.1}{$\epsilon$}' 
set xlabel '\scalebox{1.1}{$X_{32}$~(GPa)}'

set y2tics nomirror tc rgb 'blue'
set y2label '\scalebox{1.0}{$\omega_{yy}$~cm$^{-1}$}' tc rgb 'blue' offset -3.2, 0

set xrange [-1.5:1]
set ytics nomirror
set output 'EpsYPhon.tex'
plot "<(sed -n '/^-1.0/,/^1.0/p' StressPerm.txt)"  using 2:7  w lp pt 7 ps 3.2 lw 3 title '$\epsilon_{yy}$' , \
     "<(sed -n '/^-1.0/,/^1.0/p' StressPerm.txt)"  using 2:3  w lp pt 7 ps 3.2 lw 3 title '$\epsilon_{xx}$' , \
     "<(sed -n '/^-1.0/,/^1.0/p' StressPerm.txt)"  using 2:11 w lp pt 7 ps 3.2 lw 3 title '$\epsilon_{zz}$' , \
     "<(sed -n '/^-1.0/,/^1.0/p' StressPerm.txt)"  using 2:8  w lp pt 7 ps 3.2 lw 3 title '$\epsilon_{yz}$' , \
     "<(sed -n '/^-1.5/,/^1.0/p' PhonAndDielec_Anaddb.txt)"  using 2:5 axes x1y2 w lp pt 4 ps 3.2 lw 3 lc rgb 'blue' title '$\omega_{yy}$',

