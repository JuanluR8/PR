%Carlos Piña Martínez, Juan Luis Romero Sánchez

include "alldifferent.mzn";

%Equipos de la liga
int: equipos = 4;

%Semanas que dura la liga
int: semanas = 6;

%Tabla
array [1..equipos, 1..equipos] of var 0..semanas: calendario;

%ningun equipo juega consigo mismo
constraint forall(i in 1..equipos)
                 (calendario[i,i] = 0);
constraint forall(i in 1..equipos, j in 1..equipos)
                 (i!=j -> calendario[i,j] > 0);

%un equipo no puede jugar dos veces la misma semana
%columnas
constraint forall(i in 1..equipos)(alldifferent( [calendario[i,j] | j in 1..equipos] ));
                 
%filas
constraint forall(i in 1..equipos)(alldifferent( [calendario[j,i] | j in 1..equipos] ));

%todos los partidos del equipo X son en distintas semanas
constraint forall(i in 1..equipos)
                 (alldifferent( [calendario[j,i] | j in 1..equipos where i!=j] 
                                ++ [calendario[i,j] | j in 1..equipos where i!=j] ));

solve satisfy;

output [
        show_int(3, calendario[i,j]) ++ " " ++ 
        if j == equipos then "\n" else "" endif |
        i in 1..equipos, j in 1..equipos
];