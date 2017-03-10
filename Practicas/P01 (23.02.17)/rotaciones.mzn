%parametros
int: n = 6;
array [1..n] of int: t = [4, 6, 8, 9, 1, 2];

%variables de decision
array [1..n] of var int: s; %rotaciones de t
var 0..n-1: d; %desplazamiento

%constraint
constraint forall (i in 1..n)(t[i] == s[(i+d) mod n+1]);

%resolver
solve satisfy;