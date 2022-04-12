#!/bin/bash

M11=$( grep +/- SigX/fit.log | grep M11 | awk '{print $3*10^21}')
M21=$( grep +/- SigX/fit.log | grep M21 | awk '{print $3*10^21}')
M31=$( grep +/- SigX/fit.log | grep M31 | awk '{print $3*10^21}')
M41=$( grep +/- SigX/fit.log | grep M41 | awk '{print $3*10^21}')
M51=$( grep +/- SigX/fit.log | grep M51 | awk '{print 0.0}')
M61=$( grep +/- SigX/fit.log | grep M61 | awk '{print 0.0}')

M12=$( grep +/- SigY/fit.log | grep M12 | awk '{print $3*10^21}')
M22=$( grep +/- SigY/fit.log | grep M22 | awk '{print $3*10^21}')
M32=$( grep +/- SigY/fit.log | grep M32 | awk '{print $3*10^21}')
M42=$( grep +/- SigY/fit.log | grep M42 | awk '{print $3*10^21}')
M52=$( grep +/- SigY/fit.log | grep M52 | awk '{print 0.0}')
M62=$( grep +/- SigY/fit.log | grep M62 | awk '{print 0.0}')

M13=$( grep +/- SigZ/fit.log | grep M13 | awk '{print $3*10^21}')
M23=$( grep +/- SigZ/fit.log | grep M23 | awk '{print $3*10^21}')
M33=$( grep +/- SigZ/fit.log | grep M33 | awk '{print $3*10^21}')
M43=$( grep +/- SigZ/fit.log | grep M43 | awk '{print $3*10^21}')
M53=$( grep +/- SigZ/fit.log | grep M53 | awk '{print 0.0}')
M63=$( grep +/- SigZ/fit.log | grep M63 | awk '{print 0.0}')

M14=$(grep +/- SigYZ/fit.log | grep M14 | awk '{print $3*10^21}')
M24=$(grep +/- SigYZ/fit.log | grep M24 | awk '{print $3*10^21}')
M34=$(grep +/- SigYZ/fit.log | grep M34 | awk '{print $3*10^21}')
M44=$(grep +/- SigYZ/fit.log | grep M44 | awk '{print $3*10^21}')
M54=$(grep +/- SigYZ/fit.log | grep M54 | awk '{print 0.0}')
M64=$(grep +/- SigYZ/fit.log | grep M64 | awk '{print 0.0}')

printf "%7.2f %7.2f %7.2f %7.2f %7.2f %7.2f\n" "$M11" "$M12" "$M13" "$M14" "$M15" "$M16"
printf "%7.2f %7.2f %7.2f %7.2f %7.2f %7.2f\n" "$M21" "$M22" "$M23" "$M24" "$M25" "$M26"
printf "%7.2f %7.2f %7.2f %7.2f %7.2f %7.2f\n" "$M31" "$M32" "$M33" "$M34" "$M35" "$M36"
printf "%7.2f %7.2f %7.2f %7.2f %7.2f %7.2f\n" "$M41" "$M42" "$M43" "$M44" "$M45" "$M46"
printf "%7.2f %7.2f %7.2f %7.2f %7.2f %7.2f\n" "$M51" "$M52" "$M53" "$M54" "0" "0"
printf "%7.2f %7.2f %7.2f %7.2f %7.2f %7.2f\n" "$M61" "$M62" "$M63" "$M64" "0" "0"
