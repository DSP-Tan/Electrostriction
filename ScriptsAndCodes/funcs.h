FILE *safe_open	( const char *filename , const char *mode );
double Distance (  double x1, double y1, double z1, double x2, double y2, double z2  );
char *SkipTo( FILE *fptr , const char *command , char cmdline[] );


struct atom{
char name[10];   // If efficiency was important, storing the name and the id would be not a good thing to do.
int type;
int id;
double x;
double y;
double z;
};

struct atomtype{
char name[10];
int type;
int present;
int count;
};

struct bond{
	int at1;  // atom Ids, not indices. 
	int at2;
	int type;
	int id;
	int i1;
	int i2;
	int i3;
	double d;
	double dx;
	double dy;
	double dz;
	double l;
	double m;
	double n;
};

struct bondtype{
int type;
int present;
int at1;
int at2;
int count;
double kr;
double r0;
};



struct angle{  // atom 2 is the central atom. //atom 3 is the atom of the remaining two with the higher type index.
int id;
double K2;		
double Theta0;
double M;
double N1;
double N2;
double r1;
double r2;
double r21[3];       //vector from central atom to atom 1
double r23[3];       //vector from central atom to atom 3
double d21;          //dist   from central atom to atom 1
double d23;          //dist   from central atom to atom 3
int type;
int at1;				//These integers are for if we want to completely reccord all the information for every threebody interaction in an
int at2;				//array of structs of this type.
int at3;
double theta;
};

struct angletype{
int type;
int present;
int count;
int at1;    // type of atom 1
int at2;    // type of atom 2
int at3;    // type of atom 3
double K2;		
double Theta0;
double M;
double N1;
double N2;
double r1;
double r2;
};


int atomsort( int n, struct atom *ptr );
int anglesort( int n, struct angle *ptr );
struct bond*  BondMaker(   int natoms, struct atom *Atoms, double a[3], double b[3], double c[3], double cutoff );
struct angle* AngleMaker( int nbonds, struct bond *Bonds, int *types );
double Distance ( double x1, double y1, double z1, double x2, double y2, double z2 ) ;

