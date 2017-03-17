%1)  Escribir un predicado pertenece que recibe como parámetros un entero x y un array a (de
%    cualquier tamaño) y añade la restricción que obliga a que x esté en a.
predicate pertenece (var int: x, array[int] of var int: a) = exists (i in index_set(a))(a[i]=x);

array[1..5] of var 1..3: v;
var int: y;

constraint pertenece (y, v);

solve satisfy;