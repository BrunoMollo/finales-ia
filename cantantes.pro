% Dada una BD con:
%
% cantante(nombre_cantante,pais_origen)
% album(nombre_album,nombre_cantante,[lista_temas]),fecha_edicion,copias_vendidas)
% (El formato del campo fecha es dd/mm/aaaa)
%
% 1)Ingrese un álbum y una lista [] de temas y a partir de esto devolver una lista
% con aquellos temas de la lista original que correspondan al álbum ingresado.
%
% 2)Informar cuantos álbumes fueron lanzados en un determinado año (dato de entrada) 
% por cantantes de origen sueco.
%
% 3)Ingresar un cantante y devolver una lista con todos los albumes que haya lanzado
% a lo largo de su carrera y cuya cantidad de copias supere el millón.

:- dynamic(album/5).
:- dynamic(cantante/2).

inicio:-
  abrir_base,
  writeln(""),
  writeln(""),
  writeln("1.Lista Intersecion Album/Temas"),
  writeln("2. Cuanto suecos"),
  writeln("3."),
  writeln("0. Salir"),
  read(Op), menu(Op),
  inicio.


menu(0):-writeln("Chau"),fail.

menu(1):-
  write("Album: "),read(Album),
  write("Lista temas:"),leer_lista(Temas),
  subconjunto_temas(Album,Temas, ListaOutput),
  writeln(ListaOutput).

% 2)Informar cuantos álbumes fueron lanzados en un determinado año (dato de entrada) 
% por cantantes de origen sueco.
% (El formato del campo fecha es dd/mm/aaaa)

menu(2):-
  write("Año: "), read(Anio),
  contar_suecos_en_anio(Anio, Cant),
  write("Cantidad de albumes suecos en el año: "), write(Cant)
  .

contar_suecos_en_anio(Anio, Cant):-
  album(_,NombreCantante,_,Fecha,_),
  retract(album(_,NombreCantante,_,Fecha,_)),
  sub_atom(Fecha,6,4,_,Anio),
  cantante(NombreCantante,'sueco'),
  contar_suecos_en_anio(Anio, Cant2),
  Cant is Cant2 + 1.

contar_suecos_en_anio(_, 0).





subconjunto_temas(NombreAlbum, ListaTemas_A, ListaOutput):-
  album(NombreAlbum,_,ListaTemas_B,_,_),
  interseccion(ListaTemas_A, ListaTemas_B, ListaOutput).


interseccion([],_,[]).

interseccion([HA|TA],B,[HA|Resto]):-
  pertenece(HA,B),
  interseccion(TA,B,Resto).

interseccion([_|TA],B,Resto):-
  interseccion(TA,B,Resto).

leer_lista([H|T]):-read(H), H\=[], leer_lista(T).
leer_lista([]).

pertenece(X,[X|_]).
pertenece(X,[_|T]):-pertenece(X,T).










abrir_base:-
  assert(cantante('Shakira', 'sueco')),
  assert(cantante('The Beatles', 'sueco')),
  assert(cantante('Luis Miguel', 'México')),
  assert(cantante('Queen', 'Reino Unido')),
  
  assert(album('Laundry Service', 'Shakira', ['Whenever, Wherever', 'Underneath Your Clothes'],  "01-01-1969", 20000000)),
  assert(album('Abbey Road', 'The Beatles', ['Come Together', 'Something', 'Here Comes the Sun'], "01-01-1969", 31000000)),
  assert(album('romances', 'Luis Miguel', ['a', 'b', 'c'],  "01-01-1969", 8000000)),
  assert(album('A Night at the Opera', 'Queen', ['Bohemian Rhapsody', 'Love of My Life', 'You’re My Best Friend'], "12-12-2001", 6000000))
.




