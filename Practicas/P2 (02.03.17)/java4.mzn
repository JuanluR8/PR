%variables
var -2..2: x;
var -2..2: y;
var -2..2: z;
var -2..2: m;

%constraint
constraint ((x<y) /\ (y<z) /\ (m=z)) 
            \/ ((x<y) /\ not (y<z) /\ (m=y)) 
            \/ (not (x<y) /\ (x<z) /\ m=z) 
            \/ (not (x<y) /\ not (x<z) /\ m=x);
constraint m != x /\ m != y /\ m != z;

%No hay solución, ya que estamos buscando el máximo entre x, y, z, 
%por tanto m (el máximo) no puede ser distinto de los tres a la vez.

solve satisfy;

output ["  x= ", show (x),"  y= ", show (y), "  z= ", show(z),  "\n",
        "  maximo m = ", show (m)];