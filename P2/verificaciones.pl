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

des_peon(X) :- 
	not(turno),
	!,
	X is -1.
des_peon(X) :- 
	turno,
	!,
	X is 1.

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

numero(1).
numero(2).
numero(3).
numero(4).
numero(5).
numero(6).
numero(7).
numero(8).

% Solo arriba o abajo
diagonal(Z, W, E) :-
		W is Z + E * 9;
		W is Z + E * 7.

% Cualquier diagonal
diagonal(Z, W) :-
	numero(E),
	(
		W is Z + E * 9;
		W is Z - E * 9;
		W is Z + E * 7;
		W is Z - E * 7
	).

%jugada_valida(_, _, _, _) :- !,
%	write('No es una jugada valida.'),
%	nl,
%	fail.

jugada_valida_peon(Z, W):-
	des_peon(E),
	diagonal(Z, W, E),
	!.

jugada_valida_reina(Z, W) :-
	diagonal(Z, W).

come_peon(Z, W) :-
	come_blanca_peon(Z, W);
	come_negra_peon(Z, W).

% Come hacia arriba (X2 > X1; Y2 > Y1)
come_negra_peon(Z, W) :-
	X is div(Z, 8) - 1,
	X > 1,
	come_negra_aux(Z, W).

come_negra_aux(Z, W) :-
	YF is mod(Z, 8) + 1,
	XF is div(Z, 8) - 1,
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
	XF is div(Z, 8) - 1,
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
	XF is div(Z, 8) + 1,
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
	XF is div(Z, 8) + 1,
	YF > 0,
	tablero(M),
	get(M, XF, YF, E1),
	negras(E1),
	YFF is YF - 1,
	get(M, XFF, YFF, E2),
	E2 = '  ',
	W is (XFF * 8) + YFF.