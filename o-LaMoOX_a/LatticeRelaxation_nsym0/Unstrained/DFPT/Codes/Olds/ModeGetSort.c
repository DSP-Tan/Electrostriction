#include <stdio.h>
#include "funcs.h"
#include <math.h>

struct mode* ModeSort(struct mode *Modes, int size);

int main(){
int i,j, k, N;
FILE *fptr;
char line[200], string[10], C;
struct mode Modes[15];
double D;

int natom=26;
fptr=safe_open( "anaddb.out", "r" );


SkipTo(fptr," Phonon frequencies in cm-1", line ); 

for(i=0;i<natom*3;i++) Modes[i].N=i+1;


// This hard codes the number of lines of phonon frequencies to 3

j=0;
for(i=0;i<3;i++){
   fgets(line, 200, fptr);
   sscanf(line,"%c %lf %lf %lf %lf %lf",&C, &Modes[0+j].w, &Modes[1+j].w, &Modes[2+j].w, &Modes[3+j].w, &Modes[4+j].w);
   //printf("%c %lf %lf %lf %lf %lf\n",C, Modes[0+j].w, Modes[1+j].w, Modes[2+j].w, Modes[3+j].w, Modes[4+j].w);
   j+=5;
   }


SkipTo(fptr," Eigendisplacements", line ); 

for(i=0;i<15;i++){
   SkipTo(fptr,"  Mode number",line);
   //printf("%s",line);
   if(i<3)
      for(j=0;j<2;j++)
         fgets(line, 200, fptr);
   for(k=0;k<5;k++){
      fgets(line,200,fptr);
      sscanf(line, "%c %d %lf %lf %lf", &C, &N, &Modes[i].eig[k][0], &Modes[i].eig[k][1], &Modes[i].eig[k][2]);
      //printf("%c %d %lf %lf %lf\n", C, N, Modes[i].eig[k][0], Modes[i].eig[k][1], Modes[i].eig[k][2]);
      fgets(line,200,fptr);
      }
   }

SkipTo(fptr," Mode effective charges", line ); 
fgets(line, 200, fptr);
//printf("%s",line);

for(i=0;i<15;i++){
   fgets(line,200,fptr);
   sscanf( line,"%c %d %lf %lf %lf %lf",&C, &N, &Modes[i].Z[0], &Modes[i].Z[1], &Modes[i].Z[2], &Modes[i].ZZ );
   //printf( "%c %d %lf %lf %lf %lf\n",C, N, Modes[i].Z[0], Modes[i].Z[1], Modes[i].Z[2], Modes[i].ZZ );
   }


SkipTo(fptr," Oscillator strengths", line ); 
fgets(line,200,fptr);
//printf("%s",line);
for(i=0;i<15;i++){
   fgets(line,200,fptr);
   sscanf(line,"%c %d %s %lf %lf %lf %lf %lf %lf %lf", &C, &N, string, &Modes[i].Sx, &Modes[i].Sy, &Modes[i].Sz, &Modes[i].Sxy, &Modes[i].Sxz, &Modes[i].Syz, &Modes[i].S);
   //printf("%c %d %c %lf %lf %lf %lf %lf %lf %lf\n", C, N, string[0], Modes[i].Sx, Modes[i].Sy, Modes[i].Sz, Modes[i].Sxy, Modes[i].Sxz, Modes[i].Syz, Modes[i].S);
   fgets(line,200,fptr);
   }

for(i=0;i<15;i++) Modes[i].epsZZ = Modes[i].epsXX = Modes[i].epsYY=0.0;

SkipTo(fptr," Mode by mode decomposition",line);
for(i=0;i<12;i++){
   SkipTo(fptr," Mode number",line);
   sscanf(line, "%s %s %d", string, string, &N);
   fgets(line,200,fptr);
   sscanf(line,"%lf %lf %lf", &Modes[N-1].epsXX,&D,   &D );
   fgets(line,200,fptr);
   sscanf(line,"%lf %lf %lf", &D, &Modes[N-1].epsYY,  &D );
   fgets(line,200,fptr);
   sscanf(line,"%lf %lf %lf", &D, &D, &Modes[N-1].epsZZ);
   }

fclose(fptr);

printf("%3s %7s %7s %7s %7s %9s\n", "N","w(cm-1)", "Zx", "Zy", "Zz", "EpsZCont");
for(i=0;i<15;i++)
   printf("%3d %7.2lf %7.2lf %7.2lf %7.2lf %9.3lf\n", Modes[i].N, Modes[i].w, Modes[i].Z[0], Modes[i].Z[1], Modes[i].Z[2],Modes[i].epsZZ);


/*----------------------------------------------------------------------
 * --------------------- Z modes ---------------------------------------
 * -------------------------------------------------------------------*/

// Find number of modes with nonzero polarity in Z direction; declare array to contain them; and then assign them.
for(i=0,j=0;i<15;i++) if( fabs(Modes[i].Z[2]) > 0.01 ) j++;
struct mode ZModes[j];

for(i=0,j=0;i<15;i++)
   if( fabs(Modes[i].Z[2]) > 0.01 )
      ZModes[j++]=Modes[i];

// Sort and print the Z-polar modes.
printf("\n\n");
printf("%3s %7s %7s %7s %7s %9s\n", "N","w(cm-1)", "Zx", "Zy", "Zz", "EpsZCont");
ModeSort( ZModes, j);
for(i=0;i<j;i++)
   printf("%3d %7.2lf %7.2lf %7.2lf %7.2lf %9.3lf\n", ZModes[i].N, ZModes[i].w, ZModes[i].Z[0], ZModes[i].Z[1], ZModes[i].Z[2], ZModes[i].epsZZ);

fptr=safe_open("ModContToEpsZ.txt","w");
fprintf(fptr,"%3s %7s %7s %7s %7s %9s\n", "N","w(cm-1)", "Zx", "Zy", "Zz", "EpsZCont");
for(i=0;i<j;i++)
   fprintf(fptr,"%3d %7.2lf %7.2lf %7.2lf %7.2lf %9.3lf\n", ZModes[i].N, ZModes[i].w, ZModes[i].Z[0], ZModes[i].Z[1], ZModes[i].Z[2], ZModes[i].epsZZ);
fclose(fptr);

/*----------------------------------------------------------------------
 * --------------------- X modes ---------------------------------------
 * -------------------------------------------------------------------*/

// Find number of modes with nonzero polarity in X direction; declare array to contain them; and then assign them.
j=0;
for(i=0,j=0;i<15;i++) if( fabs(Modes[i].Z[0]) > 0.01 ) j++;
struct mode XModes[j];

for(i=0,j=0;i<15;i++)
   if( fabs(Modes[i].Z[0]) > 0.01 )
      XModes[j++]=Modes[i];

// Sort and print the X-polar modes.
printf("\n\n");
printf("%3s %7s %7s %7s %7s %9s\n", "N","w(cm-1)", "Zx", "Zy", "Zz", "EpsXCont");
ModeSort( XModes, j);
for(i=0;i<j;i++)
   printf("%3d %7.2lf %7.2lf %7.2lf %7.2lf %9.3lf\n", XModes[i].N, XModes[i].w, XModes[i].Z[0], XModes[i].Z[1], XModes[i].Z[2], XModes[i].epsXX);

fptr=safe_open("ModContToEpsX.txt","w");
fprintf(fptr,"%3s %7s %7s %7s %7s %9s\n", "N","w(cm-1)", "Zx", "Zy", "Zz", "EpsXCont");
for(i=0;i<j;i++)
   fprintf(fptr,"%3d %7.2lf %7.2lf %7.2lf %7.2lf %9.3lf\n", XModes[i].N, XModes[i].w, XModes[i].Z[0], XModes[i].Z[1], XModes[i].Z[2], XModes[i].epsXX);


/*----------------------------------------------------------------------
 * --------------------- Y modes ---------------------------------------
 * -------------------------------------------------------------------*/

// Find number of modes with nonzero polarity in Z direction; declare array to contain them; and then assign them.
j=0;
for(i=0,j=0;i<15;i++) if( fabs(Modes[i].Z[1]) > 0.01 ) j++;
struct mode YModes[j];

for(i=0,j=0;i<15;i++)
   if( fabs(Modes[i].Z[1]) > 0.01 )
      YModes[j++]=Modes[i];

// Sort and print the X-polar modes.
printf("\n\n");
printf("%3s %7s %7s %7s %7s %9s\n", "N","w(cm-1)", "Zx", "Zy", "Zz", "EpsYCont");
ModeSort( YModes, j);
for(i=0;i<j;i++)
   printf("%3d %7.2lf %7.2lf %7.2lf %7.2lf %9.3lf\n", YModes[i].N, YModes[i].w, YModes[i].Z[0], YModes[i].Z[1], YModes[i].Z[2], YModes[i].epsYY);

fptr=safe_open("ModContToEpsY.txt","w");
fprintf(fptr,"%3s %7s %7s %7s %7s %9s\n", "N","w(cm-1)", "Zx", "Zy", "Zz", "EpsYCont");
for(i=0;i<j;i++)
   fprintf(fptr,"%3d %7.2lf %7.2lf %7.2lf %7.2lf %9.3lf\n", YModes[i].N, YModes[i].w, YModes[i].Z[0], YModes[i].Z[1], YModes[i].Z[2], YModes[i].epsYY);
fclose(fptr);

return 0;
}




struct mode* ModeSort(struct mode *Modes, int size){
int i, swp, N;
struct mode temp;
N=0;
swp=1;
while(swp !=0 && N<100 ){
   for(i=0,swp=0;i<size-1;i++)
      if( Modes[i+1].w < Modes[i].w ){
         temp=Modes[i];
         Modes[i]=Modes[i+1];
	 Modes[i+1]=temp;
	 swp++;
         }
   N++;
   }

}
