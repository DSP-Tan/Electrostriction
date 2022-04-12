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
double a0;                           //Unrelaxed cubic lattice constant.

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
//printf("xred\n");
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

// Look at relaxation
double dx[natom], dy[natom], dz[natom];
for(i=0;i<natom;i++){
   dx[i]=Atoms[i].x -Atoms0[i].x;
   dy[i]=Atoms[i].y -Atoms0[i].y;
   dz[i]=Atoms[i].z -Atoms0[i].z;
   }
   
//----------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------
/*-------------------------------------------------------------*/
/*----------------Get DFPT properties    ----------------------*/
/*-------------------------------------------------------------*/



Nmodes=natom*3;              //This is number of modes including acoustic.
struct mode Modes[Nmodes];
for(i=0;i<Nmodes;i++) Modes[i].N=i+1;

// Get Volume
fptr=safe_open( anaddb , "r" );
SkipTo(fptr, " Unit cell volume ucvol=", line);
sscanf(line, "%s %s %s %s %lf %s", string,string, string, string,  &vol0, string);
fclose(fptr);


GetBornEffectiveCharges(    anaddb, Atoms, natom, 1);
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


printf("%6s %10s %10s %10s\t%10s %10s %10s %10s\n","at", "dx", "dy", "dz",  "dPx", "dPy", "dPz", "|P|");
for(i=0;i<natom;i++){
   nu_x[i] = Modes[3].eig[i][0];
   nu_y[i] = Modes[3].eig[i][1];
   nu_z[i] = Modes[3].eig[i][2];

   Px += P[i][0]= Atoms[i].Z[0][0]*nu_x[i] + Atoms[i].Z[1][0]*nu_y[i] + Atoms[i].Z[2][0]*nu_z[i];
   Py += P[i][1]= Atoms[i].Z[0][1]*nu_x[i] + Atoms[i].Z[1][1]*nu_y[i] + Atoms[i].Z[2][1]*nu_z[i];
   Pz += P[i][2]= Atoms[i].Z[0][2]*nu_x[i] + Atoms[i].Z[1][2]*nu_y[i] + Atoms[i].Z[2][2]*nu_z[i];
   
   P_= sqrt(P[i][0]*P[i][0] + P[i][1]*P[i][1] + P[i][2]*P[i][2]);
   
   
   //Normalise displacements for printing
   nu_x[i] /=1.34537742E-03;
   nu_y[i] /=1.34537742E-03;
   nu_z[i] /=1.34537742E-03;

   Atoms[i].nu_x = nu_x[i];
   Atoms[i].nu_y = nu_y[i];
   Atoms[i].nu_z = nu_z[i];

   printf("%6s %10.2lf %10.2lf %10.2lf\t%10.6lf %10.6lf %10.6lf %10.6lf\n", Atoms[i].name, nu_x[i], nu_y[i], nu_z[i], P[i][0], P[i][1], P[i][2], P_ );
   }
printf("%6s %10s %10s %10.s\t%10.6lf %10.6lf %10.6lf %10s\n", "Total", "", "", "", Px, Py, Pz, "" );

printf("Oscillator strength:\n");
printf("%10lf %10lf %10lf\n", Px*Px, Px*Py, Px*Pz);
printf("%10lf %10lf %10lf\n", Py*Px, Py*Py, Py*Pz);
printf("%10lf %10lf %10lf\n", Pz*Px, Pz*Py, Pz*Pz);

printf("Here are the polarisation contributions to y sorted by magnitude\n");
struct atom Sortoms[natom];
double Pol_sort[natom][3];
for(i=0;i<natom;i++)
   for(j=0;j<3;j++)
      Pol_sort[i][j]=P[i][j];

struct atom tempAt;
double Pol_temp[3];

int swp=1;
int count;
while(swp){
   count=0;
   for(i=0;i<natom-1;i++){
      if( fabs(P[i][1]) < fabs(P[i+1][1]) ){
	     for(j=0;j<3;j++){ 
             Pol_temp[j]=P[i][j];
			 P[i][j]=P[i+1][j];
			 P[i+1][j]=Pol_temp[j];
			 }
	  tempAt=Atoms[i];
	  Atoms[i]=Atoms[i+1];
	  Atoms[i+1]=tempAt;
	  count++;
	  }	   
   }
   swp=count;
}      

printf("%6s %10s %10s %10s\t%10s %10s %10s %10s\n","at", "dx", "dy", "dz",  "dPx", "dPy", "dPz", "|P|");
for(i=0;i<natom;i++)
   printf("%6s %10.2lf %10.2lf %10.2lf\t%10.6lf %10.6lf %10.6lf %10.6lf\n", Atoms[i].name, Atoms[i].nu_x, Atoms[i].nu_y, Atoms[i].nu_z, P[i][0], P[i][1], P[i][2], sqrt(P[i][0]*P[i][0] + P[i][1]*P[i][1] + P[i][2]*P[i][2]) );




printf("Sorted by magnitude of eigendisp\n");
 
double Mod1, Mod2;
swp=1;
while(swp){
   count=0;
   for(i=0;i<natom-1;i++){
      Mod1=sqrt(Atoms[i].nu_x*Atoms[i].nu_x + Atoms[i].nu_y*Atoms[i].nu_y + Atoms[i].nu_z*Atoms[i].nu_z);
      Mod2=sqrt(Atoms[i+1].nu_x*Atoms[i+1].nu_x + Atoms[i+1].nu_y*Atoms[i+1].nu_y + Atoms[i+1].nu_z*Atoms[i+1].nu_z);
      if( Mod1 < Mod2 ){
	  tempAt=Atoms[i];
	  Atoms[i]=Atoms[i+1];
	  Atoms[i+1]=tempAt;
	  count++;
	  }	   
   }
   swp=count;
}      

printf("%6s %10s %10s %10s\t%10s %10s %10s %10s\n","at", "dx", "dy", "dz",  "dPx", "dPy", "dPz", "|P|");
for(i=0;i<natom;i++)
   printf("%6s %10.2lf %10.2lf %10.2lf\t%10.6lf %10.6lf %10.6lf %10.6lf\n", Atoms[i].name, Atoms[i].nu_x, Atoms[i].nu_y, Atoms[i].nu_z, P[i][0], P[i][1], P[i][2], sqrt(P[i][0]*P[i][0] + P[i][1]*P[i][1] + P[i][2]*P[i][2]) );
















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






