#include <stdio.h>
#include "funcs.h"
#include <math.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char **argv ){

if(argc != 3){
   printf("Needs input arguments:\n");
   printf("abi.in ;  anaddb.out\n");
   exit( 1 );
   }

char file1[200], file2[200], file3[200];
char abiIn[200], anaddb[200];

strcpy(abiIn,  argv[1]);
strcpy(anaddb, argv[2]);
puts(abiIn);
puts(anaddb);


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
fptr=safe_open(abiIn,"r");
SkipTo(fptr,"natom",line); sscanf(line,"%s %d", string, &natom);
if(natom==0){ 
   printf("you have read that natom is 0, check to see that natom is at line beginning in abi.in. Exiting\n\n");
   exit( 1 ) ;
   }
printf("natom=%d\n", natom);

double x[natom], y[natom], z[natom];
double x_[natom], y_[natom], z_[natom];
double xNew[natom], yNew[natom], zNew[natom];
double x_New[natom], y_New[natom], z_New[natom];
double a[3], b[3], c[3];

//Get lattice vectors
SkipTo(fptr, "rprim", line);
fgets(line,200,fptr);
sscanf(line, "%lf %lf %lf", &a[0], &a[1], &a[2] );
fgets(line,200,fptr);
sscanf(line, "%lf %lf %lf", &b[0], &b[1], &b[2] );
fgets(line,200,fptr);
sscanf(line, "%lf %lf %lf", &c[0], &c[1], &c[2] );

printf("rprim\n");
printf("%10lf %10lf %10lf\n", a[0], a[1], a[2]);
printf("%10lf %10lf %10lf\n", b[0], b[1], b[2]);
printf("%10lf %10lf %10lf\n", c[0], c[1], c[2]);

//Get atomic positions
printf("xred\n");
SkipTo(fptr,"xred", line);
for(i=0; i<natom; i++){
   fgets(line,200,fptr);
   sscanf(line, "%lf %lf %lf", &x[i], &y[i], &z[i] );
   printf("%10lf %10lf %10lf\n", x[i], y[i], z[i] );
   }
fclose(fptr);
getchar();

for(i=0;i<natom;i++){
   x_[i]= x[i]*a[0];
   y_[i]= y[i]*b[1];
   z_[i]= z[i]*c[2];
   }

Nmodes=natom*3;                         //This is number of modes including acoustic.
struct mode Modes[Nmodes];
for(i=0;i<Nmodes;i++) Modes[i].N=i+1;

// Get Volume
fptr=safe_open( anaddb , "r" );
SkipTo(fptr, " Unit cell volume ucvol=", line);
sscanf(line, "%s %s %s %s %lf %s", string,string, string, string,  &vol0, string);
fclose(fptr);

GetEnergiesAndFrequencies(  anaddb, Modes, natom, 1);
GetEigenDisplacements(      anaddb, Modes, natom, 1);
GetEffectiveCharges(        anaddb, Modes, natom, 1);
GetOscillatorStrengths(     anaddb, Modes, natom, 1);

printf("Condsed Mode 1\n");
printf("cartesian\n");
for(i=0;i<natom;i++){
   xNew[i]=x_[i] + Modes[0].eig[i][0]*100;
   yNew[i]=y_[i] + Modes[0].eig[i][1]*100;
   zNew[i]=z_[i] + Modes[0].eig[i][2]*100;
   printf("%10lf %10lf %10lf\n", xNew[i], yNew[i], zNew[i]);
   }




fptr=safe_open( anaddb , "r" );

SkipTo(fptr," Electronic dielectric tensor",line);
fgets(line, 200, fptr); sscanf(line, "%lf %lf %lf", &epsExx, &epsExy, &epsExz );
fgets(line, 200, fptr); sscanf(line, "%lf %lf %lf", &epsEyx, &epsEyy, &epsEyz );
fgets(line, 200, fptr); sscanf(line, "%lf %lf %lf", &epsEzx, &epsEzy, &epsEzz );
SkipTo(fptr," Relaxed ion dielectric tensor", line);
fgets(line, 200, fptr); sscanf(line, "%lf %lf %lf", &epsxx, &epsxy, &epsxz );
fgets(line, 200, fptr); sscanf(line, "%lf %lf %lf", &epsyx, &epsyy, &epsyz );
fgets(line, 200, fptr); sscanf(line, "%lf %lf %lf", &epszx, &epszy, &epszz );






return 0;
}



