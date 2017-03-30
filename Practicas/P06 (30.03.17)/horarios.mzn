%Carlos Piña Martínez, Juan Luis Romero Sánchez

% num asignaturas;  1-> ge , 2->fp, 3->fc, 4-> mdl, 5->mmi
int:n=5;
% num dias con clase
int:dias=5;
% num horas/dia
int:horas=4;

% max. tamaño del bloque
int:maxbloque=2;

% bloques por asignaturas y por bloques, representados como un array unidimensional
array [1..n,1..maxbloque] of 0..horas*dias:bloques = [|0,2 | 2,1 | 2,1 | 4,0 | 4,0 |];

% esto es lo que queremos averiguar: para cada día cuantas horas
% de cada asignatura se imparten?
array [1..dias,1..n] of var 0..maxbloque:horario;

%1) Un predicado horasDia que reciba un horario (array [1..dias,1..n] of var 0..maxbloque) y asegure
%que ningún día se superan las horas de clase por día (constante horas).

predicate horasDia (array [1..dias,1..n] of var 0..maxbloque:h) = 
                    forall (i in 1..dias)(
                            sum(j in 1..n)(h[i,j]) <= horas
                    );

% 2) Un predicado nbloques que recibe como parámetros:
% - Un horario, como en el ejercicio anterior
% - Una asignatura (número de 1 a n)
% - Un tamaño de bloque bsize (de 1 a maxbloque)
% - Una variable de tipo entero “total”
% El predicado debe asegurar que semanalmente se imparte una cantidad “total” de bloques de tamaño
% bsize de la asignatura.

predicate nbloques(array [1..dias,1..n] of var 0..maxbloque:h,
                   int:asignatura,
                   int:bsize,
                   var int: total) = sum(i in 1..dias)(h[i,asignatura] = bsize) = total;

% 3) Un predicado bloquesPorAsignatura que reciba como parámetros un horario y asegure que para
% cada asignatura se imparte la cantidad indicada en “bloques” de bloques de cada tamaño. Utilizará
% el predicado anterior.

predicate bloquesPorAsignatura (array [1..dias,1..n] of var 0..maxbloque:h) =
                                forall(i in 1..n)(forall(j in 1..maxbloque)(
                                                    nbloques(h,i,j,bloques[i,j])
                                                  )
                                );

%CONSTRAINTS
constraint horasDia(horario);
constraint bloquesPorAsignatura(horario);

solve satisfy;
 
output [
  "L M X J V\n"] ++[  
   show(horario[j,i]) ++ " " ++
   if j == dias then "\n" else "" endif | 
   i in 1..dias, j in 1..n 
];