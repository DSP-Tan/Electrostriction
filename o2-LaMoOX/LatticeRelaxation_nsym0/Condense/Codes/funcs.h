FILE *safe_open	( const char *filename , const char *mode );
char *SkipTo( FILE *fptr , const char *command , char cmdline[] );

struct mode{
int    N;
double Z[3];
double ZZ;
double w;
double w_Ha;
double eig[80][3];
double Sx;  double Sy;  double Sz;
double Sxy; double Sxz; double Syz;
double S;
double epsZZ; //Contribution to Z permitivity
double epsYY; //Contribution to Y permitivity
double epsXX; //Contribution to X permitivity
};

int GetEnergiesAndFrequencies( char *filename, struct mode *Modes, int natom, int print );
int GetEigenDisplacements( char *filename, struct mode *Modes, int natom, int print );
int GetEffectiveCharges(char *filename, struct mode *Modes, int natom, int print);
int GetOscillatorStrengths( char *filename, struct mode *Modes, int natom, int print);
