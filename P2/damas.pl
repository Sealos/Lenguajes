:- dynamic juego_init/0, turno/0, maquina/0, tablero/1, tablero/0.
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

tablero(1, ['  ','< ','  ','< ','  ','< ','  ','< ']).
tablero(2, ['< ','  ','< ','  ','< ','  ','< ','  ']).
tablero(3, ['  ','< ','  ','< ','  ','< ','  ','< ']).
tablero(4, ['  ','  ','  ','  ','  ','  ','  ','  ']).
tablero(5, ['  ','  ','  ','  ','  ','  ','  ','  ']).
tablero(6, ['> ','  ','> ','  ','> ','  ','> ','  ']).
tablero(7, ['  ','> ','  ','> ','  ','> ','  ','> ']).
tablero(8, ['> ','  ','> ','  ','> ','  ','> ','  ']).

revisar_maquina('S') :-
	assert(maquina).

revisar_maquina(_).

turno.

blanca('< ').
blanca('<<').
negra('> ').
negra('>>').
ficha(F) :-
	turno,
	blanca(F),
	!.
ficha(F) :-
	not(turno),
	negra(F),
	!.

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
	write('Movimiento: '),
	imprimir_tablero,
	cambiar_jugador.