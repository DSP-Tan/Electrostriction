#!/bin/bash



########################################################################
#####################   SigX         ###################################
########################################################################

M11=$( grep  '^M11' SigX/HalfGPaFit.log  | awk '{print $3*10^21}')
M21=$( grep  '^M21' SigX/HalfGPaFit.log  | awk '{print $3*10^21}')
M31=$( grep  '^M31' SigX/HalfGPaFit.log  | awk '{print $3*10^21}')
M41=$( grep  '^M41' SigX/HalfGPaFit.log  | awk '{print $3*10^21}')
M51=$( grep  '^M51' SigX/HalfGPaFit.log  | awk '{print $3*10^21}')
M61=$( grep  '^M61' SigX/HalfGPaFit.log  | awk '{print $3*10^21}')


M11_err=$( grep  '^M11' SigX/HalfGPaFit.log | awk -F "[()%]" '{print $2}' )
M21_err=$( grep  '^M21' SigX/HalfGPaFit.log | awk -F "[()%]" '{print $2}' )
M31_err=$( grep  '^M31' SigX/HalfGPaFit.log | awk -F "[()%]" '{print $2}' )
M41_err=$( grep  '^M41' SigX/HalfGPaFit.log | awk -F "[()%]" '{print $2}' )
M51_err=$( grep  '^M51' SigX/HalfGPaFit.log | awk -F "[()%]" '{print $2}' )
M61_err=$( grep  '^M61' SigX/HalfGPaFit.log | awk -F "[()%]" '{print $2}' )

########################################################################
#####################   SigY         ###################################
########################################################################



M12=$( grep ^M12 SigY/HalfGPaFit.log  | awk '{print $3*10^21}')
M22=$( grep ^M22 SigY/HalfGPaFit.log  | awk '{print $3*10^21}')
M32=$( grep ^M32 SigY/HalfGPaFit.log  | awk '{print $3*10^21}')
M42=$( grep ^M42 SigY/HalfGPaFit.log  | awk '{print $3*10^21}')
M52=$( grep ^M52 SigY/HalfGPaFit.log  | awk '{print $3*10^21}')
M62=$( grep ^M62 SigY/HalfGPaFit.log  | awk '{print $3*10^21}')

M12_err=$( grep ^M12 SigY/HalfGPaFit.log  | awk -F "[()%]" '{print $2}')
M22_err=$( grep ^M22 SigY/HalfGPaFit.log  | awk -F "[()%]" '{print $2}')
M32_err=$( grep ^M32 SigY/HalfGPaFit.log  | awk -F "[()%]" '{print $2}')
M42_err=$( grep ^M42 SigY/HalfGPaFit.log  | awk -F "[()%]" '{print $2}')
M52_err=$( grep ^M52 SigY/HalfGPaFit.log  | awk -F "[()%]" '{print $2}')
M62_err=$( grep ^M62 SigY/HalfGPaFit.log  | awk -F "[()%]" '{print $2}')

########################################################################
#####################   SigZ         ###################################
########################################################################


M13=$( grep +/- SigZ/HalfGPaFit.log | grep M13 | awk '{print $3*10^21}')
M23=$( grep +/- SigZ/HalfGPaFit.log | grep M23 | awk '{print $3*10^21}')
M33=$( grep +/- SigZ/HalfGPaFit.log | grep M33 | awk '{print $3*10^21}')
M43=$( grep +/- SigZ/HalfGPaFit.log | grep M43 | awk '{print $3*10^21}')
M53=$( grep +/- SigZ/HalfGPaFit.log | grep M53 | awk '{print $3*10^21}')
M63=$( grep +/- SigZ/HalfGPaFit.log | grep M63 | awk '{print $3*10^21}')

M13_err=$( grep M13 SigZ/HalfGPaFit.log  | awk -F "[()%]" '{print $2}')
M23_err=$( grep M23 SigZ/HalfGPaFit.log  | awk -F "[()%]" '{print $2}')
M33_err=$( grep M33 SigZ/HalfGPaFit.log  | awk -F "[()%]" '{print $2}')
M43_err=$( grep M43 SigZ/HalfGPaFit.log  | awk -F "[()%]" '{print $2}')
M53_err=$( grep M53 SigZ/HalfGPaFit.log  | awk -F "[()%]" '{print $2}')
M63_err=$( grep M63 SigZ/HalfGPaFit.log  | awk -F "[()%]" '{print $2}')


########################################################################
#####################   SigYZ         ##################################
########################################################################

