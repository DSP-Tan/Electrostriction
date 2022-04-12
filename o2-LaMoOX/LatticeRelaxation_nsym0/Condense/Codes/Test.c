#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "funcs.h"

struct mode* GetEnergiesAndFrequencies(struct mode *Modes,  int natom);

int main(){

int i,j, k, N;
int natom, Nmodes;
FILE *fptr;
char line[200], string[80], C;
double D;
double epsExx;
double vol;


//Get number of atoms and number of modes for later reading.
natom=0;
fptr=safe_open("abi.in","r");
SkipTo(fptr,"natom",line); sscanf(line,"%s %d", string, &natom);

if(natom==0){
   printf("you have read that natom is 0, check to see that natom is at line beginning in abi.in. Exiting\n\n");
   exit( 1 ) ;
   }
fclose(fptr);

Nmodes=natom*3;                         //This is number of modes including acoustic.
struct mode Modes[Nmodes];
for(i=0;i<Nmodes;i++) Modes[i].N=i+1;

GetEnergiesAndFrequencies( Modes, natom );

return 0;
}



struct mode* GetEnergiesAndFrequencies(struct mode *Modes, int natom ){
int i,j;
FILE *fptr;
int nlines,extra, N;
char C, line[200];
N=natom*3;

nlines=N/5;
extra= N%5;

for(i=0;i<N;i++) Modes[i].N=i+1;
getchar();
printf("fart\n");

fptr=safe_open("anaddb.out","r");

getchar();
printf("file open\n");

// Get phonon energies in Hartree
SkipTo(fptr," Phonon energies in Hartree :", line);
j=0;
for(i=0;i<nlines;i++){
   fgets(line, 200, fptr);
   sscanf(line,"%lf %lf %lf %lf %lf", &Modes[0+j].w_Ha, &Modes[1+j].w_Ha, &Modes[2+j].w_Ha, &Modes[3+j].w_Ha, &Modes[4+j].w_Ha );
   j+=5;
   }
if(extra==1){
   fgets(line, 200, fptr); sscanf(line,"%lf", &Modes[0+j].w_Ha); }
else if(extra==2){
   fgets(line, 200, fptr); sscanf(line,"%lf %lf", &Modes[0+j].w_Ha , &Modes[1+j].w_Ha); }
else if(extra==3){
   fgets(line, 200, fptr); sscanf(line,"%lf %lf %lf", &Modes[0+j].w_Ha, &Modes[1+j].w_Ha, &Modes[2+j].w_Ha); }
else if(extra==4){
   fgets(line, 200, fptr); sscanf(line,"%lf %lf %lf %lf", &Modes[0+j].w_Ha, &Modes[1+j].w_Ha, &Modes[2+j].w_Ha, &Modes[3+j]); }

printf("Phons in Ha\n%lf %lf %lf %lf %lf %lf\n", Modes[0].w_Ha, Modes[1].w_Ha, Modes[2].w_Ha, Modes[3].w_Ha, Modes[4].w_Ha, Modes[5].w_Ha );


SkipTo(fptr," Phonon frequencies in cm-1", line );
j=0;
for(i=0;i<nlines;i++){
   fgets(line, 200, fptr);
   sscanf(line,"%c %lf %lf %lf %lf %lf",&C, &Modes[0+j].w, &Modes[1+j].w, &Modes[2+j].w, &Modes[3+j].w, &Modes[4+j].w);
   j+=5;
   }
if(extra==1){
   fgets(line, 200, fptr); sscanf(line,"%c %lf",&C, &Modes[0+j].w); }
else if(extra==2){
   fgets(line, 200, fptr); sscanf(line,"%c %lf %lf",&C, &Modes[0+j].w , &Modes[1+j].w); }
else if(extra==3){
   fgets(line, 200, fptr); sscanf(line,"%c %lf %lf %lf",&C, &Modes[0+j].w, &Modes[1+j].w, &Modes[2+j].w); }
else if(extra==4){
   fgets(line, 200, fptr); sscanf(line,"%c %lf %lf %lf %lf",&C, &Modes[0+j].w, &Modes[1+j].w, &Modes[2+j].w, &Modes[3+j]);
   }

printf("Phons in cm\n%lf %lf %lf %lf %lf %lf\n", Modes[0].w, Modes[1].w, Modes[2].w, Modes[3].w, Modes[4].w, Modes[5].w );

rewind(fptr);
fclose(fptr);

}

