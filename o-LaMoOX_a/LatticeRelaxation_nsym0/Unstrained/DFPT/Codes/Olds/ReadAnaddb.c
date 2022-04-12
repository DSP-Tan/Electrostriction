#include <stdio.h>
#include <malloc.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>
#include "funcs.h"


//To Do
//1. Return values should be whether it was able to find what it is "SkipTo"ing or not,
//   maybe combined with some built in checks also, like acoustic phons are 0, other values
//   have correct symmetries etc. etc.
//2. Get Energies and frequencies can be modified so that it takes in the word "Hartree" or "cm-&",
//   and then can read it depending on that. Have format1=%lf %lf %lf %lf; format2=%c %lf %lf.
//   You'd still need to write for each an individual list of variables to read into, so it's possible
//   the function would just need to have the repitition anyway. 

int GetBornEffectiveCharges( char *filename, struct atom *Atoms, int natom, int print){

int i,j,k,l;
FILE *fptr;
char line[200];

for(i=0;i<natom;i++)for(j=0;j<3;j++)for(k=0;k<3;k++)
   Atoms[i].Z[j][k]=0.0;


fptr=safe_open( filename , "r" );
SkipTo(fptr, " Effective charge tensors after", line);
fgets(line,200,fptr);
fgets(line,200,fptr);
fgets(line,200,fptr);

for(i=0;i<natom;i++){
   fgets(line,200,fptr); sscanf(line,"%d %d %lf %lf %lf", &l, &l, &Atoms[i].Z[0][0], &Atoms[i].Z[0][1], &Atoms[i].Z[0][2]);
   fgets(line,200,fptr); sscanf(line,"%d %d %lf %lf %lf", &l, &l, &Atoms[i].Z[1][0], &Atoms[i].Z[1][1], &Atoms[i].Z[1][2]);
   fgets(line,200,fptr); sscanf(line,"%d %d %lf %lf %lf", &l, &l, &Atoms[i].Z[2][0], &Atoms[i].Z[2][1], &Atoms[i].Z[2][2]);
   
   if(print==1){
      printf("%3d %3d %10.4lf %10.4lf %10.4lf\n",i+1, 1, Atoms[i].Z[0][0], Atoms[i].Z[0][1], Atoms[i].Z[0][2]);
      printf("%3d %3d %10.4lf %10.4lf %10.4lf\n",i+1, 2, Atoms[i].Z[1][0], Atoms[i].Z[1][1], Atoms[i].Z[1][2]);
      printf("%3d %3d %10.4lf %10.4lf %10.4lf\n",i+1, 3, Atoms[i].Z[2][0], Atoms[i].Z[2][1], Atoms[i].Z[2][2]);
      }
   }
fclose(fptr);

printf("Just before end of funct\n");
printf("%s", Atoms[0].name);

getchar();
return 0;

}


int GetEnergiesAndFrequencies( char *filename, struct mode *Modes, int natom, int print ){
   int i,j;
   FILE *fptr;
   int nlines,extra, N;
   char C, line[200];
   N=natom*3;
   
   nlines=N/5;
   extra= N%5;
   
   for(i=0;i<N;i++) Modes[i].N=i+1;
   
   fptr=safe_open(filename, "r");
   
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
      fgets(line, 200, fptr); sscanf(line,"%lf %lf %lf %lf", &Modes[0+j].w_Ha, &Modes[1+j].w_Ha, &Modes[2+j].w_Ha, &Modes[3+j].w_Ha); }
   
   if(print==1)
      printf("\nPhons in Ha\n%lf %lf %lf %lf %lf %lf\n", Modes[0].w_Ha, Modes[1].w_Ha, Modes[2].w_Ha, Modes[3].w_Ha, Modes[4].w_Ha, Modes[5].w_Ha );
   
   
   // Get phonon frequencies in cm-1
   
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
      fgets(line, 200, fptr); sscanf(line,"%c %lf %lf %lf %lf",&C, &Modes[0+j].w, &Modes[1+j].w, &Modes[2+j].w, &Modes[3+j].w);
      }
   
   if(print==1)
      printf("\nPhons in cm\n%lf %lf %lf %lf %lf %lf\n", Modes[0].w, Modes[1].w, Modes[2].w, Modes[3].w, Modes[4].w, Modes[5].w );
   
   fclose(fptr);
   return 0;

}