M14=$(grep +/- SigYZ/HalfGPaFit.log | grep M14 | awk '{print $3*10^21}')
M24=$(grep +/- SigYZ/HalfGPaFit.log | grep M24 | awk '{print $3*10^21}')
M34=$(grep +/- SigYZ/HalfGPaFit.log | grep M34 | awk '{print $3*10^21}')
M44=$(grep +/- SigYZ/HalfGPaFit.log | grep M44 | awk '{print $3*10^21}')
M54=$(grep +/- SigYZ/HalfGPaFit.log | grep M54 | awk '{print $3*10^21}')
M64=$(grep +/- SigYZ/HalfGPaFit.log | grep M64 | awk '{print $3*10^21}')

M14_err=$(grep M14 SigYZ/HalfGPaFit.log  | awk -F "[()%]" '{print $2}')
M24_err=$(grep M24 SigYZ/HalfGPaFit.log  | awk -F "[()%]" '{print $2}')
M34_err=$(grep M34 SigYZ/HalfGPaFit.log  | awk -F "[()%]" '{print $2}')
M44_err=$(grep M44 SigYZ/HalfGPaFit.log  | awk -F "[()%]" '{print $2}')
M54_err=$(grep M54 SigYZ/HalfGPaFit.log  | awk -F "[()%]" '{print $2}')
M64_err=$(grep M64 SigYZ/HalfGPaFit.log  | awk -F "[()%]" '{print $2}')

########################################################################
#####################   SigXZ         ##################################
########################################################################

M15=$(grep +/- SigXZ/HalfGPaFit.log | grep M15 | awk '{print $3*10^21}')
M25=$(grep +/- SigXZ/HalfGPaFit.log | grep M25 | awk '{print $3*10^21}')
M35=$(grep +/- SigXZ/HalfGPaFit.log | grep M35 | awk '{print $3*10^21}')
M45=$(grep +/- SigXZ/HalfGPaFit.log | grep M45 | awk '{print $3*10^21}')
M55=$(grep +/- SigXZ/HalfGPaFit.log | grep M55 | awk '{print $3*10^21}')
M65=$(grep +/- SigXZ/HalfGPaFit.log | grep M65 | awk '{print $3*10^21}')

M15_err=$(grep +/- SigXZ/HalfGPaFit.log | grep M15 | awk -F "[()%]" '{print $2}')
M25_err=$(grep +/- SigXZ/HalfGPaFit.log | grep M25 | awk -F "[()%]" '{print $2}')
M35_err=$(grep +/- SigXZ/HalfGPaFit.log | grep M35 | awk -F "[()%]" '{print $2}')
M45_err=$(grep +/- SigXZ/HalfGPaFit.log | grep M45 | awk -F "[()%]" '{print $2}')
M55_err=$(grep +/- SigXZ/HalfGPaFit.log | grep M55 | awk -F "[()%]" '{print $2}')
M65_err=$(grep +/- SigXZ/HalfGPaFit.log | grep M65 | awk -F "[()%]" '{print $2}')

########################################################################
#####################   SigXY         ##################################
########################################################################

M16=$(grep +/- SigXY/HalfGPaFit.log | grep M16 | awk '{print $3*10^21}')
M26=$(grep +/- SigXY/HalfGPaFit.log | grep M26 | awk '{print $3*10^21}')
M36=$(grep +/- SigXY/HalfGPaFit.log | grep M36 | awk '{print $3*10^21}')
M46=$(grep +/- SigXY/HalfGPaFit.log | grep M46 | awk '{print $3*10^21}')
M56=$(grep +/- SigXY/HalfGPaFit.log | grep M56 | awk '{print $3*10^21}')
M66=$(grep +/- SigXY/HalfGPaFit.log | grep M66 | awk '{print $3*10^21}')


M16_err=$(grep M16 SigXY/HalfGPaFit.log | awk -F "[()%]" '{print $2}' )
M26_err=$(grep M26 SigXY/HalfGPaFit.log | awk -F "[()%]" '{print $2}' )
M36_err=$(grep M36 SigXY/HalfGPaFit.log | awk -F "[()%]" '{print $2}' )
M46_err=$(grep M46 SigXY/HalfGPaFit.log | awk -F "[()%]" '{print $2}' )
M56_err=$(grep M56 SigXY/HalfGPaFit.log | awk -F "[()%]" '{print $2}' )
M66_err=$(grep M66 SigXY/HalfGPaFit.log | awk -F "[()%]" '{print $2}' )

