:- dynamic juego_init/0, turno/0, maquina/0, tablero/1, tablero/0.
:- [imprimir, verificaciones, ai].

tablero([
	'  ','< ','  ','< ','  ','<<','  ','< ',
	'< ','  ','< ','  ','<<','  ','< ','  ',
	'  ','< ','  ','< ','  ','< ','  ','< ',
	'  ','  ','  ','  ','  ','  ','> ','  ',
	'  ','< ','  ','< ','  ','  ','  ','  ',
	'> ','  ','> ','  ','>>','  ','> ','  ',
	'  ','> ','  ','> ','  ','> ','  ','> ',
	'> ','  ','> ','  ','>>','  ','> ','  '
]).

turno.

get(M, X, E) :-
	nth0(X, M, E).

get(M, X, Y, E) :-
	Z is (X * 8) + Y,
	get(M, Z, E).

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

jugada(X1, Y1, X2, Y2) :-
	juego_init,
	X1 > 0,
	X1 < 9,
	Y1 > 0,
	Y1 < 9,
	X2 > 0,
	X2 < 9,
	Y2 > 0,
	Y2 < 9,
	Z is X1*8 + Y1 - 9,
	W is X2*8 + Y2 - 9,
	jugada_valida(Z, W),
	procesar_tablero(Z, W).

jugada(_, _, _, _) :-
	juego_init,
	write('Jugada invalida, intente nuevamente.'),
	nl.

jugada(_,_,_,_) :- !,
	not(juego_init),
	write('No ha iniciado el juego, inicie con jugar'),
	nl.

procesar_tablero(Z, W):-
	tablero(M),
	%Procesar
	write('Movimiento: '),
	nl,
	actualizar_tablero(Z, W, M2),
	retract(tablero(M)), 
	assert(tablero(M2)),

	imprimir_tablero,
	cambiar_jugador.
	
reemplazar([_|T], 1, X, [X|T]).
reemplazar([H|T], I, X, [H|R]) :-
	I > 1,
	I1 is I-1, 
	reemplazar(T, I1, X, R).

actualizar_tablero(Z, W, M2) :-
	ficha(F),
	tablero(M),
	reemplazar(M, Z, '  ', M1), 
	reemplazar(M1, W, F, M2).