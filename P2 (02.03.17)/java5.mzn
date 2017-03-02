%variables
var -2..2: x;
var -2..2: y;
var -2..2: z;
var -2..2: m;

var -1000..1000: a;
var -1000..1000: b;
var -1000..1000: u;

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