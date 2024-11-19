% Los ... son datos que no eran relevantes para el desarrollo del ejercicio):
%
% catedra(nombre_catedra,...).
% comision(nombre_catedra,comision,ciclo,...,[legajos de inscriptos]).
% alumno(legajo,nombre,...).
% 
% * Aclaracion: una catedra puede tener muchas comisiones *
% 
% Te pedia:
% 1- Devolver lista [] de las catedras del ciclo 2017 que tengan más de 100 inscriptos en sus comisiones.
% 2- Mostrar las catedras en las que se encuentra inscripto un alumno
% (ingresando el legajo) tambien en el ciclo 2017.
%


:- dynamic(catedra/2).
:- dynamic(comision/4).
:- dynamic(alumno/2).

inicio:-
  abrir_base,
  writeln(""),
  writeln("1. Catefras en 2017 con ams de 100 inscriptos"),
  writeln("2. Catedras del alumno 2017"),
  writeln("0. Salir"),
  read(Op), Op\=0, menu(Op),
  inicio.


menu(1):-catedras_numerosas(Lista), writeln(Lista).



catedras_numerosas([H|T]):-
  comision(H, _,2017,Legajos),
  retract(comision(H, _,2017,Legajos)),
  contar(Legajos, Cant),
  Cant>5,
  catedras_numerosas(T).

catedras_numerosas([]).


contar([],0).
contar([_|T], Cant):- contar(T, Cant2),Cant is Cant2 +1 .



abrir_base :-
    % Cátedras
    assert(catedra('Matemática I')),
    assert(catedra('Programación')),
    assert(catedra('Física I')),

    % Comisiones
    assert(comision('Matemática I', 'A', 2018, [1234, 5678, 9101, 1234,2345, 2345])),
    assert(comision('Matemática I', 'B', 2017, [2345, 6789])),
    assert(comision('Programación', 'A', 2024, [1234, 3456, 7890,1121,1231,12312])),
    assert(comision('Física I', 'C', 2017, [5678, 9101,123,12312,12311,12312,213232])),

    % Alumnos
    assert(alumno(1234, 'Juan Pérez')),
    assert(alumno(5678, 'Ana López')),
    assert(alumno(9101, 'Carlos Gómez')),
    assert(alumno(2345, 'Lucía Fernández')),
    assert(alumno(6789, 'Marta Rodríguez')),
    assert(alumno(3456, 'Pedro Torres')),
    assert(alumno(7890, 'Sofía Martínez')).
