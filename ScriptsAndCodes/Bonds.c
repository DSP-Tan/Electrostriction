#include <stdio.h>
#include <math.h>
#include "funcs.h"
#include <stdlib.h>
#include <math.h>

int main (void)
{

double x[28],  y[28],  z[28];
double x_[28], y_[28], z_[28];
char *Name[28];
int type[28], i;
double a0=7.1547;
double a[3], b[3], c[3];

a[0]=a0; a[1]=a[2]=0.0;
b[0]=0.0;b[1]=a0; b[2]=0.0;
c[0]=c[1]=0; c[2]=a0;


Name[0]="La0"  ;     x[0]=0.8529;    y[0]=0.8529;    z[0]=0.8529;   type[0]=1;   
Name[1]="La1"  ;     x[1]=0.3529;    y[1]=0.6471;    z[1]=0.1471;   type[1]=1;
Name[2]="La2"  ;     x[2]=0.1471;    y[2]=0.3529;    z[2]=0.6471;   type[2]=1;
Name[3]="La3"  ;     x[3]=0.6471;    y[3]=0.1471;    z[3]=0.3529;   type[3]=1;
Name[4]="Mo4"  ;     x[4]=0.1695;    y[4]=0.1695;    z[4]=0.1695;   type[4]=2;
Name[5]="Mo5"  ;     x[5]=0.6695;    y[5]=0.3305;    z[5]=0.8305;   type[5]=2;
Name[6]="Mo6"  ;     x[6]=0.8305;    y[6]=0.6695;    z[6]=0.3305;   type[6]=2;
Name[7]="Mo7"  ;     x[7]=0.3305;    y[7]=0.8305;    z[7]=0.6695;   type[7]=2;
Name[8]="O1(1)";     x[8]=0.3164;    y[8]=0.3164;    z[8]=0.3164;   type[8]=3;
Name[9]="O1(2)";     x[9]=0.8164;    y[9]=0.1836;    z[9]=0.6836;   type[9]=3;
Name[10]="O1(3)";    x[10]=0.6836;   y[10]=0.8164;   z[10]=0.1836;  type[10]=3;
Name[11]="O1(4)";    x[11]=0.1836;   y[11]=0.6836;   z[11]=0.8164;  type[11]=3;
Name[12]="O2(1)";    x[12]=0.9929;   y[12]=0.182 ;   z[12]=0.336;   type[12]=4;
Name[13]="O2(2)";    x[13]=0.4929;   y[13]=0.318 ;   z[13]=0.664;   type[13]=4;  
Name[14]="O2(3)";    x[14]=0.007 ;   y[14]=0.682 ;   z[14]=0.1640;  type[14]=4;  
Name[15]="O2(4)";    x[15]=0.507 ;   y[15]=0.818 ;   z[15]=0.8360;  type[15]=4;   
Name[16]="O2(5)";    x[16]=0.336 ;   y[16]=0.9929;   z[16]=0.1820;  type[16]=4;   
Name[17]="O2(6)";    x[17]=0.164 ;   y[17]=0.0071;   z[17]=0.6820;  type[17]=4;   
Name[18]="O2(7)";    x[18]=0.836 ;   y[18]=0.5071;   z[18]=0.8180;  type[18]=4;   
Name[19]="O2(8)";    x[19]=0.664 ;   y[19]=0.4929;   z[19]=0.3180;  type[19]=4;   
Name[20]="O2(9)";    x[20]=0.182 ;   y[20]=0.3360;   z[20]=0.9929;  type[20]=4;    
Name[21]="O2(10)";   x[21]=0.818 ;   y[21]=0.8360;   z[21]=0.5071;  type[21]=4;   
Name[22]="O2(11)";   x[22]=0.318 ;   y[22]=0.6640;   z[22]=0.4929;  type[22]=4;   
Name[23]="O2(12)";   x[23]=0.682 ;   y[23]=0.1640;   z[23]=0.0071;  type[23]=4;    
Name[24]="O4(1)";    x[24]=0.025 ;   y[24]=0.025 ;   z[24]=0.025;   type[24]=5;    
Name[25]="O4(2)";    x[25]=0.525 ;   y[25]=0.475 ;   z[25]=0.975;   type[25]=5;    
Name[26]="O4(3)";    x[26]=0.975 ;   y[26]=0.525 ;   z[26]=0.475;   type[26]=5;   
Name[27]="O4(4)";    x[27]=0.475 ;   y[27]=0.975 ;   z[27]=0.525;   type[27]=5; 
                                                                          
struct atom Atoms[28];                                                    

for(i=0;i<28;i++){
   Atoms[i].id=i+1;
   Atoms[i].x=x[i]*a0;
   Atoms[i].y=y[i]*a0;
   Atoms[i].z=z[i]*a0;
   Atoms[i].type=type[i];
   printf("%10s %10f %10f %10f\n", Name[i],x[i],y[i],z[i]);
   }
   

//Find number of bonds
//All atoms within 3.053 A of each other
struct bond *LaMBonds;

LaMBonds=BondMaker(28, Atoms, a, b ,c, 3.5);

printf("%3s %8s %8s %4s %5s %5s %5s %2s %2s %2s\n", "id", "Name1", "Name2", "d", "dx", "dy","dz", "i1", "i2", "i3");

for(i=0;i<156;i++)
   printf("%3d %8s %8s %4.2lf %5.2lf %5.2lf %5.2lf %2d %2d %2d\n", LaMBonds[i].id,
   Name[LaMBonds[i].at1-1], Name[LaMBonds[i].at2-1], LaMBonds[i].d, LaMBonds[i].dx, LaMBonds[i].dy,
   LaMBonds[i].dz, LaMBonds[i].i1, LaMBonds[i].i2, LaMBonds[i].i3);


return 0;
}







