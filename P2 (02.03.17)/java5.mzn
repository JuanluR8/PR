%variables
var int: x;
var int: y;
var int: z;
var int: m;
var int: a;
var int: b;
var int: u;

%constraint
constraint ((x<y) /\ (y<z) /\ (m=z)) 
            \/ ((x<y) /\ not (y<z) /\ (m=y)) 
            \/ (not (x<y) /\ (x<z) /\ m=z) 
            \/ (not (x<y) /\ not (x<z) /\ m=x);

constraint ((a>0) /\ (x=a) /\ (y=b) /\ (z=100) /\ (u=m))
          \/(not(a>0) /\ (x=a*a) /\ (y=b) /\ (z=b*b) /\ (u=m+1));


solve satisfy;

output ["  x= ", show (x),"  y= ", show (y), "  z= ", show(z),  "\n",
        "  a= ", show (a),"  b= ", show (b), "\n",
        "  u= ", show(u),  "\n",
        "  maximo m = ", show (m)];