########################################################################
#####################   Print        ##################################
########################################################################


printf "M_ijkl\n"
printf "%7.2f & %7.2f & %7.2f & %7.2f & %7.2f & %7.2f\n" "$M11" "$M12" "$M13" "$M14" "$M15" "$M16"
printf "%7.2f & %7.2f & %7.2f & %7.2f & %7.2f & %7.2f\n" "$M21" "$M22" "$M23" "$M24" "$M25" "$M26"
printf "%7.2f & %7.2f & %7.2f & %7.2f & %7.2f & %7.2f\n" "$M31" "$M32" "$M33" "$M34" "$M35" "$M36"
printf "%7.2f & %7.2f & %7.2f & %7.2f & %7.2f & %7.2f\n" "$M41" "$M42" "$M43" "$M44" "$M45" "$M46"
printf "%7.2f & %7.2f & %7.2f & %7.2f & %7.2f & %7.2f\n" "$M51" "$M52" "$M53" "$M54" "$M55" "$M56"
printf "%7.2f & %7.2f & %7.2f & %7.2f & %7.2f & %7.2f\n" "$M61" "$M62" "$M63" "$M64" "$M65" "$M66"


printf "M_ijkl error\n"
printf "%5.0f & %5.0f & %5.0f & %5.0f & %5.0f & %5.0f\n" "$M11_err" "$M12_err" "$M13_err" "$M14_err" "$M15_err" "$M16_err"
printf "%5.0f & %5.0f & %5.0f & %5.0f & %5.0f & %5.0f\n" "$M21_err" "$M22_err" "$M23_err" "$M24_err" "$M25_err" "$M26_err"
printf "%5.0f & %5.0f & %5.0f & %5.0f & %5.0f & %5.0f\n" "$M31_err" "$M32_err" "$M33_err" "$M34_err" "$M35_err" "$M36_err"
printf "%5.0f & %5.0f & %5.0f & %5.0f & %5.0f & %5.0f\n" "$M41_err" "$M42_err" "$M43_err" "$M44_err" "$M45_err" "$M46_err"
printf "%5.0f & %5.0f & %5.0f & %5.0f & %5.0f & %5.0f\n" "$M51_err" "$M52_err" "$M53_err" "$M54_err" "$M55_err" "$M56_err"
printf "%5.0f & %5.0f & %5.0f & %5.0f & %5.0f & %5.0f\n" "$M61_err" "$M62_err" "$M63_err" "$M64_err" "$M65_err" "$M66_err"





printf "M_ijkl\n"
printf "%7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f)\n" "$M11" "$M11_err" "$M12" "$M12_err" "$M13" "$M13_err" "$M14" "$M14_err" "$M15" "$M15_err" "$M16" "$M16_err"
printf "%7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f)\n" "$M21" "$M21_err" "$M22" "$M22_err" "$M23" "$M23_err" "$M24" "$M24_err" "$M25" "$M25_err" "$M26" "$M26_err"
printf "%7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f)\n" "$M31" "$M31_err" "$M32" "$M32_err" "$M33" "$M33_err" "$M34" "$M34_err" "$M35" "$M35_err" "$M36" "$M36_err"
printf "%7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f)\n" "$M41" "$M41_err" "$M42" "$M42_err" "$M43" "$M43_err" "$M44" "$M44_err" "$M45" "$M45_err" "$M46" "$M46_err"
printf "%7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f)\n" "$M51" "$M51_err" "$M52" "$M52_err" "$M53" "$M53_err" "$M54" "$M54_err" "$M55" "$M55_err" "$M56" "$M56_err"
printf "%7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f)\n" "$M61" "$M61_err" "$M62" "$M62_err" "$M63" "$M63_err" "$M64" "$M64_err" "$M65" "$M65_err" "$M66" "$M66_err"







Q11=$( grep +/- SigX/HalfGPaFit.log | grep Q11 | awk '{print $3}')
Q21=$( grep +/- SigX/HalfGPaFit.log | grep Q21 | awk '{print $3}')
Q31=$( grep +/- SigX/HalfGPaFit.log | grep Q31 | awk '{print $3}')
Q41=$( grep +/- SigX/HalfGPaFit.log | grep Q41 | awk '{print $3}')
Q51=$( grep +/- SigX/HalfGPaFit.log | grep Q51 | awk '{print $3}')
Q61=$( grep +/- SigX/HalfGPaFit.log | grep Q61 | awk '{print $3}')

