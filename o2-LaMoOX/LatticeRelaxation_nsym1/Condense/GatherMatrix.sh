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
printf "                & \\sigma_{xx} & \\sigma_{yy} & \\sigma_{zz} & \\sigma_{yz} & \\sigma_{xz} & \\sigma_{xy} \\ \\ \n"
printf "\\ epsilon_{x}  & %7.2f & %7.2f & %7.2f & %7.2f & %7.2f & %7.2f \\ \\ \n" "$M11" "$M12" "$M13" "$M14" "$M15" "$M16"
printf "\\ epsilon_{y}  & %7.2f & %7.2f & %7.2f & %7.2f & %7.2f & %7.2f \\ \\ \n" "$M21" "$M22" "$M23" "$M24" "$M25" "$M26"
printf "\\ epsilon_{z}  & %7.2f & %7.2f & %7.2f & %7.2f & %7.2f & %7.2f \\ \\ \n" "$M31" "$M32" "$M33" "$M34" "$M35" "$M36"
printf "\\ epsilon_{yz} & %7.2f & %7.2f & %7.2f & %7.2f & %7.2f & %7.2f \\ \\ \n" "$M41" "$M42" "$M43" "$M44" "$M45" "$M46"
printf "\\ epsilon_{xz} & %7.2f & %7.2f & %7.2f & %7.2f & %7.2f & %7.2f \\ \\ \n" "$M51" "$M52" "$M53" "$M54" "$M55" "$M56"
printf "\\ epsilon_{xy} & %7.2f & %7.2f & %7.2f & %7.2f & %7.2f & %7.2f \\ \\ \n" "$M61" "$M62" "$M63" "$M64" "$M65" "$M66"


printf "M_ijkl error\n"
printf "                & \\sigma_{xx} & \\sigma_{yy} & \\sigma_{zz} & \\sigma_{yz} & \\sigma_{xz} & \\sigma_{xy} \\ \\ \n"
printf "\\ epsilon_{x}  & %5.0f & %5.0f & %5.0f & %5.0f & %5.0f & %5.0f\n" "$M11_err" "$M12_err" "$M13_err" "$M14_err" "$M15_err" "$M16_err"
printf "\\ epsilon_{y}  & %5.0f & %5.0f & %5.0f & %5.0f & %5.0f & %5.0f\n" "$M21_err" "$M22_err" "$M23_err" "$M24_err" "$M25_err" "$M26_err"
printf "\\ epsilon_{z}  & %5.0f & %5.0f & %5.0f & %5.0f & %5.0f & %5.0f\n" "$M31_err" "$M32_err" "$M33_err" "$M34_err" "$M35_err" "$M36_err"
printf "\\ epsilon_{yz} & %5.0f & %5.0f & %5.0f & %5.0f & %5.0f & %5.0f\n" "$M41_err" "$M42_err" "$M43_err" "$M44_err" "$M45_err" "$M46_err"
printf "\\ epsilon_{xz} & %5.0f & %5.0f & %5.0f & %5.0f & %5.0f & %5.0f\n" "$M51_err" "$M52_err" "$M53_err" "$M54_err" "$M55_err" "$M56_err"
printf "\\ epsilon_{xy} & %5.0f & %5.0f & %5.0f & %5.0f & %5.0f & %5.0f\n" "$M61_err" "$M62_err" "$M63_err" "$M64_err" "$M65_err" "$M66_err"





