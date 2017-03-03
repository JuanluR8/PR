%	OBJECT		PROFIT 		SIZE
%	whikey		29			8
%	perfume		19			5
%	cigarettes	8			3
%
%Tenemos una mochila con capacidad 18, queremos maximizar la ganancia al hacer contrabando.

%parametros
int: n = 3;
array[1..n] of int: profit = [29, 19, 8];
array[1..n] of int: size = [8, 5, 3];
par int: capacidad = 18;

%variables
var int: pesoAct = 0;
array[1..n] of var 0..100: maletin;
%var 1..n: i;

%constraints
constraint sum([size[i]*maletin[i] | i in 1..n ]) <= capacidad;
solve maximize sum([profit[i]*maletin[i] | i in 1..n]);

output[show(maletin)];