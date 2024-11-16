% Dada la siguiente BD:
% persona(dni,nombre,edad).
% auto_vendido(patente,codModelo,fecha,precio,[DNItitulares])
% auto(codModelo,modelo)
% 1) ingresar dni de una persona y mostrar todos los autos de los que es titular.
% 2) ingresar el codigo de un auto y calcular el precio promedio de autos vendidos.
% 3) mostrar el titular mas joven de cada auto vendido.


:- dynamic(persona/3).
:- dynamic(auto_vendido/5).
:- dynamic(auto/2).


inicio:-
  abrir_base,
  writeln(""),
  writeln(""),
  writeln("1) ingresar dni de una persona y mostrar todos los autos de los que es titular."),
  writeln("2) ingresar el codigo de un auto y calcular el precio promedio de autos vendidos."),
  writeln("3) mostrar el titular mas joven de cada auto vendido."),
  read(Op),menu(Op),
  inicio.

% 1) ingresar dni de una persona y mostrar todos los autos de los que es titular.
menu(1):- write("dni:"),read(Dni),buscar_autos_de_titular(Dni, Lista_autos),writeln(Lista_autos).


% 2) ingresar el codigo de un auto y calcular el precio promedio de autos vendidos.
menu(2):- write("cod de auto:"),read(CodAuto),
  cant_y_sum_autos_vendidos(CodAuto, Cant, Sum),
  mostrar_promedio(Cant,Sum).


% 3) mostrar el titular mas joven de cada auto vendido.
menu(3):- mostrar_mas_joven_por_auto.

mostrar_mas_joven_por_auto:-
  auto_vendido(Patente, _,_,_,ListaTitulares),
  retract(auto_vendido(Patente, _,_,_,ListaTitulares)),
  buscar_mas_joven(ListaTitulares, NombreTitularJoven),
  write(Patente),write(": "),writeln(NombreTitularJoven),
  mostrar_mas_joven_por_auto.

mostrar_mas_joven_por_auto.


buscar_mas_joven([Dni], NombreTitularJoven):-
  persona(Dni,NombreTitularJoven, _).

buscar_mas_joven([Dni1, Dni2 | T], NombreTitularJoven):-
  persona(Dni1,_, Edad1),
  persona(Dni2,_, Edad2),
  Edad1<Edad2,
  buscar_mas_joven([Dni1 |T], NombreTitularJoven).

buscar_mas_joven([Dni1, Dni2 | T], NombreTitularJoven):-
  persona(Dni1,_, Edad1),
  persona(Dni2,_, Edad2),
  Edad1>Edad2,
  buscar_mas_joven([Dni2 |T], NombreTitularJoven).





buscar_autos_de_titular(Dni, [H_lista|T]):-
  auto_vendido(_,CodModelo,_,_,DNItitulares),
  retract(auto_vendido(_,CodModelo,_,_,DNItitulares)),
  pertenece(Dni, DNItitulares),
  auto(CodModelo, H_lista),
  retract(auto(CodModelo, H_lista)),
  buscar_autos_de_titular(Dni,T).

buscar_autos_de_titular(_,[]).


cant_y_sum_autos_vendidos(CodModelo, Cant, Sum):-
  auto_vendido(Patente,CodModelo, _,Precio, _),
  retract(auto_vendido(Patente,CodModelo, _,Precio, _)),
  cant_y_sum_autos_vendidos(CodModelo, Cant2, Sum2),
  Cant is Cant2 + 1,
  Sum is Sum2 + Precio.

cant_y_sum_autos_vendidos(_,0,0).



% Utils
pertenece(H,[H|_]).
pertenece(X,[_|T]):- pertenece(X,T).

mostrar_promedio(0, _):-write("No se encontraron elementos").
mostrar_promedio(Cant, Sum):-Promedio is Sum/Cant,write("Promedio: "), write(Promedio).

% Base de conocimiento
abrir_base:-
  true
  % retractall(persona(_,_,_)),
  % retractall(auto_vendido(_,_,_,_,_)),
  % retractall(auto(_,_)),
  % consult("jdkslajdskal")
  .

% persona(DNI, Nombre, Edad).
persona(12345678, 'Juan Perez', 35).
persona(87654321, 'Maria Gomez', 29).
persona(11223344, 'Carlos Lopez', 40).
persona(33445566, 'Ana Torres', 22).

% auto_vendido(Patente, CodModelo, Fecha, Precio, [DNITitulares]).
auto_vendido('AB123CD', 101, '2023-01-15', 25000, [12345678, 87654321]).
auto_vendido('AB123CD-2', 101, '2023-01-16', 15000, [12345678]).
auto_vendido('CD456EF', 102, '2023-03-10', 20000, [11223344]).
auto_vendido('GH789IJ', 103, '2024-02-20', 25000, [33445566, 12345678]).

% auto(CodModelo, Modelo).
auto(101, 'Toyota Corolla').
auto(102, 'Ford Fiesta').
auto(103, 'Honda Civic').
auto(104, 'Volkswagen Golf').


  
