%variables
var int: x;
var int: y;

%constraints
constraint x > 5 /\ x < 2*y;

solve satisfy;

%output
output ["x= ", show (x), "\n",
        "y= ", show (y)];