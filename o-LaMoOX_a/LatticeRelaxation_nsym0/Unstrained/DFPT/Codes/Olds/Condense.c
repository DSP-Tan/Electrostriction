#include <stdio.h>
#include "funcs.h"
#include <math.h>
#include <stdlib.h>
#include <string.h>


struct mode* ModeSort(struct mode *Modes, int size);


int main(int argc, char **argv ){

if(argc != 3){
   printf("Needs input arguments:\n");
   printf("abi.in ;  anaddb.out\n");
   exit( 1 );
   }

char abiIn[200], anaddb[200];

strcpy(abiIn,  argv[1]);
strcpy(anaddb, argv[2]);
puts(abiIn);
puts(anaddb);


int i,j, k, l;
int natom, Nmodes;
FILE *fptr;
char line[200], string[80];
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

struct atom Atoms0[natom];
struct atom Atoms[natom];
double a[3], b[3], c[3];
double a0;                                         //Unrelaxed cubic lattice constant.

//Get lattice vectors
SkipTo(fptr, "rprim", line);
fgets(line,200,fptr); sscanf(line, "%lf %lf %lf", &a[0], &a[1], &a[2] ); 
fgets(line,200,fptr); sscanf(line, "%lf %lf %lf", &b[0], &b[1], &b[2] );
fgets(line,200,fptr); sscanf(line, "%lf %lf %lf", &c[0], &c[1], &c[2] );

printf("rprim\n");
printf("%10lf %10lf %10lf\n", a[0], a[1], a[2]);
printf("%10lf %10lf %10lf\n", b[0], b[1], b[2]);
printf("%10lf %10lf %10lf\n", c[0], c[1], c[2]);

//Get atomic positions
printf("xred\n");
SkipTo(fptr,"xred", line);
for(i=0; i<natom; i++){
   fgets(line,200,fptr);
   sscanf(line, "%lf %lf %lf", &Atoms[i].xs, &Atoms[i].ys, &Atoms[i].zs );
   //printf("%10lf %10lf %10lf\n", Atoms[i].xs, Atoms[i].ys, Atoms[i].zs );
   Atoms[i].x= Atoms[i].xs*a[0] + Atoms[i].ys*b[0] + Atoms[i].zs*c[0];
   Atoms[i].y= Atoms[i].xs*a[1] + Atoms[i].ys*b[1] + Atoms[i].zs*c[1];
   Atoms[i].x= Atoms[i].xs*a[2] + Atoms[i].ys*b[2] + Atoms[i].zs*c[2];
   }
fclose(fptr);


/* Unrelaxed positions and names */
/*-------------------------------*/
fptr=safe_open("o-La2Mo2O9.cif","r");
SkipTo(fptr,"_cell_length_a", line);
sscanf(line,"%s %lf", string, &a0);
SkipTo(fptr," _atom_site_occupancy",line);
for(i=0;i<natom;i++){
   fgets(line,200,fptr);
   sscanf(line,"%s %s %d %lf %lf %lf %d", string, Atoms0[i].name, &l, &Atoms0[i].xs, &Atoms0[i].ys, &Atoms0[i].zs, &l);
   sscanf(line,"%s %s %d %lf %lf %lf %d", string, Atoms[i].name, &l, &Atoms0[i].xs, &Atoms0[i].ys, &Atoms0[i].zs, &l);
   Atoms0[i].x = Atoms0[i].xs*a0; 
   Atoms0[i].y = Atoms0[i].ys*a0; 
   Atoms0[i].z = Atoms0[i].zs*a0;
   //printf("%10s %10lf %10lf %10lf\n",  Atoms0[i].name,  Atoms0[i].xs, Atoms0[i].ys, Atoms0[i].zs);
   }
fclose(fptr);
/*-------------------------------*/




// DFPT related properties from anaddb

Nmodes=natom*3;                         //This is number of modes including acoustic.
struct mode Modes[Nmodes];
for(i=0;i<Nmodes;i++) Modes[i].N=i+1;

// Get Volume
fptr=safe_open( anaddb , "r" );
SkipTo(fptr, " Unit cell volume ucvol=", line);
sscanf(line, "%s %s %s %s %lf %s", string,string, string, string,  &vol0, string);
fclose(fptr);

/*-------------------------------------------------------------*/
/*--------------- Get Born effective Charge -------------------*/
/*-------------------------------------------------------------*/

fptr=safe_open( anaddb , "r" );
double Z[natom][3][3];

for(i=0;i<natom;i++)
   for(j=0;j<3;j++)
      for(k=0;k<3;k++)
         Z[i][j][k]=0.0;

SkipTo(fptr, " Effective charge tensors after", line);
fgets(line,200,fptr);
fgets(line,200,fptr);
fgets(line,200,fptr);

for(i=0;i<natom;i++){
   fgets(line,200,fptr); sscanf(line,"%d %d %lf %lf %lf", &l, &l, &Z[i][0][0], &Z[i][0][1], &Z[i][0][2]);
   fgets(line,200,fptr); sscanf(line,"%d %d %lf %lf %lf", &l, &l, &Z[i][1][0], &Z[i][1][1], &Z[i][1][2]);
   fgets(line,200,fptr); sscanf(line,"%d %d %lf %lf %lf", &l, &l, &Z[i][2][0], &Z[i][2][1], &Z[i][2][2]);

   if(1==0){
      printf("%3d %3d %10.4lf %10.4lf %10.4lf\n",i+1, 1, Z[i][0][0], Z[i][0][1], Z[i][0][2]);
      printf("%3d %3d %10.4lf %10.4lf %10.4lf\n",i+1, 2, Z[i][1][0], Z[i][1][1], Z[i][1][2]);
      printf("%3d %3d %10.4lf %10.4lf %10.4lf\n",i+1, 3, Z[i][2][0], Z[i][2][1], Z[i][2][2]);
      }
   }
fclose(fptr);

double Zx, Zy, Zz, Zxy, Zxz, Zyz, Zyx, Zzx, Zzy;
for(i=0;i<natom;i++){
   Zx+=Z[i][0][0];
   Zy+=Z[i][1][1];
   Zz+=Z[i][2][2];
   Zxy+=Z[i][0][1];
   Zxz+=Z[i][0][2];
   Zyx+=Z[i][1][0];
   Zyz+=Z[i][1][2];
   Zzx+=Z[i][2][0];
   Zzy+=Z[i][2][1];
   }
printf("The sums of Z*ijk over each direction give:\n");
printf("%10.5lf %10.5lf %10.5lf\n", Zx, Zxy, Zxz);
printf("%10.5lf %10.5lf %10.5lf\n", Zy, Zy, Zyz);
printf("%10.5lf %10.5lf %10.5lf\n", Zzx, Zzy, Zz);

/* Don't work do it 
printf("Before function\n");
printf("%10s %10lf %10lf %10lf\n",  Atoms0[0].name,  Atoms0[0].xs, Atoms0[0].ys, Atoms0[0].zs);
printf("%10s %10lf %10lf %10lf\n",  Atoms[0].name,  Atoms[0].xs, Atoms[0].ys, Atoms[0].zs);
GetBornEffectiveCharges(    anaddb, Atoms, natom, 1);
printf("After function\n");
printf("%10s %10lf %10lf %10lf\n",  Atoms0[0].name,  Atoms0[0].xs, Atoms0[0].ys, Atoms0[0].zs);
getchar();getchar();
*/

/*-------------------------------------------------------------*/
/*-------------------------------------------------------------*/
/*-------------------------------------------------------------*/


GetEnergiesAndFrequencies(  anaddb, Modes, natom, 0);
GetEigenDisplacements(      anaddb, Modes, natom, 0);
GetModeEffectiveCharges(    anaddb, Modes, natom, 1);
GetOscillatorStrengths(     anaddb, Modes, natom, 0);


// All we want to do is print the normalised mode, so we will just 
// slap that in here. See Bi2O3 for proper version.
double nu_x[natom], nu_y[natom], nu_z[natom] ; // These will be normalised eigendisps for looking at.
double P[natom][3], Px, Py, Pz,P_;             // P[i][j] is polarisation produced by atom i in direction j due to phonon mode
                                               // Px is total polarisation in x, Py in y, Pz in z; P_ is modulus of induced polarisation of an atom.

for(i=0;i<natom;i++)for(j=0;j<3;j++) P[i][j]=0;
Px=Py=Pz=P_=0;


printf("Condsed Mode 1\n");
printf("%6s %10s %10s %10s\t%10s %10s %10s %10s\n","at", "dx", "dy", "dz",  "dPx", "dPy", "dPz", "|P|");
for(i=0;i<natom;i++){
   nu_x[i]=Modes[3].eig[i][0];
   nu_y[i]=Modes[3].eig[i][1];
   nu_z[i]=Modes[3].eig[i][2];

   Px += P[i][0]= Z[i][0][0]*nu_x[i] + Z[i][1][0]*nu_y[i] + Z[i][2][0]*nu_z[i];
   Py += P[i][1]= Z[i][0][1]*nu_x[i] + Z[i][1][1]*nu_y[i] + Z[i][2][1]*nu_z[i];
   Pz += P[i][2]= Z[i][0][2]*nu_x[i] + Z[i][1][2]*nu_y[i] + Z[i][2][2]*nu_z[i];
   
   P_= sqrt(P[i][0]*P[i][0] + P[i][1]*P[i][1] + P[i][2]*P[i][2]);
   
   
   //Normalise displacements for printing
   nu_x[i] /=1.34537742E-03;
   nu_y[i] /=1.34537742E-03;
   nu_z[i] /=1.34537742E-03;


   printf("%6s %10.2lf %10.2lf %10.2lf\t%10.6lf %10.6lf %10.6lf %10.6lf\n", Atoms0[i].name, nu_x[i], nu_y[i], nu_z[i], P[i][0], P[i][1], P[i][2], P_ );
   }
printf("%6s %10s %10s %10.s\t%10.6lf %10.6lf %10.6lf %10s\n", "Total", "", "", "", Px, Py, Pz, "" );

printf("Oscillator strength:\n");
printf("%10lf %10lf %10lf\n", Px*Px, Px*Py, Px*Pz);
printf("%10lf %10lf %10lf\n", Py*Px, Py*Py, Py*Pz);
printf("%10lf %10lf %10lf\n", Pz*Px, Pz*Py, Pz*Pz);

printf("Here are the polarisation contributions to y sorted by magnitude\n")



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







struct mode* ModeSort(struct mode *SoftMode, struct atom *Atoms , int natom){

struct mode temp;
N=0;
swp=1;


