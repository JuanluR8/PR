%variables de decision
var bool: A;
var bool: B;
var bool: C;
var bool: D;
var bool: E;
var bool: F;
var bool: G;
var bool: H;

%Restricciones
constraint A != B /\ A != D /\ A != E /\  B != F /\ B != C /\
E != F /\ E != H /\ F != G /\ H != D /\ H != G /\ D != C;

%Resolver
solve satisfy;

