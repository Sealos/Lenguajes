reina :- ficha('<<');ficha('>>').

blanca('< ').

negra('> ').

ficha(F) :-
	turno,
	blanca(F),
	!.
ficha(F) :-
	not(turno),
	negra(F),
	!.

jugada_valida(X1, Y1, X2, Y2) :-
	reina,
	jugada_valida_reina(X1,Y1,X2,Y2);
	jugada_valida_peon(X1,Y1,X2,Y2).

jugada_valida(_, _, _, _) :- !,
	write('No es una jugada valida.'),
	nl,
	fail.

jugada_valida_peon(X1,Y1,X2,Y2):-
	(Y1\=Y2,
	tablero(M),
	get(M, X1, Y1, E1),
	get(M, X2, Y2, E2)),
	((ficha('< '),
	X1<X2); 
	(ficha('> '),
	(X1>X2))),
	ficha(E1),
	!,
	E2 = '  '.

jugada_valida_reina(X1,Y1,X2,Y2) :-
	tablero(M),
	get(M, X1, Y1, E1),
	get(M, X2, Y2, E2),
	Y1\=Y2,
	ficha(E1),
	!,
	E2 = '  '.