jugada_valida(X1, Y1, X2, Y2) :-
	tablero(M),
	get(M, X1, Y1, E1),
	get(M, X2, Y2, E2),
	ficha(E1),
	!,
	E2 = '  ',
	%Verificar si es un movimiento valido
	write('Movimiento: '),
	imprimir_tablero,
	cambiar_jugador.

jugada_valida(_, _, _, _) :- !,
	write('No es una jugada valida.'),
	nl.