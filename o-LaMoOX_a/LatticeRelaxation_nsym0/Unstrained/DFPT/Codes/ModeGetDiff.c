#include <stdio.h>
#include "funcs.h"
#include <math.h>
#include <stdlib.h>


int main(int argc, char **argv ){

if(argc != 3){
   printf("Needs input arguments:\n");
   printf("abi.in ;  anaddb.out\n");
   exit( 1 );
   }

char file1[200], file2[200], file3[200];

int i,j, k, N;
int natom, Nmodes;
FILE *fptr;
char line[200], string[80], C;
double D;
double epsExx, epsExy, epsExz, epsEyx, epsEyy, epsEyz, epsEzx, epsEzy, epsEzz;
double epsxx,  epsxy,  epsxz,  epsyx,  epsyy,  epsyz,  epszx,  epszy,  epszz;
double vol0;

//Get number of atoms and number of modes for later reading.
natom=0;
fptr=safe_open(argv[1],"r");
SkipTo(fptr,"natom",line); sscanf(line,"%s %d", string, &natom);
if(natom==0){ 
   printf("you have read that natom is 0, check to see that natom is at line beginning in abi.in. Exiting\n\n");
   exit( 1 ) ;
   }
fclose(fptr);

Nmodes=natom*3;                         //This is number of modes including acoustic.
struct mode Modes[Nmodes];
for(i=0;i<Nmodes;i++) Modes[i].N=i+1;

// Get Volume
fptr=safe_open( argv[2] , "r" );
SkipTo(fptr, " Unit cell volume ucvol=", line);
sscanf(line, "%s %s %s %s %lf %s", string,string, string, string,  &vol0, string);
fclose(fptr);

GetEnergiesAndFrequencies(  argv[2], Modes, natom, 1);
GetEigenDisplacements(      argv[2], Modes, natom, 1);
GetEffectiveCharges(        argv[2], Modes, natom, 1);
GetOscillatorStrengths(     argv[2], Modes, natom, 1);


fptr=safe_open( argv[2] , "r" );

SkipTo(fptr," Electronic dielectric tensor",line);
fgets(line, 200, fptr); sscanf(line, "%lf %lf %lf", &epsExx, &epsExy, &epsExz );
fgets(line, 200, fptr); sscanf(line, "%lf %lf %lf", &epsEyx, &epsEyy, &epsEyz );
fgets(line, 200, fptr); sscanf(line, "%lf %lf %lf", &epsEzx, &epsEzy, &epsEzz );
SkipTo(fptr," Relaxed ion dielectric tensor", line);
fgets(line, 200, fptr); sscanf(line, "%lf %lf %lf", &epsxx, &epsxy, &epsxz );
fgets(line, 200, fptr); sscanf(line, "%lf %lf %lf", &epsyx, &epsyy, &epsyz );
fgets(line, 200, fptr); sscanf(line, "%lf %lf %lf", &epszx, &epszy, &epszz );

for(i=0;i<Nmodes;i++) Modes[i].epsZZ=0;

SkipTo(fptr," Mode by mode decomposition",line);
for(i=0;i<3;i++){
   SkipTo(fptr," Mode number",line);
   sscanf(line, "%s %s %d", string, string, &N);
   fgets(line,200,fptr);
   sscanf(line,"%lf %lf %lf", &Modes[N-1].epsXX, &D, &D);
   fgets(line,200,fptr);
   sscanf(line,"%lf %lf %lf", &D, &Modes[N-1].epsYY, &D);
   fgets(line,200,fptr);
   sscanf(line,"%lf %lf %lf", &D, &D, &Modes[N-1].epsZZ);
   }

fclose(fptr);

printf("\n%3s %7s %7s %7s %7s %9s\n", "N","w(cm-1)", "Zx", "Zy", "Zz", "EpsZCont");
for(i=0;i<Nmodes;i++)
   printf("%3d %7.2lf %7.2lf %7.2lf %7.2lf %9.3lf\n", Modes[i].N, Modes[i].w, Modes[i].Z[0], Modes[i].Z[1], Modes[i].Z[2],Modes[i].epsZZ);


double c=299792458;                            // m/s
double vol_SI, Sx_SI, w_SI, ModeContrib;
vol_SI=vol0*pow((0.529177*pow(10,-10)),3);
Sx_SI=Modes[5].Sx*253.2638413;
w_SI=Modes[5].w*2*M_PI*c*100;
ModeContrib=( 4*M_PI/vol_SI  )*Sx_SI/(w_SI*w_SI);

printf("\n\nAnalytic decomposition\n");
printf("Relevant quantities:\n");
printf("%20s %10s %10s %10s %10s\n", "Unit", "elecXX", "vol", "S", "w");
printf("%20s %10lf %10g %10lf %10g\n\n", "- m^3 m^3/s^2 rad/s", epsExx, vol_SI, Sx_SI, w_SI);

printf("%10s + (%10s/%10s)*%10s/%10s = %10s\n", "epseXX", "4*pi", "V", "S6,xx" , "w6^2", "  ");
//printf("S.I.\n");
printf("%10lf + (%10lf/%10g)*%10lf/(%10g)^2 = %lf\n", epsExx, 4*M_PI, vol_SI, Sx_SI, w_SI , epsExx + ModeContrib  );
printf("%10lf + %10lf\n", epsExx, ModeContrib);


fptr=safe_open("EpsDecompDecomp.txt", "w");
fprintf(fptr,"%12s %12s %12s %12s %12s %12s\n", "elec", "S", "w", "full", "full (sum)", "EpsZZ_abi");
fprintf(fptr,"%12lf %12lf %12g %12lf %12lf %12lf\n", epsExx, Sx_SI, w_SI, epsxx, epsExx+ModeContrib, Modes[5].epsXX);

return 0;
}



