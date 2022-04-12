#include <stdio.h>
#include <malloc.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>
#include "funcs.h"

int atomsort( int n, struct atom *ptr ){
	int status, i;
	struct atom a;
	status = 0;
	
	for( i=0; i< (n-1);i++ ){
	   if ( ptr[i].id > ptr[i+1].id ){
		  status++;
		  a = ptr[i];
	      ptr[i] = ptr[i+1];
	      ptr[i+1] = a;
	      }
    }
    
	if( status == 0 )
	   return status;
	else
	   atomsort( n, ptr );
	
	return status;
}


int anglesort( int n, struct angle *ptr ){
   int status, i;
   struct angle a;
   status = 0;
   for( i=0; i< (n-1);i++ ){
      if ( ptr[i].type > ptr[i+1].type ){
         status++;
         a = ptr[i];
         ptr[i] = ptr[i+1];
         ptr[i+1] = a;
	     }
    }
    
	if( status == 0 )
	   return status;
	else
	   anglesort( n, ptr );
	
	return status;
}

double Distance ( double x1, double y1, double z1, double x2, double y2, double z2 ) //Function to calculate distances between two different atoms
{
return sqrt( (x1-x2)*(x1-x2) + (y1-y2)*(y1-y2) + (z1-z2)*(z1-z2) );
}




FILE *safe_open( const char *filename , const char *mode)
{
	/*This function is more or less just fopen with some added safety features
	* the mode here is the same mode in fopen, where r is for read, w is for write,
	* rb is for read binary, wb is for write binary. The arguments work the exact same
	* as fopen. */
	
	FILE *fptr;
	
	if( ( fptr = fopen ( filename, mode) ) == NULL )        
		{
		puts ( "Cannot open input file " );
		puts ( filename ) ;
		exit( 1 );
		}
return fptr;
}


//This function reads in the piece of text you want to find, takes a pointer to
//the file point which by incrementing you search a given file, and also takes
//a character array in which it stores the currently searched line. If successful,
//the pointer passed in will be incrememented one past the line in which "command"
//was found, "cmdline[]" will contain the line in which "command" was found, and
//the return value is the return of fgets.

//If unsucessful the return value will be what fgets returns when it's at the end
//of a file or failed to get a line. See fgets documentation. The pointer will
//be at the end of the file, and cmdline may contain the final line of the file
//or else just nonsense.
char *SkipTo( FILE *fptr , const char *command , char cmdline[] )
{
/* The char array cmdline[] contains the last string read in by the function, which should be the string which
 * starts with the letters of "command" */		
int i,size,yes;
char *a;
size = (int) ( strlen(command) );

while( (a = fgets ( cmdline,200, fptr ) ) != NULL )
	{
	yes =0;
	for (i=0; i < size ;i++)
		if ( cmdline[i] == command[i] )
			yes++;
	if ( yes == size )
		break;
	}
	
return a;	
}