printf "M_ijkl\n"
printf "                & \\sigma_{xx} & \\sigma_{yy} & \\sigma_{zz} & \\sigma_{yz} & \\sigma_{xz} & \\sigma_{xy} \\ \\ \n"
printf "\\ epsilon_{x}  & %7.2f(%3.0f%%) & %7.2f(%3.0f%%) & %7.2f(%3.0f%%) & %7.2f(%3.0f%%) & %7.2f(%3.0f%%) & %7.2f(%3.0f%%)\n" "$M11" "$M11_err" "$M12" "$M12_err" "$M13" "$M13_err" "$M14" "$M14_err" "$M15" "$M15_err" "$M16" "$M16_err"
printf "\\ epsilon_{y}  & %7.2f(%3.0f%%) & %7.2f(%3.0f%%) & %7.2f(%3.0f%%) & %7.2f(%3.0f%%) & %7.2f(%3.0f%%) & %7.2f(%3.0f%%)\n" "$M21" "$M21_err" "$M22" "$M22_err" "$M23" "$M23_err" "$M24" "$M24_err" "$M25" "$M25_err" "$M26" "$M26_err"
printf "\\ epsilon_{z}  & %7.2f(%3.0f%%) & %7.2f(%3.0f%%) & %7.2f(%3.0f%%) & %7.2f(%3.0f%%) & %7.2f(%3.0f%%) & %7.2f(%3.0f%%)\n" "$M31" "$M31_err" "$M32" "$M32_err" "$M33" "$M33_err" "$M34" "$M34_err" "$M35" "$M35_err" "$M36" "$M36_err"
printf "\\ epsilon_{yz} & %7.2f(%3.0f%%) & %7.2f(%3.0f%%) & %7.2f(%3.0f%%) & %7.2f(%3.0f%%) & %7.2f(%3.0f%%) & %7.2f(%3.0f%%)\n" "$M41" "$M41_err" "$M42" "$M42_err" "$M43" "$M43_err" "$M44" "$M44_err" "$M45" "$M45_err" "$M46" "$M46_err"
printf "\\ epsilon_{xz} & %7.2f(%3.0f%%) & %7.2f(%3.0f%%) & %7.2f(%3.0f%%) & %7.2f(%3.0f%%) & %7.2f(%3.0f%%) & %7.2f(%3.0f%%)\n" "$M51" "$M51_err" "$M52" "$M52_err" "$M53" "$M53_err" "$M54" "$M54_err" "$M55" "$M55_err" "$M56" "$M56_err"
printf "\\ epsilon_{xy} & %7.2f(%3.0f%%) & %7.2f(%3.0f%%) & %7.2f(%3.0f%%) & %7.2f(%3.0f%%) & %7.2f(%3.0f%%) & %7.2f(%3.0f%%)\n" "$M61" "$M61_err" "$M62" "$M62_err" "$M63" "$M63_err" "$M64" "$M64_err" "$M65" "$M65_err" "$M66" "$M66_err"

printf "M_ijkl\n"
printf "%7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f)\n" "$M11" "$M11_err" "$M12" "$M12_err" "$M13" "$M13_err" "$M14" "$M14_err" "$M15" "$M15_err" "$M16" "$M16_err"
printf "%7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f)\n" "$M21" "$M21_err" "$M22" "$M22_err" "$M23" "$M23_err" "$M24" "$M24_err" "$M25" "$M25_err" "$M26" "$M26_err"
printf "%7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f)\n" "$M31" "$M31_err" "$M32" "$M32_err" "$M33" "$M33_err" "$M34" "$M34_err" "$M35" "$M35_err" "$M36" "$M36_err"
printf "%7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f)\n" "$M41" "$M41_err" "$M42" "$M42_err" "$M43" "$M43_err" "$M44" "$M44_err" "$M45" "$M45_err" "$M46" "$M46_err"
printf "%7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f)\n" "$M51" "$M51_err" "$M52" "$M52_err" "$M53" "$M53_err" "$M54" "$M54_err" "$M55" "$M55_err" "$M56" "$M56_err"
printf "%7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f) & %7.2f &(%5.0f)\n" "$M61" "$M61_err" "$M62" "$M62_err" "$M63" "$M63_err" "$M64" "$M64_err" "$M65" "$M65_err" "$M66" "$M66_err"




########################################################################
#####################   SigX         ###################################
########################################################################

Q11=$( grep +/- SigX/HalfGPaFit.log | grep Q11 | awk '{print $3}')
Q21=$( grep +/- SigX/HalfGPaFit.log | grep Q21 | awk '{print $3}')
Q31=$( grep +/- SigX/HalfGPaFit.log | grep Q31 | awk '{print $3}')
Q41=$( grep +/- SigX/HalfGPaFit.log | grep Q41 | awk '{print $3}')
Q51=$( grep +/- SigX/HalfGPaFit.log | grep Q51 | awk '{print $3}')
Q61=$( grep +/- SigX/HalfGPaFit.log | grep Q61 | awk '{print $3}')

