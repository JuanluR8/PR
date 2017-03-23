%Carlos Piña Martínez, Juan Luis Romero Sánchez
int:n; % lado del cuadrado

array [1..n,1..n] of 1..9:h; % hitori
array [1..n,1..n] of var 0..9:t; % sol

% 1. Establece si las coordenadas i,j son válidas en el array t.
predicate inBounds(array[int,int] of var int:t, var int:i, var int: j) = 
                  ( i in index_set_1of2(t) /\ j in index_set_2of2(t) );

% 2. Asegura que la posición i,j no tiene ceros adyacentes.
%    a) Se puede asumir que i,j es una posición válida para t, pero hay que tener cuidado al comprobar
%       las posiciones adyacente y usar inBounds.
predicate nohayzeroalrededor(array[int,int] of var int:t, var int:i, var int:j) = 
                              ( inBounds(t,i-1,j) -> t[i-1,j]!=0 ) /\
                              ( inBounds(t,i+1,j) -> t[i+1,j]!=0 ) /\
                              ( inBounds(t,i,j-1) -> t[i,j-1]!=0 ) /\
                              ( inBounds(t,i,j+1) -> t[i,j+1]!=0 );

%3. Asegura que la posición i,j tiene adyacente un valor distinto de cero.
predicate haynozeroalrededor(array[int,int] of var int:t,var int:i, var int:j) =  
                              ( inBounds(t,i-1,j) /\ t[i-1,j] != 0 ) \/
                              ( inBounds(t,i+1,j) /\ t[i+1,j] != 0 ) \/
                              ( inBounds(t,i,j-1) /\ t[i,j-1] != 0 ) \/
                              ( inBounds(t,i,j+1) /\ t[i,j+1] != 0 );

%4. Asegura que para toda coordenada de t el valor correspondiente verifica que si es
%   distinto de cero coincide con el valor de h en la misma coordenada
predicate copiadeh(array[int,int] of var int:t) =
                   forall (i,j in 1..n)( ((t[i,j] != 0) -> (t[i,j] = h[i,j])) /\
                                         ((t[i,j] == 0) -> (t[i,j] = 0)) );

%5. Asegura que toda posición de t que contenga un cero no tiene ningún cero alrededor (usar el
%   predicado de 2)
predicate cerobien(array[int,int] of var int:t) = 
                    forall (i,j in 1..n)( (t[i,j] = 0) -> (nohayzeroalrededor(t,i,j) ) );

%6. Asegura que toda posición que contenga un valor distinto de cero
%   tenga otro valor distinto de cero alrededor (usar el predicado de 3)
predicate nocerobien(array[int,int] of var int:t) = 
                    forall (i,j in 1..n)( (t[i,j] != 0) -> haynozeroalrededor(t,i,j) );

%7. Asegura que para las filas de t tienen valores distintos excluyendo los valores a cero
predicate diferenteporfilas(array[int,int] of var int:t) = 
                           forall(j in 1..n) (forall(i in 1..n-1) 
                                              ((t[i,j] != 0)-> forall(k in i+1..n)
                                                                     (t[i,j] != t[k,j])) );

%8. Asegura que para las columnas de t tienen valores distintos excluyendo los valores a cero
predicate diferenteporcolumnas(array[int,int] of var int:t) = 
                           forall(i in 1..n)( forall(j in 1..n-1) 
                                              ((t[i,j] != 0)-> forall(k in j+1..n)
                                                                     (t[i,j] != t[i,k])));

%9 Escribir constraints llamando a los predicados 4,5,6,7,8 para resolver el problema
% constraint 
constraint copiadeh(t);
constraint cerobien(t);
constraint nocerobien(t);
constraint diferenteporfilas(t);
constraint diferenteporcolumnas(t);
solve satisfy;

%10. Escribir un output que muestre el array t en “bonito”.
output [
  show(t[i,j]) ++ " " ++
  if j == n then "\n" else "" endif |
  i in 1..n, j in 1..n
];

