%Carlos Piña Martínez, Juan Luis Romero Sánchez

% r es a AND b
predicate and(var 0..1:a, var 0..1: b, var 0..1: r) =  ((a = 0 /\ b = 0) -> (r = 0)) /\
                                                       ((a = 0 /\ b = 1) -> (r = 0)) /\
                                                       ((a = 1 /\ b = 0) -> (r = 0)) /\
                                                       ((a = 1 /\ b = 1) -> (r = 1));
% r es a OR b
predicate or(var 0..1:a, var 0..1: b, var 0..1: r) = ((a = 0 /\ b = 0) -> (r = 0)) /\
                                                     ((a = 0 /\ b = 1) -> (r = 1)) /\
                                                     ((a = 1 /\ b = 0) -> (r = 1)) /\
                                                     ((a = 1 /\ b = 1) -> (r = 1));

% r es la negación de a
predicate neg(var 0..1: a, var 0..1: r) = ( (a = 1 -> r = 0) /\
                                            (a = 0 -> r = 1));
% r es 0
predicate cero(var 0..1: r) = (r = 0);

% r es 1
predicate uno(var 0..1: r) = (r = 1);

% r es a
predicate cable(var 0..1:a, var 0..1: r) = (r = a);

% construir nor a partir de las anteriores
predicate nor(var 0..1: a, var 0..1: b, var 0..1: r) = (r = (neg( or(a,b,r), r) ) );

% construir nand a partir de las anteriores
predicate nand(var 0..1: a, var 0..1: b, var 0..1: r) = (r = (neg( and(a,b,r), r) ) );

var 0..1: a; 
var 0..1: b; 
var 0..1: c; 
var 0..1: d;
var 0..1: y;
var 0..1: r;
var 0..1: r1;
var 0..1: r2;
var 0..1: r3;

constraint and(a,b,r1);
constraint and(c,d,r2);
constraint or(r1,r2,r3);
constraint neg(r3,r);
constraint y = r;

solve satisfy; 

output([show(a),show(b),  show(c), show(d), show(y)]);