struct bond* BondMaker( int natoms, struct atom *Atoms, double a[3], double b[3], double c[3], double cutoff ){
   int i,  j ;
   double x1, y1, z1, x2, y2, z2 ;
   double d, d_;
   int B_ID;
   int f1, f2, f3;
   struct bond *bondptr, *usrptr;
   
   bondptr= ( struct bond * ) malloc ( (natoms*4)*sizeof(struct bond) );
   usrptr = bondptr;
   
   B_ID = 0;
   for( i=0; i< natoms; i++ )
      for(j=i+1; j< natoms; j++ ){
      x1 = Atoms[i].x;
      y1 = Atoms[i].y;
      z1 = Atoms[i].z;
      
      x2 = Atoms[j].x;
      y2 = Atoms[j].y;
      z2 = Atoms[j].z;
      
      d = Distance( x1, y1, z1, x2, y2, z2 );
      
      if( d < cutoff ){
         usrptr->id = ++B_ID;
         
         if( ( Atoms[i].type ==1 && Atoms[j].type == 3)  ||  ( Atoms[i].type ==3 && Atoms[j].type == 1) ) // La-O1
            usrptr->type = 1;
         else if( (Atoms[i].type ==1 && Atoms[j].type == 2) || (Atoms[i].type ==2 && Atoms[j].type == 1) ) // Ge-X
            usrptr->type = 2;
         else
            usrptr->type = 3; // X-X
            
         usrptr->at1 = i+1;
         usrptr->at2 = j+1;
         usrptr->d  = d;
         usrptr->dx = x2 - x1; // distance from 1 to 2 in x
         usrptr->dy = y2 - y1; // distance from 1 to 2 in y
         usrptr->dz = z2 - z1; // distance from 1 to 2 in z
         usrptr->l  = usrptr->dx / d;
         usrptr->m  = usrptr->dy / d;
         usrptr->n  = usrptr->dz / d;
         usrptr->i1 = 0;
         usrptr->i2 = 0;
         usrptr->i3 = 0;
         usrptr++;
         } 
      else{
         for(f1=-1; f1<=1; f1++)
            for(f2=-1; f2<=1; f2++)
               for(f3=-1; f3<=1; f3++){
                  x2 = Atoms[j].x +f1*a[0] + f2*b[0] + f3*c[0];	 
                  y2 = Atoms[j].y +f1*a[1] + f2*b[1] + f3*c[1]; 
                  z2 = Atoms[j].z +f1*a[2] + f2*b[2] + f3*c[2];
                  d_= Distance(x1,y1,z1,x2,y2,z2);
                  if( d_ < cutoff ){ // You should really have 3 break conditions here to end these infernal loops.
                     usrptr->id = ++B_ID;
                     
                     if( Atoms[i].type ==1 && Atoms[j].type == 1) // Ge-Ge
                       usrptr->type = 1;
                     else if( (Atoms[i].type ==1 && Atoms[j].type == 2) || (Atoms[i].type ==2 && Atoms[j].type == 1) ) // Ge-X
                       usrptr->type = 2;
                     else
                       usrptr->type = 3; // X-X
                       
                     usrptr->at1 = i+1;
                     usrptr->at2 = j+1;
                     usrptr->d  = d_;
                     usrptr->dx = x2 - x1; // distance from 1 to 2 in x
                     usrptr->dy = y2 - y1; // distance from 1 to 2 in y
                     usrptr->dz = z2 - z1; // distance from 1 to 2 in z
                     usrptr->l  = usrptr->dx / d;
                     usrptr->m  = usrptr->dy / d;
                     usrptr->n  = usrptr->dz / d;
                     usrptr->i1 = f1;
                     usrptr->i2 = f2;
                     usrptr->i3 = f3;
                     usrptr++;
                     }
                  }  // end of loop over image flags
         
         } // end of if( d< cutoff) else -  condition  
      
         
         
   } // end of loop over all atom pairs

printf("There are %d bonds\n", B_ID);
   
return bondptr;
   
}