//Get Eigendisplacements
int GetEigenDisplacements( char *filename, struct mode *Modes, int natom, int print ){

   char C, line[200];
   FILE *fptr;
   int i, j, k, Nmodes, N;

   Nmodes=natom*3;
   
   fptr=safe_open( filename , "r" );
   SkipTo(fptr," Eigendisplacements", line );

   if(print==1) printf("\nEigendisplacements:\n");

   for(i=0;i<Nmodes;i++){
      SkipTo(fptr,"  Mode number",line);
      if(print==1) printf("%s",line);
      
      if(i<3)
         for(j=0;j<2;j++)
            fgets(line, 200, fptr);
      for(k=0;k<natom;k++){
         fgets(line,200,fptr);
         
         
         sscanf(line, "%c %d %lf %lf %lf", &C, &N, &Modes[i].eig[k][0], &Modes[i].eig[k][1], &Modes[i].eig[k][2]);
         if(print==1)
            printf("%2c %3d %10.5lf %10.5lf %10.5lf\n", C, N, Modes[i].eig[k][0], Modes[i].eig[k][1], Modes[i].eig[k][2]);
         fgets(line,200,fptr);
         }
      }

   fclose(fptr);
   return 0;
}


//Get Mode effective charges
int GetModeEffectiveCharges(char *filename, struct mode *Modes, int natom, int print){

FILE *fptr;
int i, Nmodes, N;
char C, line[200];

Nmodes=natom*3;

fptr=safe_open( filename , "r" );
SkipTo(fptr," Mode effective charges", line );
fgets(line, 200, fptr);

if(print==1)
   printf("\nEffective Charges\n");

for(i=0;i<Nmodes;i++){
   fgets(line,200,fptr);
   sscanf( line,"%c %d %lf %lf %lf %lf",&C, &N, &Modes[i].Z[0], &Modes[i].Z[1], &Modes[i].Z[2], &Modes[i].ZZ );
   if(print==1)
      printf( "%2c %3d %10.5lf %10.5lf %10.5lf %10.5lf\n",C, N, Modes[i].Z[0], Modes[i].Z[1], Modes[i].Z[2], Modes[i].ZZ );
   }

fclose(fptr);
return 0;

}



int GetOscillatorStrengths(char *filename, struct mode *Modes, int natom, int print){

FILE *fptr;
int i, Nmodes, N;
char C, line[200], string[100];
Nmodes=natom*3;

if(print==1)
   printf("\nOscillator Strengths\n");

fptr=safe_open( filename , "r" );
SkipTo(fptr," Oscillator strengths", line );
fgets(line,200,fptr);
//printf("%s",line);
for(i=0;i<Nmodes;i++){
   fgets(line,200,fptr);
   sscanf(line,"%c %d %s %lf %lf %lf %lf %lf %lf %lf", &C, &N, string, &Modes[i].Sx, &Modes[i].Sy, &Modes[i].Sz, &Modes[i].Sxy, &Modes[i].Sxz, &Modes[i].Syz, &Modes[i].S);
   if(print==1)
      printf("%c %d %c %lf %lf %lf %lf %lf %lf %lf\n", C, N, string[0], Modes[i].Sx, Modes[i].Sy, Modes[i].Sz, Modes[i].Sxy, Modes[i].Sxz, Modes[i].Syz, Modes[i].S);
   fgets(line,200,fptr);
   }
fclose(fptr);

return 0;
}


