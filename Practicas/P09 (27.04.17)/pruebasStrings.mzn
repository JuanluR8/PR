include "lstrings.mzn";

array [1..3] of var CHAR:a = [1, 2, 3];
array [1..3] of var CHAR:c;
%array [1..3] of var CHAR:b = [2, 2, 2];
var int:p = 4;
var int:q = 2;

% ....... pruebas .....
%constraint substring(a, p, c);
%constraint reverse(a, c);
%constraint count(a, 2 ,2);
%constraint concat(a, b, c);
%constraint index(a, 2, p);
%constraint insert(a, p, q, c);
constraint remove(a, q, c);
  
solve satisfy;