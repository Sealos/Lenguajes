reina :- ficha('<<');ficha('>>').

blanca('< ').

negra('> ').

negras('> ').
negras('>>').
blancas('< ').
blancas('<<').

revisar_maquina('S') :-
	assert(maquina).

revisar_maquina(_).

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

%jugada_valida(_, _, _, _) :- !,
%	write('No es una jugada valida.'),
%	nl,
%	fail.

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


% X1 posicion X de la ficha
% Y1 posicion Y de la ficha
% X2 posicion X de la ficha luego de comer
% Y2 posicion Y de la ficha luego de comer 
come_peon(X1, Y1, X2, Y2) :-
	come_blanca_peon(X1, Y1, X2, Y2);
	come_negra_peon(X1, Y1, X2, Y2).

% Come hacia arriba (X2 > X1; Y2 > Y1)
come_negra_peon(X1, Y1, X2, Y2) :-
	tablero(M),
	XF is X1 - 1,
	XF > 1,
	XFF is XF - 1,
	(
		(
			YF is Y1 +1,
			YF < 8,
			get(M, XF, YF, E1),
			blancas(E1),
			YFF is YF + 1,
			get(M, XFF, YFF, E2),
			E2 = '  ',
			X2 is XFF,
			Y2 is YFF
		)
		;
		(
			YF is Y1 - 1,
			YF > 1,
			get(M, XF, YF, E1),
			blancas(E1),
			YFF is YF - 1,
			get(M, XFF, YFF, E2),
			E2 = '  ',
			X2 is XFF,
			Y2 is YFF
		)
	).

% Come hacia arriba (X2 > X1; Y2 > Y1)
come_blanca_peon(X1, Y1, X2, Y2) :-
	tablero(M),
	XF is X1 + 1,
	XF < 8,
	XFF is XF + 1,
	(
		(
			YF is Y1 +1,
			YF < 8,
			get(M, XF, YF, E1),
			negras(E1),
			YFF is YF + 1,
			get(M, XFF, YFF, E2),
			E2 = '  ',
			X2 is XFF,
			Y2 is YFF
		)
		;
		(
			YF is Y1 - 1,
			YF > 1,
			get(M, XF, YF, E1),
			negras(E1),
			YFF is YF - 1,
			get(M, XFF, YFF, E2),
			E2 = '  ',
			X2 is XFF,
			Y2 is YFF
		)
	).