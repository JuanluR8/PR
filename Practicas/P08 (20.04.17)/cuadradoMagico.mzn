%Carlos Piña, Juan Luis Romero

% Escribir un modelo MiniZinc para obtener cuadrados mágicos. Probar con valores
% n=4 y n=5.

include "alldifferent.mzn";

int: n=4;
int: magico = n*(n*n + 1)div 2;

array [1..n, 1..n] of var 1..n*n: cuadrado;

%la suma de los numeros de las columnas es igual a "magico"
constraint forall(i in 1..n)( 
                  sum(j in 1..n)( cuadrado[i,j] ) = magico );

%la suma de los numeros de las filas es igual a "magico"
constraint forall(i in 1..n)( 
                  sum(j in 1..n)( cuadrado[j,i] ) = magico );

%diagonal \
constraint sum(i in 1..n)(cuadrado[i,i]) = magico;

%diagonal /
constraint sum(i in 0..n-1)(cuadrado[i+1,n-i]) = magico; 

%todos los elementos del cuadrado son diferentes
constraint alldifferent( [cuadrado[i,j] | i,j in 1..n] );

solve satisfy;

output [
        show_int(3, cuadrado[i,j]) ++ " " ++ 
        if j == n then "\n" else "" endif |
        i in 1..n, j in 1..n
];