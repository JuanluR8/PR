%Una empresa puede producir 200 bicicletas o 140 triciclos por hora
%El beneficio es
%bici: 25 euros
%trici: 30
%Tope de producción
%6000 bicis por semana máx.
%4000 triciclos por semana máx.
%Semana: 40 horas
%¿Producción para maximizar el beneficio?

%parametros
int: prodBici = 200;
int: prodTric = 140;
int: benBici = 25;
int: benTric = 30;
int: maxhoras = 40;

%variables
var 0..6000: v_bici;
var 0..4000: v_tric;
var int: beneficio;

%constraint
constraint prodBici * v_bici + prodTric * v_tric <= (prodBici * prodTric) * maxhoras;
constraint beneficio = benBici * v_bici + benTric * v_tric;

%solve
solve maximize beneficio;

%output
output["bicis: ", show (v_bici), "\n",
       "triciclos: ", show (v_tric), "\n",
       "beneficio: ", show (beneficio) ];