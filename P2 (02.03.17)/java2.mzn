%variables
var int: x;
var int: y;

%constraints
constraint x > 5 /\ x < 2*y;
constraint y = x-5;
constraint x < 10;

solve satisfy;

%output
output ["x= ", show (x), "\n",
        "y= ", show (y)];