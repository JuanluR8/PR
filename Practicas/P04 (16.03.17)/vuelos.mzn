% Carlos Piña Martinez, Juan Luis Romero Sanchez
int: n;
int: ini;
int: fin;
int: max;
array [1..n, 1..n] of int: t;
array [0..n, 0..n] of var int: t2;

var int: coste;
array [1..max] of var 0..n: viaje;
var 2..max: posfin;

constraint forall(i in 1..n, j in 1..n)(t2[i,j] = t[i,j]);
constraint forall(i in 0..n)(t2[0,i]=0 /\ t2[i,0]=0);

constraint viaje[1] = ini;
constraint viaje[posfin] = fin; 
constraint forall (i in 1..max-1) ( t2[ viaje[i], viaje[i+1] ] != -1 );
constraint forall (i in 1..max-1) ( i<=posfin -> viaje[i] != viaje[i+1] );
constraint forall(i in 1..max) ( i>posfin <-> viaje[i]=0); 
constraint coste = sum (i in 1..max-1) ( t2[ viaje[i], viaje [i+1] ] );

%averiguar el modo mas barato de viajar de ini a fin
solve minimize coste;

%averiguar el modo mas corto de viajar (lista de ciudades)
%solve minimize posfin;            
