#include <stdio.h>
#include <gsl/gsl_linalg.h>
    
int main (void)
{
double eps[9]; 
double D, sigX;
FILE *fptr, *fout;
char line[200];

double a_data[] = { 1.0, 0.6, 0.0, 0.0, 1.5, 1.0, 0.0, 1.0, 1.0 };
double inva[9];
int s, i, j,k;

fout=fopen("StressRigid.txt","w");
fptr=fopen("StressPerm.txt","r");
fgets(line, 200, fptr);
puts(line);

fprintf(fout, "%-10s %10s %10s %10s %10s %10s %10s %10s %10s %10s %10s\n", "Sig (GPa)", "SigX", "etaX", "etaXY", "etaXZ", "etaYX", "etaY", "etaYZ","etaZX", "etaZY", "etaZ");

while( fscanf( fptr, "%lf %lf %lf %lf %lf %lf %lf %lf %lf %lf %lf", &D, &sigX, &eps[0], &eps[1], &eps[2], &eps[3], &eps[4], &eps[5], &eps[6], &eps[7], &eps[8]) == 11 ){
   //printf("%10lf %10lf %10lf %10lf %10lf %10lf %10lf %10lf %10lf %10lf %10lf\n", D, sigX, eps[0], eps[1], eps[2], eps[3], eps[4], eps[5], eps[6], eps[7], eps[8]);

   for(i=0;i<9;i++)
      a_data[i]=eps[i];
   
   
   gsl_matrix_view m
        = gsl_matrix_view_array(a_data, 3, 3);
   gsl_matrix_view inv
        = gsl_matrix_view_array(inva,3,3);
   gsl_permutation * p = gsl_permutation_alloc (3);

   printf("The matrix is\n");
   for (i = 0; i < 3; ++i)
       for (j = 0; j < 3; ++j)
           printf(j==2?"%6.3f\n":"%6.3f ", gsl_matrix_get(&m.matrix,i,j));

   gsl_linalg_LU_decomp (&m.matrix, p, &s);    
   gsl_linalg_LU_invert (&m.matrix, p, &inv.matrix);

   printf("The inverse is\n");
   for (i = 0; i < 3; ++i)
       for (j = 0; j < 3; ++j)
           printf(j==2?"%6.3f\n":"%6.3f ",gsl_matrix_get(&inv.matrix,i,j));

   fprintf(fout,"%-10.1lf %10lf %10lf %10lf %10lf %10lf %10lf %10lf %10lf %10lf %10lf\n", D, sigX, inva[0], inva[1], inva[2], inva[3], inva[4], inva[5], inva[6], inva[7], inva[8]);



   gsl_permutation_free (p);   
   

   }

fclose(fptr);
fclose(fout);
//fscanf(FILE *stream, const char *format, ...)









return 0;
}
