:- dynamic juego_init/0, turno/0, maquina/0, tablero/1, tablero/0, tablero/2.
:- [imprimir, verificaciones, ai].

tablero([
	['  ','< ','  ','< ','  ','< ','  ','< '],
	['< ','  ','< ','  ','< ','  ','< ','  '],
	['  ','< ','  ','< ','  ','< ','  ','< '],
	['  ','  ','  ','  ','  ','  ','  ','  '],
	['  ','  ','  ','  ','  ','  ','  ','  '],
	['> ','  ','> ','  ','> ','  ','> ','  '],
	['  ','> ','  ','> ','  ','> ','  ','> '],
	['> ','  ','> ','  ','> ','  ','> ','  ']
]).

revisar_maquina('S') :-
	assert(maquina).

revisar_maquina(_).

turno.

get(M, X, Y, E) :-
	nth1(X, M, L),
	nth1(Y, L, E).

cambiar_jugador :-
	not(turno),
	!,
	assert(turno),
	write('Juegan las fichas blancas (<< | <): '),
	% Si es una maquina jugar la maquina
	jugar_maquina.
cambiar_jugador :-
	turno,
	!,
	retract(turno),
	write('Juegan las fichas negras (>> | >): ').

jugar :-
	not(juego_init),
	write('Desea jugar contra la maquina (S/N)? '),
	read(M),
	revisar_maquina(M),
	!,
	imprimir_tablero,
	assert(juego_init),
	cambiar_jugador,
	nl.

jugar:-
	write('Ya inicio un juego.'),
	!.

jugada(X1, Y1, X2, Y2) :- !,
	jugada_valida(X1, Y1, X2, Y2),
	procesar_tablero(X1, Y1, X2, Y2),
	write('Movimiento: '),
	imprimir_tablero,
	cambiar_jugador.

procesar_tablero(X1,Y1,X2,Y2):-
	tablero(M),
	%Procesar
	write('Movimiento: '),
	actualizar_tablero(X1, Y1, X2, Y2,M2),
	retract(tablero(M)),
	assert(tablero(M2)),
	imprimir_tablero,
	cambiar_jugador.
	
reemplazar([_|T], 1, X, [X|T]).
reemplazar([H|T], I, X, [H|R]):- I > 1, I1 is I-1, reemplazar(T, I1, X, R).

actualizar_tablero(X1,Y1,X2,Y2,M2) :-
	ficha(F),
	tablero(X1,F1A),reemplazar(F1A,Y1,'  ',F1D), 
	tablero(X2,F2A),reemplazar(F2A,Y2,F,F2D), 
	tablero(M1),reemplazar(M1,X1,F1D,M1A), reemplazar(M1A,X2,F2D,M2),
	retract(tablero(X1,F1A)), retract(tablero(X2,F2A)), 
	assert(tablero(X1,F1D)), assert(tablero(X2,F2D)).