Q11_err=$( grep Q11 SigX/HalfGPaFit.log |  awk -F "[()%]" '{print $2}')
Q21_err=$( grep Q21 SigX/HalfGPaFit.log |  awk -F "[()%]" '{print $2}')
Q31_err=$( grep Q31 SigX/HalfGPaFit.log |  awk -F "[()%]" '{print $2}')
Q41_err=$( grep Q41 SigX/HalfGPaFit.log |  awk -F "[()%]" '{print $2}')
Q51_err=$( grep Q51 SigX/HalfGPaFit.log |  awk -F "[()%]" '{print $2}')
Q61_err=$( grep Q61 SigX/HalfGPaFit.log |  awk -F "[()%]" '{print $2}')




########################################################################
#####################   SigY         ###################################
########################################################################

Q12=$( grep +/- SigY/HalfGPaFit.log | grep Q12 | awk '{print $3}')
Q22=$( grep +/- SigY/HalfGPaFit.log | grep Q22 | awk '{print $3}')
Q32=$( grep +/- SigY/HalfGPaFit.log | grep Q32 | awk '{print $3}')
Q42=$( grep +/- SigY/HalfGPaFit.log | grep Q42 | awk '{print $3}')
Q52=$( grep +/- SigY/HalfGPaFit.log | grep Q52 | awk '{print $3}')
Q62=$( grep +/- SigY/HalfGPaFit.log | grep Q62 | awk '{print $3}')

Q12_err=$( grep Q12 SigY/HalfGPaFit.log |  awk -F "[()%]" '{print $2}')
Q22_err=$( grep Q22 SigY/HalfGPaFit.log |  awk -F "[()%]" '{print $2}')
Q32_err=$( grep Q32 SigY/HalfGPaFit.log |  awk -F "[()%]" '{print $2}')
Q42_err=$( grep Q42 SigY/HalfGPaFit.log |  awk -F "[()%]" '{print $2}')
Q52_err=$( grep Q52 SigY/HalfGPaFit.log |  awk -F "[()%]" '{print $2}')
Q62_err=$( grep Q62 SigY/HalfGPaFit.log |  awk -F "[()%]" '{print $2}')

########################################################################
#####################   SigZ         ###################################
########################################################################

Q13=$( grep +/- SigZ/HalfGPaFit.log | grep Q13 | awk '{print $3}')
Q23=$( grep +/- SigZ/HalfGPaFit.log | grep Q23 | awk '{print $3}')
Q33=$( grep +/- SigZ/HalfGPaFit.log | grep Q33 | awk '{print $3}')
Q43=$( grep +/- SigZ/HalfGPaFit.log | grep Q43 | awk '{print $3}')
Q53=$( grep +/- SigZ/HalfGPaFit.log | grep Q53 | awk '{print $3}')
Q63=$( grep +/- SigZ/HalfGPaFit.log | grep Q63 | awk '{print $3}')

Q13_err=$( grep Q13 SigZ/HalfGPaFit.log |  awk -F "[()%]" '{print $2}')
Q23_err=$( grep Q23 SigZ/HalfGPaFit.log |  awk -F "[()%]" '{print $2}')
Q33_err=$( grep Q33 SigZ/HalfGPaFit.log |  awk -F "[()%]" '{print $2}')
Q43_err=$( grep Q43 SigZ/HalfGPaFit.log |  awk -F "[()%]" '{print $2}')
Q53_err=$( grep Q53 SigZ/HalfGPaFit.log |  awk -F "[()%]" '{print $2}')
Q63_err=$( grep Q63 SigZ/HalfGPaFit.log |  awk -F "[()%]" '{print $2}')



########################################################################
#####################   SigYZ        ###################################
########################################################################

Q14=$(grep +/- SigYZ/HalfGPaFit.log | grep Q14 | awk '{print $3}')
Q24=$(grep +/- SigYZ/HalfGPaFit.log | grep Q24 | awk '{print $3}')
Q34=$(grep +/- SigYZ/HalfGPaFit.log | grep Q34 | awk '{print $3}')
Q44=$(grep +/- SigYZ/HalfGPaFit.log | grep Q44 | awk '{print $3}')
Q54=$(grep +/- SigYZ/HalfGPaFit.log | grep Q54 | awk '{print $3}')
Q64=$(grep +/- SigYZ/HalfGPaFit.log | grep Q64 | awk '{print $3}')

