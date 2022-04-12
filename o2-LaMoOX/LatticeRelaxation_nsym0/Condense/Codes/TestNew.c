#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "funcs.h"


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

GetEnergiesAndFrequencies( Modes, natom, 1 );

return 0;
}