Q12=$( grep +/- SigY/HalfGPaFit.log | grep Q12 | awk '{print $3}')
Q22=$( grep +/- SigY/HalfGPaFit.log | grep Q22 | awk '{print $3}')
Q32=$( grep +/- SigY/HalfGPaFit.log | grep Q32 | awk '{print $3}')
Q42=$( grep +/- SigY/HalfGPaFit.log | grep Q42 | awk '{print $3}')
Q52=$( grep +/- SigY/HalfGPaFit.log | grep Q52 | awk '{print $3}')
Q62=$( grep +/- SigY/HalfGPaFit.log | grep Q62 | awk '{print $3}')

Q13=$( grep +/- SigZ/HalfGPaFit.log | grep Q13 | awk '{print $3}')
Q23=$( grep +/- SigZ/HalfGPaFit.log | grep Q23 | awk '{print $3}')
Q33=$( grep +/- SigZ/HalfGPaFit.log | grep Q33 | awk '{print $3}')
Q43=$( grep +/- SigZ/HalfGPaFit.log | grep Q43 | awk '{print $3}')
Q53=$( grep +/- SigZ/HalfGPaFit.log | grep Q53 | awk '{print $3}')
Q63=$( grep +/- SigZ/HalfGPaFit.log | grep Q63 | awk '{print $3}')

Q14=$(grep +/- SigYZ/HalfGPaFit.log | grep Q14 | awk '{print $3}')
Q24=$(grep +/- SigYZ/HalfGPaFit.log | grep Q24 | awk '{print $3}')
Q34=$(grep +/- SigYZ/HalfGPaFit.log | grep Q34 | awk '{print $3}')
Q44=$(grep +/- SigYZ/HalfGPaFit.log | grep Q44 | awk '{print $3}')
Q54=$(grep +/- SigYZ/HalfGPaFit.log | grep Q54 | awk '{print $3}')
Q64=$(grep +/- SigYZ/HalfGPaFit.log | grep Q64 | awk '{print $3}')

Q15=$(grep +/- SigXZ/HalfGPaFit.log | grep Q15 | awk '{print $3}')
Q25=$(grep +/- SigXZ/HalfGPaFit.log | grep Q25 | awk '{print $3}')
Q35=$(grep +/- SigXZ/HalfGPaFit.log | grep Q35 | awk '{print $3}')
Q45=$(grep +/- SigXZ/HalfGPaFit.log | grep Q45 | awk '{print $3}')
Q55=$(grep +/- SigXZ/HalfGPaFit.log | grep Q55 | awk '{print $3}')
Q65=$(grep +/- SigXZ/HalfGPaFit.log | grep Q65 | awk '{print $3}')

Q16=$(grep +/- SigXY/HalfGPaFit.log | grep Q16 | awk '{print $3}')
Q26=$(grep +/- SigXY/HalfGPaFit.log | grep Q26 | awk '{print $3}')
Q36=$(grep +/- SigXY/HalfGPaFit.log | grep Q36 | awk '{print $3}')
Q46=$(grep +/- SigXY/HalfGPaFit.log | grep Q46 | awk '{print $3}')
Q56=$(grep +/- SigXY/HalfGPaFit.log | grep Q56 | awk '{print $3}')
Q66=$(grep +/- SigXY/HalfGPaFit.log | grep Q66 | awk '{print $3}')

printf "Q_ijkl\n"
printf "%7.4f & %7.4f & %7.4f & %7.4f & %7.4f & %7.4f\n" "$Q11" "$Q12" "$Q13" "$Q14" "$Q15" "$Q16"
printf "%7.4f & %7.4f & %7.4f & %7.4f & %7.4f & %7.4f\n" "$Q21" "$Q22" "$Q23" "$Q24" "$Q25" "$Q26"
printf "%7.4f & %7.4f & %7.4f & %7.4f & %7.4f & %7.4f\n" "$Q31" "$Q32" "$Q33" "$Q34" "$Q35" "$Q36"
printf "%7.4f & %7.4f & %7.4f & %7.4f & %7.4f & %7.4f\n" "$Q41" "$Q42" "$Q43" "$Q44" "$Q45" "$Q46"
printf "%7.4f & %7.4f & %7.4f & %7.4f & %7.4f & %7.4f\n" "$Q51" "$Q52" "$Q53" "$Q54" "$Q55" "$Q56"
printf "%7.4f & %7.4f & %7.4f & %7.4f & %7.4f & %7.4f\n" "$Q61" "$Q62" "$Q63" "$Q64" "$Q65" "$Q66"


