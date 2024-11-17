%  menu(idMenu, nomMenu, [lista idPlato])
% plato(idPlato, descripción, tipo, tieneSal, tieneGluten).
%
% Tipo puede ser entrada, plato principal, postre.
% 1. Dado un nombre de menu decir cuantos de sus platos contienen gluten.
% 2. Listar aquellos menu que ninguno de sus platos contiene sal.

:-dynamic(menu/3).
:-dynamic(plato/5).


inicio:-
  abrir_base,
  writeln("\n"),
  writeln("1. Dado un nombre de menu decir cuantos de sus platos contienen gluten."),
  writeln("2. Listar aquellos menu que ninguno de sus platos contiene sal."),
  read(Op), opcion(Op),
  inicio.


opcion(1):-
  writeln("Nombre Menu:"),
  read(M),
  menu(_,M,ListaPlatos),
  writeln(ListaPlatos),
  obtener_cantidad_con_gluten(ListaPlatos, CantConGluten),
  write("Cantida con gluten: "),write(CantConGluten).

opcion(1):-writeln("Ese Nombre de Menu no existe").



obtener_cantidad_con_gluten([IdPlato | T], CantConGluten):-
  retract(plato(IdPlato,_,_,_,TieneGluten)),
  TieneGluten=1,
  obtener_cantidad_con_gluten(T, CantConGluten2),
  CantConGluten is CantConGluten2 +1.

obtener_cantidad_con_gluten([_| T], CantConGluten):-
  obtener_cantidad_con_gluten(T, CantConGluten).

obtener_cantidad_con_gluten([], 0).





% Base de Conocimeinto

abrir_base:-
assert(menu(1,'primavera',[1,2,3])),
assert(menu(2,'verano',[4,5,6])),
assert(menu(3,'invierno',[4,7])),
assert(menu(4,'otoño',[5,6])),
assert(plato(1,ensaladaAlegre,entrada,1,0)),
assert(plato(2,carneAlegre,principal,1,1)),
assert(plato(3,postreAlegre,postre,0,1)),
assert(plato(4,ensaladaCaliente,entrada,1,0)),
assert(plato(5,carneCaliente,principal,0,1)),
assert(plato(6,postreCaliente,postre,0,1)),
assert(plato(7,postreFrio,postre,0,0)).
