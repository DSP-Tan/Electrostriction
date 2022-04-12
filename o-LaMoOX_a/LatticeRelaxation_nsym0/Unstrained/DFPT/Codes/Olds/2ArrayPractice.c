#include <stdio.h>
#include <stdlib.h>

void Pass(double **s, int row, int col, int natom){
int i, j, k;
for(k=0; k<natom; k++){
   
   printf("atom %d\n\n",k+1);
   for(i=0; i<row; i++) {
      for(j=0; j<col; j++)
         printf("%lf ", *(*s + j + i*col)  );
      printf("\n");
      }
   printf("\n\n");
   s++;
   }
}

int main(void){

int i, j,k;	
int natom=26, row=3, col=3;
double **m, **c;
m=(double**)malloc(sizeof(double*)*natom); //pointer to array of matrices

c=m;
for(i=0;i<natom;i++)
   *c++=(double*)malloc(sizeof(double)*col*row);  //pointer to matrices

c=m;
for(k=0;k<natom;k++,c++)
   for(i=0; i<row; i++)
      for(j=0; j<col; j++)
         *(*c+j+i*col)= 0+j+i*col;
      
getchar();

//Let's print the second matrix
c=m+1;
for(i=0; i<row; i++)
      for(j=0; j<col; j++){
         printf("%lf ",*(*c+j+i*col));
	 if(j==col-1)
	    printf("\n");
      }

Pass(m,row,col,natom);

for (i=0; i<row; i++) 
    free(m[i]);
//free(c);


return 0;
}
