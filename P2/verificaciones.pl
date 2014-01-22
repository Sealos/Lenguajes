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
	not(ficha(E1)),
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
	not(ficha(E1)),
	get(M, XFF, YFF, E2),
	E2 = '  ',
	W is XFF *8 + YFF.