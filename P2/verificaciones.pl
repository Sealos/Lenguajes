blanca('< ').
blanca('<<').
negra('> ').
negra('>>').

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

not_ficha(F) :-
	turno,
	negra(F),
	!.
not_ficha(F) :-
	not(turno),
	blanca(F),
	!.

des_peon(X) :- 
	not(turno),
	!,
	X is -1.
des_peon(X) :- 
	turno,
	!,
	X is 1.

uno(1).
uno(-1).

fichas_jugador_actual(L) :-
	turno,
	tablero(M),
	findall(X, get(M, X, '< '), L1),
	findall(Y, get(M, Y, '<<'), L2),
	append(L1, L2, L).

fichas_jugador_actual(L) :-
	not(turno),
	tablero(M),
	findall(X, get(M, X, '> '), L1),
	findall(Y, get(M, Y, '>>'), L2),
	append(L1, L2, L).

obtener_saltos(Z, LW) :-
	findall(X, come(Z, X), LW).

saltos_jugador_actual(L, S) :-
	maplist(obtener_saltos, L, S).

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

% Solo arriba o abajo
diagonal(Z, W, 1) :-
	YZ is mod(Z, 8),
	(
	(
		W is Z + 1 * 9,
		YW is mod(W, 8),
		YW >= YZ
	)
	;
	(
		W is Z + 1 * 7,
		YW is mod(W, 8),
		YW =< YZ
	)).

diagonal(Z, W, -1) :-
	YZ is mod(Z, 8),
	((
		W is Z + (-1) * 9,
		YW is mod(W, 8),
		YW =< YZ
	)
	;
	(
		W is Z + (-1) * 7,
		YW is mod(W, 8),
		YW >= YZ
	)).

% Cualquier diagonal
diagonal(Z, W) :-
	diagonalNE(Z, W, 1);
	diagonalNW(Z, W, 1);
	diagonalSE(Z, W, 1);
	diagonalSW(Z, W, 1).

diagonalNW(Z, W, E) :-
	W is Z - E * 9,
	YZ is mod(Z, 8),
	YW is mod(W, 8),
	YW =< YZ,
	tablero(M),
	get(M, W, F),
	F = '  '.

diagonalNW(Z, W, E) :-
	tablero(M),
	Z1 is Z - E * 9,
	Z1 >= 0,
	YZ is mod(Z, 8),
	YW is mod(Z1, 8),
	YW =< YZ,
	get(M, Z1, F),
	F = '  ',
	E1 is E + 1,
	diagonalNE(Z, W, E1).

diagonalNE(Z, W, E) :-
	W is Z - E * 7,
	YZ is mod(Z, 8),
	YW is mod(W, 8),
	YW >= YZ,
	tablero(M),
	get(M, W, F),
	F = '  '.

diagonalNE(Z, W, E) :-
	tablero(M),
	Z1 is Z - E * 7,
	Z1 >= 0,
	YZ is mod(Z, 8),
	YW is mod(Z1, 8),
	YW >= YZ,
	get(M, Z1, F),
	F = '  ',
	E1 is E + 1,
	diagonalNW(Z, W, E1).

diagonalSE(Z, W, E) :-
	W is Z + E * 9,
	YZ is mod(Z, 8),
	YW is mod(W, 8),
	YW >= YZ,
	tablero(M),
	get(M, W, F),
	F = '  '.

diagonalSE(Z, W, E) :-
	tablero(M),
	Z1 is Z + E * 9,
	Z1 =< 63,
	YZ is mod(Z, 8),
	YW is mod(Z1, 8),
	YW >= YZ,
	get(M, Z1, F),
	F = '  ',
	E1 is E + 1,
	diagonalSE(Z, W, E1).

diagonalSW(Z, W, E) :-
	W is Z + E * 7,
	YZ is mod(Z, 8),
	YW is mod(W, 8),
	YW =< YZ,
	tablero(M),
	get(M, W, F),
	F = '  '.

diagonalSW(Z, W, E) :-
	tablero(M),
	Z1 is Z + E * 7,
	Z1 =< 63,
	YZ is mod(Z, 8),
	YW is mod(Z1, 8),
	YW =< YZ,
	get(M, Z1, F),
	F = '  ',
	E1 is E + 1,
	diagonalSW(Z, W, E1).

jugada_valida(_, _, _, _) :- !,
	write('No es una jugada valida.'),
	nl,
	fail.

jugada_valida_peon(Z, W):-
	des_peon(E),
	diagonal(Z, W, E),
	!.

jugada_valida_reina(Z, W) :-
	diagonal(Z, W).

% Come
come(Z, W) :-
	tablero(M),
	get(M, Z, E),
	es_reina(E),
	!,
	come_reina(Z, W).

come(Z, W) :-
	tablero(M),
	get(M, Z, E),
	not(es_reina(E)),
	!,
	come_peon(Z, W).

come_reina(Z, W) :-
	tablero(M),
	X is div(Z, 8),
	%write('X: '),write(X),nl,
	Y is mod(Z, 8),
	%write('Y: '),write(Y),nl,
	uno(N),
	XF is X + N,
	%write('XF: '),write(XF),nl,
	XF < 7,
	XFF is XF + N,
	%write('XFF: '),write(XFF),nl,
	uno(E),
	YF is Y + E,
	%write('YF: '),write(YF),nl,
	YFF is YF + E,
	%write('YFF: '),write(YFF),nl,
	YF < 7,
	YF > 0,
	get(M, XF, YF, E1),
	not_ficha(E1),
	get(M, XFF, YFF, E2),
	E2 = '  ',
	W is XFF *8 + YFF.

come_peon(Z, W) :- 
	tablero(M),
	X is div(Z, 8),
	%write('X: '),write(X),nl,
	Y is mod(Z, 8),
	%write('Y: '),write(Y),nl,
	des_peon(N),
	XF is X + N,
	%write('XF: '),write(XF),nl,
	XF < 7,
	XFF is XF + N,
	%write('XFF: '),write(XFF),nl,
	uno(E),
	YF is Y + E,
	%write('YF: '),write(YF),nl,
	YFF is YF + E,
	%write('YFF: '),write(YFF),nl,
	YF < 7,
	YF > 0,
	get(M, XF, YF, E1),
	not_ficha(E1),
	get(M, XFF, YFF, E2),
	E2 = '  ',
	W is XFF *8 + YFF.