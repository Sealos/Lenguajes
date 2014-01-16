:- dynamic juego_init/0, turno/0, maquina/0.
:- [imprimir].

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

jugar :-
	not(juego_init),
	!,
	write('Desea jugar contra la maquina (S/N)? '),
	read(M),
	revisar_maquina(M),
	imprimir_tablero,
	assert(juego_init).
jugar:-
	write('Ya inicio un juego.').

jugada_valida(X1, Y1, X2, Y2) :-
	not(turno),
	tablero(M),
	get(M, X1, Y1, E1),
	get(M, X2, Y2, E2),
	ficha(E1),
	!,
	E2 = '  '.

jugada_valida(_, _, _, _) :- !,
	write('No es una jugada valida.'),
	nl.

jugada(X1, Y1, X2, Y2) :- !,
	jugada_valida(X1, Y1, X2, Y2).