Q14_err=$( grep Q14 SigYZ/HalfGPaFit.log |  awk -F "[()%]" '{print $2}')
Q24_err=$( grep Q24 SigYZ/HalfGPaFit.log |  awk -F "[()%]" '{print $2}')
Q34_err=$( grep Q34 SigYZ/HalfGPaFit.log |  awk -F "[()%]" '{print $2}')
Q44_err=$( grep Q44 SigYZ/HalfGPaFit.log |  awk -F "[()%]" '{print $2}')
Q54_err=$( grep Q54 SigYZ/HalfGPaFit.log |  awk -F "[()%]" '{print $2}')
Q64_err=$( grep Q64 SigYZ/HalfGPaFit.log |  awk -F "[()%]" '{print $2}')



########################################################################
#####################   SigXZ        ###################################
########################################################################

Q15=$(grep +/- SigXZ/HalfGPaFit.log | grep Q15 | awk '{print $3}')
Q25=$(grep +/- SigXZ/HalfGPaFit.log | grep Q25 | awk '{print $3}')
Q35=$(grep +/- SigXZ/HalfGPaFit.log | grep Q35 | awk '{print $3}')
Q45=$(grep +/- SigXZ/HalfGPaFit.log | grep Q45 | awk '{print $3}')
Q55=$(grep +/- SigXZ/HalfGPaFit.log | grep Q55 | awk '{print $3}')
Q65=$(grep +/- SigXZ/HalfGPaFit.log | grep Q65 | awk '{print $3}')

Q15_err=$( grep Q15 SigXZ/HalfGPaFit.log |  awk -F "[()%]" '{print $2}')
Q25_err=$( grep Q25 SigXZ/HalfGPaFit.log |  awk -F "[()%]" '{print $2}')
Q35_err=$( grep Q35 SigXZ/HalfGPaFit.log |  awk -F "[()%]" '{print $2}')
Q45_err=$( grep Q45 SigXZ/HalfGPaFit.log |  awk -F "[()%]" '{print $2}')
Q55_err=$( grep Q55 SigXZ/HalfGPaFit.log |  awk -F "[()%]" '{print $2}')
Q65_err=$( grep Q65 SigXZ/HalfGPaFit.log |  awk -F "[()%]" '{print $2}')


########################################################################
#####################   SigXY        ###################################
########################################################################

Q16=$(grep +/- SigXY/HalfGPaFit.log | grep Q16 | awk '{print $3}')
Q26=$(grep +/- SigXY/HalfGPaFit.log | grep Q26 | awk '{print $3}')
Q36=$(grep +/- SigXY/HalfGPaFit.log | grep Q36 | awk '{print $3}')
Q46=$(grep +/- SigXY/HalfGPaFit.log | grep Q46 | awk '{print $3}')
Q56=$(grep +/- SigXY/HalfGPaFit.log | grep Q56 | awk '{print $3}')
Q66=$(grep +/- SigXY/HalfGPaFit.log | grep Q66 | awk '{print $3}')


Q16_err=$( grep Q16 SigXY/HalfGPaFit.log |  awk -F "[()%]" '{print $2}')
Q26_err=$( grep Q26 SigXY/HalfGPaFit.log |  awk -F "[()%]" '{print $2}')
Q36_err=$( grep Q36 SigXY/HalfGPaFit.log |  awk -F "[()%]" '{print $2}')
Q46_err=$( grep Q46 SigXY/HalfGPaFit.log |  awk -F "[()%]" '{print $2}')
Q56_err=$( grep Q56 SigXY/HalfGPaFit.log |  awk -F "[()%]" '{print $2}')
Q66_err=$( grep Q66 SigXY/HalfGPaFit.log |  awk -F "[()%]" '{print $2}')


########################################################################
#####################  Print         ###################################
########################################################################


