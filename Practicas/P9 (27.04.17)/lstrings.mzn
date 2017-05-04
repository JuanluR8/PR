%Carlos Piña Martínez, Juan Luis Romero Sánchez

% fichero lstrings.mzn
set of int:CHAR=1..4;

% nota: suponemos que los strings son arrays de char empezando en la posición 1


% substring(a,p,b) = a es una subcadena de b comenzando en la posición p. Es decir b[p]=a[1]....b[p+n-1]=a[n] con n la longitud de a.
predicate substring(array [int] of var CHAR:a, var int:ini,
                    array [int] of var CHAR:b) = forall( i in 1..length(a) )(b[ini+i-1] = a[i] );

% reverse(a,b): b es la cadena inversa de a.
predicate reverse(array [int] of var CHAR:a, array [int] of var CHAR:b) = 
                  (length(a) = length(b)) /\ forall (i in 1..length(a))( a[i] = b [length(a)+1-i]);

% count(a,n,c): la cadena a contiene exactamente n copias del carácter c.
predicate count(array [int] of var CHAR:a, var int: n, var int: c) = 
                n = sum (i in 1..length(a))(a[i] = c);

% concat(a,b,c): c es la cadena resultante de contatenar a y b
predicate concat(array [int] of var CHAR:a, array [int] of var CHAR:b, array [int] of var CHAR:c) = 
                 forall(i in 1..length(a), j in length(a)+1..length(a)+length(b))( c[i] = a[i] /\ c[j] = b[j-length(a)] );
                  

% index(a,l,p): La primera aparición del caracter l en el string a ocurre en la posición p (p = -1 si no aparece)
predicate index(array [int] of var CHAR:a, var int:l, var int:p) = 
                exists(i in 1..length(a))( a[i]=l /\ p=i ) 
                \/ (not ( exists(i in 1..length(a))(a[i]=l) ) /\ p = -1);

% insert(a,l,p,b): b es el resultado de insertar el caracter l en la posición p de a. Lógicamente b tendrá un caracter más que a.
predicate insert(array [int] of var CHAR:a, var int:l, var int:p, array [int] of var CHAR:b) =
                  forall(i in 1..length(a)+1)( (i < p /\ b[i]=a[i]) \/ (i=p /\ b[i]=l) \/ (i>p /\ b[i]=a[i-1]));

% remove(a,l,b): b es el resultado de eliminar la primera aparición del caracter l en a. b tendrá un caracter menos que a si l está en a. En otro caso b=a.
predicate remove(array [int] of var CHAR:a, var int:l, array [int] of var CHAR:b) = 
                let {var int: x} in index(a, l, x) /\ (
                (x=-1 /\ a=b) \/ 
                ( forall(i in 1..length(a))( (b[i]=a[i] /\ i<x) \/ (b[i-1]=a[i] /\ i>x) ) ) );

% removeAll(a,l,b): b es el resultado de eliminar todas las apariciones del caracter l en a. b tendrá un caracter menos que a si l está en a. En otro caso b=a.
% predicate removeAll
