blanca('< ').
blanca('< ').
negra('> ').
negra('> ').

es_reina('<<').
es_reina('>>').

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

jugada_valida(Z, W) :-
	tablero(M),
	get(M, W, E),			% El destino tiene que ser vacio
							% Verificar si debe comer
	E = '  ',
	get(M, Z, E1),
	ficha(E1),				% Verificamos si la ficha que seleccionamos es nuestra
	(
		(
			es_reina(E1),
			jugada_valida_reina(Z, W)
		)
		;
		(
			not(es_reina(E1)),
			jugada_valida_peon(Z, W)
		)
	).

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

get(M, X, Y, E) :-
	Z is (X* 8) + Y,
	get(M, Z, E).

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
	X is div(Z, 8) - 1,
	X > 1,
	come_negra_aux(Z, W).

come_negra_aux(Z, W) :-
	YF is mod(Z, 8) + 1,
	YF < 8,
	tablero(M),
	get(M, XF, YF, E1),
	blancas(E1),
	YFF is YF + 1,
	get(M, XFF, YFF, E2),
	E2 = '  ',
	W is (XFF * 8) + YFF.

come_negra_aux(Z, W) :-
	YF is mod(Z, 8) - 1,
	YF > 1,
	tablero(M),
	get(M, XF, YF, E1),
	blancas(E1),
	YFF is YF - 1,
	get(M, XFF, YFF, E2),
	E2 = '  ',
	W is (XFF * 8) + YFF.

% Come hacia abajo (X2 > X1; Y2 > Y1)
come_blanca_peon(Z, W) :-
	X is div(Z, 8) + 1,
	X < 7,
	come_blanca_aux(Z, W).

come_blanca_aux(Z, W) :-
	YF is mod(Z, 8) + 1,
	YF < 7,
	tablero(M),
	get(M, XF, YF, E1),
	negras(E1),
	YFF is YF + 1,
	get(M, XFF, YFF, E2),
	E2 = '  ',
	W is (XFF * 8) + YFF.

come_blanca_aux(Z, W) :-
	YF is mod(Z, 8) - 1,
	YF > 0,
	tablero(M),
	get(M, XF, YF, E1),
	negras(E1),
	YFF is YF - 1,
	get(M, XFF, YFF, E2),
	E2 = '  ',
	W is (XFF * 8) + YFF.