#printf '\Q_ijkl\\n'
#printf '\\begin\{matrix\}\n'
printf "            & \\sigma_{xx} & \\sigma_{yy} & \\sigma_{zz} & \\sigma_{yz} & \\sigma_{xz} & \\sigma_{xy} \\ \\ \n"
printf "\\ eta_{x}  & %7.4f & %7.4f & %7.4f & %7.4f & %7.4f & %7.4f \\ \\ \n" "$Q11" "$Q12" "$Q13" "$Q14" "$Q15" "$Q16"
printf "\\ eta_{y}  & %7.4f & %7.4f & %7.4f & %7.4f & %7.4f & %7.4f \\ \\ \n" "$Q21" "$Q22" "$Q23" "$Q24" "$Q25" "$Q26"
printf "\\ eta_{z}  & %7.4f & %7.4f & %7.4f & %7.4f & %7.4f & %7.4f \\ \\ \n" "$Q31" "$Q32" "$Q33" "$Q34" "$Q35" "$Q36"
printf "\\ eta_{yz} & %7.4f & %7.4f & %7.4f & %7.4f & %7.4f & %7.4f \\ \\ \n" "$Q41" "$Q42" "$Q43" "$Q44" "$Q45" "$Q46"
printf "\\ eta_{xz} & %7.4f & %7.4f & %7.4f & %7.4f & %7.4f & %7.4f \\ \\ \n" "$Q51" "$Q52" "$Q53" "$Q54" "$Q55" "$Q56"
printf "\\ eta_{xy} & %7.4f & %7.4f & %7.4f & %7.4f & %7.4f & %7.4f \\ \\ \n" "$Q61" "$Q62" "$Q63" "$Q64" "$Q65" "$Q66"
#printf "\$\n\\begin\{matrix\}\n

printf "Q_ijkl\n"
printf "             & \\sigma_{xx} & \\sigma_{yy} & \\sigma_{zz} & \\sigma_{yz} & \\sigma_{xz} & \\sigma_{xy} \\ \\ \n"
printf "%7.4f(%3.0f) & %7.4f(%3.0f) & %7.4f(%3.0f) & %7.4f(%3.0f) & %7.4f(%3.0f) & %7.4f(%3.0f)\n" "$Q11" "$Q11_err" "$Q12" "$Q12_err" "$Q13" "$Q13_err" "$Q14" "$Q14_err" "$Q15" "$Q15_err" "$Q16" "$Q16_err"
printf "%7.4f(%3.0f) & %7.4f(%3.0f) & %7.4f(%3.0f) & %7.4f(%3.0f) & %7.4f(%3.0f) & %7.4f(%3.0f)\n" "$Q21" "$Q21_err" "$Q22" "$Q22_err" "$Q23" "$Q23_err" "$Q24" "$Q24_err" "$Q25" "$Q25_err" "$Q26" "$Q26_err"
printf "%7.4f(%3.0f) & %7.4f(%3.0f) & %7.4f(%3.0f) & %7.4f(%3.0f) & %7.4f(%3.0f) & %7.4f(%3.0f)\n" "$Q31" "$Q31_err" "$Q32" "$Q32_err" "$Q33" "$Q33_err" "$Q34" "$Q34_err" "$Q35" "$Q35_err" "$Q36" "$Q36_err"
printf "%7.4f(%3.0f) & %7.4f(%3.0f) & %7.4f(%3.0f) & %7.4f(%3.0f) & %7.4f(%3.0f) & %7.4f(%3.0f)\n" "$Q41" "$Q41_err" "$Q42" "$Q42_err" "$Q43" "$Q43_err" "$Q44" "$Q44_err" "$Q45" "$Q45_err" "$Q46" "$Q46_err"
printf "%7.4f(%3.0f) & %7.4f(%3.0f) & %7.4f(%3.0f) & %7.4f(%3.0f) & %7.4f(%3.0f) & %7.4f(%3.0f)\n" "$Q51" "$Q51_err" "$Q52" "$Q52_err" "$Q53" "$Q53_err" "$Q54" "$Q54_err" "$Q55" "$Q55_err" "$Q56" "$Q56_err"
printf "%7.4f(%3.0f) & %7.4f(%3.0f) & %7.4f(%3.0f) & %7.4f(%3.0f) & %7.4f(%3.0f) & %7.4f(%3.0f)\n" "$Q61" "$Q61_err" "$Q62" "$Q62_err" "$Q63" "$Q63_err" "$Q64" "$Q64_err" "$Q65" "$Q65_err" "$Q66" "$Q66_err"


