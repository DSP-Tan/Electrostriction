FILE *safe_open	( const char *filename , const char *mode );
char *SkipTo( FILE *fptr , const char *command , char cmdline[] );

struct atom{
char   name[10];
double xs, ys, zs;
double x,  y,  z;
double dx, dy, dz;
double nu_x, nu_y, nu_z;
double Z[3][3];
};

struct mode{
int    N;
double Z[3];       // mode effective charge in each direction
double ZZ;         // modulus of mode effective charge
double w;
double w_Ha;
double eig[26][3];   //26 is the number of atoms in LaMoX - this is a bad way to do this
double Sx;  double Sy;  double Sz;
double Sxy; double Sxz; double Syz;
double S;
double epsZZ; //Contribution to Z permitivity
double epsYY; //Contribution to Y permitivity
double epsXX; //Contribution to X permitivity
};

int GetBornEffectiveCharges(   char *filename, struct atom *Atoms, int natom, int print );
int GetEnergiesAndFrequencies( char *filename, struct mode *Modes, int natom, int print );
int GetEigenDisplacements(     char *filename, struct mode *Modes, int natom, int print );
int GetModeEffectiveCharges(   char *filename, struct mode *Modes, int natom, int print );
int GetOscillatorStrengths(    char *filename, struct mode *Modes, int natom, int print );
