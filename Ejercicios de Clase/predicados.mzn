%1)  Escribir un predicado pertenece que recibe como parámetros un entero x y un array a (de
%    cualquier tamaño) y añade la restricción que obliga a que x esté en a.
predicate pertenece (var int: x, array[int] of var int: a) = exists (i in index_set(a))(a[i]=x);

% 2) Escribir un predicado ordenado que reciba un array y añada la restricción a que el array esté
%    ordenado.
predicate ordenado (array[int] of var int: a) = forall (i, j in index_set(a) where i<j) ( a[i] <= a[j] );

% 3) Dado un parámetro de tipo array de enteros:
%  queremos añadir constraints para asegurar que b es a ordenado. Se puede suponer que a no tiene elementos repetidos.
predicate ordena (array[int] of var int: a, array[int] of var int: b) = 
                    forall (i in index_set(a))( pertenece(a[i], b)) /\ ordenado(b);

% 4) ¿Y si el array a puede tener elementos repetidos? ¿Cómo lo harías?
predicate cardinal (var int: x, array[int] of var int: a, var int: c) =
                    c=sum([ x == e | e in a]);
predicate ordConRepetidos (array[int] of var int: a, array[int] of var int: b)=
                           forall(e in a)(
                                let {var int:c} in
                                cardinal(e,b,c) /\ cardinal(e,a,c)) 
                           /\ ordenado(b);
                           

%%%%%  PRUEBAS
set of int:S= 1..10;
array [S] of int: a = [2,3,4,5,6,7,1,8,10,10];
array [S] of var int: b;


%Apartado 1
%constraint pertenece (2, a);

%Apartado 2
%constraint ordenado (a);

%Apartado 3
%constraint ordena(a, b);

%Apartado 4
constraint ordConRepetidos(a, b);

solve satisfy;