########################################################################
#####################  Write Markdown files  ###########################
########################################################################

printf "M_ijkl (fitting error in percentage)\n" > Matrix.md
printf "|        | sig_xx         | sig_yy         | sig_zz         | sig_yz         | sig_xz         | sig_xy         |\n" >> Matrix.md
printf "| -----  | -------------- | -------------- | -------------- | -------------- | -------------- | -------------- |\n" >> Matrix.md
printf "| eps_x  | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) |\n" "$M11" "$M11_err" "$M12" "$M12_err" "$M13" "$M13_err" "$M14" "$M14_err" "$M15" "$M15_err" "$M16" "$M16_err" >> Matrix.md
printf "| eps_y  | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) |\n" "$M21" "$M21_err" "$M22" "$M22_err" "$M23" "$M23_err" "$M24" "$M24_err" "$M25" "$M25_err" "$M26" "$M26_err" >> Matrix.md
printf "| eps_z  | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) |\n" "$M31" "$M31_err" "$M32" "$M32_err" "$M33" "$M33_err" "$M34" "$M34_err" "$M35" "$M35_err" "$M36" "$M36_err" >> Matrix.md
printf "| eps_yz | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) |\n" "$M41" "$M41_err" "$M42" "$M42_err" "$M43" "$M43_err" "$M44" "$M44_err" "$M45" "$M45_err" "$M46" "$M46_err" >> Matrix.md
printf "| eps_xz | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) |\n" "$M51" "$M51_err" "$M52" "$M52_err" "$M53" "$M53_err" "$M54" "$M54_err" "$M55" "$M55_err" "$M56" "$M56_err" >> Matrix.md
printf "| eps_xy | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) |\n" "$M61" "$M61_err" "$M62" "$M62_err" "$M63" "$M63_err" "$M64" "$M64_err" "$M65" "$M65_err" "$M66" "$M66_err" >> Matrix.md

printf "\n\n" >> Matrix.md

printf "Q_ijkl (fitting error in percentage)\n" >> Matrix.md
printf "|        | sig_xx         | sig_yy         | sig_zz         | sig_yz         | sig_xz         | sig_xy         |\n" >> Matrix.md
printf "| -----  | -------------- | -------------- | -------------- | -------------- | -------------- | -------------- |\n" >> Matrix.md
printf "| eta_x  | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) |\n" "$Q11" "$Q11_err" "$Q12" "$Q12_err" "$Q13" "$Q13_err" "$Q14" "$Q14_err" "$Q15" "$Q15_err" "$Q16" "$Q16_err" >> Matrix.md
printf "| eta_y  | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) |\n" "$Q21" "$Q21_err" "$Q22" "$Q22_err" "$Q23" "$Q23_err" "$Q24" "$Q24_err" "$Q25" "$Q25_err" "$Q26" "$Q26_err" >> Matrix.md
printf "| eta_z  | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) |\n" "$Q31" "$Q31_err" "$Q32" "$Q32_err" "$Q33" "$Q33_err" "$Q34" "$Q34_err" "$Q35" "$Q35_err" "$Q36" "$Q36_err" >> Matrix.md
printf "| eta_yz | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) |\n" "$Q41" "$Q41_err" "$Q42" "$Q42_err" "$Q43" "$Q43_err" "$Q44" "$Q44_err" "$Q45" "$Q45_err" "$Q46" "$Q46_err" >> Matrix.md
printf "| eta_xz | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) |\n" "$Q51" "$Q51_err" "$Q52" "$Q52_err" "$Q53" "$Q53_err" "$Q54" "$Q54_err" "$Q55" "$Q55_err" "$Q56" "$Q56_err" >> Matrix.md
printf "| eta_xy | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) | %7.2f(%3.0f%%) |\n" "$Q61" "$Q61_err" "$Q62" "$Q62_err" "$Q63" "$Q63_err" "$Q64" "$Q64_err" "$Q65" "$Q65_err" "$Q66" "$Q66_err" >> Matrix.md
