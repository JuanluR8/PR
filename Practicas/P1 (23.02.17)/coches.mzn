include "alldifferent.mzn";

%parametros
par int: n=10;

%variables
array [1..n] of var 1..n: coche;

%restricciones
constraint alldifferent(coche);
constraint coche[3] = coche[4] - 1 /\ coche[5]= coche [4] + 1;
constraint coche[10] = 1;
constraint coche[6] != 10;
constraint coche[7] > coche[6] /\ coche[7] > coche[5] /\ coche[7] > coche[8];
constraint coche [8] != coche [9]+1 /\ coche [8] != coche [9]-1;


%resolver
solve satisfy; 
