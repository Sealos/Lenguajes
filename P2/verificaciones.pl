% Es ficha blanca?
blanca('< ').
blanca('<<').

% Es ficha negra?
negra('> ').
negra('>>').

% Es ficha reina?
es_reina('<<').
es_reina('>>').

% Habilita jugar contra la maquina
revisar_maquina('s') :-
	assert(maquina).
% Habilita jugar contra la maquina
revisar_maquina(_).

% Verifica si la ficha es de tuya
ficha(F) :-
	turno,
	blanca(F),
	!.
% Verifica si la ficha es de tuya
ficha(F) :-
	not(turno),
	negra(F),
	!.
% Verifica si la ficha es de tu contrincante
not_ficha(F) :-
	turno,
	negra(F),
	!.
% Verifica si la ficha es de tu contrincante
not_ficha(F) :-
	not(turno),
	blanca(F),
	!.
% Usado para calcular la direccion de desplazamiento de los peones
des_peon(X) :- 
	not(turno),
	!,
	X is -1.
% Usado para calcular la direccion de desplazamiento de los peones
des_peon(X) :- 
	turno,
	!,
	X is 1.

uno(1).
uno(-1).

% Unifica las posiciones de las fichas del jugador actual
fichas_jugador_actual(L) :-
	turno,
	!,
	tablero(M),
	findall(X, get(M, X, '< '), L1),
	findall(Y, get(M, Y, '<<'), L2),
	append(L1, L2, L).
% Unifica las posiciones de las fichas del jugador actual

fichas_jugador_actual(L) :-
	not(turno),
	!,
	tablero(M),
	findall(X, get(M, X, '> '), L1),
	findall(Y, get(M, Y, '>>'), L2),
	append(L1, L2, L).

% Unifica las posiciones de las fichas del otro jugador
fichas_otro_jugador(L) :-
	not(turno),
	!,
	tablero(M),
	findall(X, get(M, X, '< '), L1),
	findall(Y, get(M, Y, '<<'), L2),
	append(L1, L2, L).

% Unifica las posiciones de las fichas del otro jugador
fichas_otro_jugador(L) :-
	turno,
	!,
	tablero(M),
	findall(X, get(M, X, '> '), L1),
	findall(Y, get(M, Y, '>>'), L2),
	append(L1, L2, L).

% Obtiene los posibles saltos de las posiciones Z
obtener_saltos(Z, LW) :-
	findall(X, come_buscar(Z, X), LW).

% Obtiene los posibles saltos de las posiciones de
% todas las posiciones de L
saltos_jugador_actual(L, S) :-
	maplist(obtener_saltos, L, S).

% Verifica si una jugada es valida...
jugada_valida(Z, W) :-
	tablero(M),
	get(M, W, E),			% El destino tiene que ser vacio
							% Verificar si debe comer? No esta en el enunciado...
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

% Busca en las diagonales NE NW o SE SW
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
% Busca en las diagonales NE NW o SE SW
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

% Cualquier diagonal, para moviemiento de la reina
diagonal(Z, W) :-
	diagonalNE(Z, W, 1);
	diagonalNW(Z, W, 1);
	diagonalSE(Z, W, 1);
	diagonalSW(Z, W, 1).
% Diagonal NW
diagonalNW(Z, W, E) :-
	W is Z - E * 9,
	YZ is mod(Z, 8),
	YW is mod(W, 8),
	YW =< YZ,
	tablero(M),
	get(M, W, F),
	F = '  '.
% Diagonal NW
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
	diagonalNW(Z, W, E1).
% Diagonal NE
diagonalNE(Z, W, E) :-
	W is Z - E * 7,
	YZ is mod(Z, 8),
	YW is mod(W, 8),
	YW >= YZ,
	tablero(M),
	get(M, W, F),
	F = '  '.
% Diagonal NE
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
	diagonalNE(Z, W, E1).
% Diagonal SE
diagonalSE(Z, W, E) :-
	W is Z + E * 9,
	YZ is mod(Z, 8),
	YW is mod(W, 8),
	YW >= YZ,
	tablero(M),
	get(M, W, F),
	F = '  '.
% Diagonal SE
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
% Diagonal SW
diagonalSW(Z, W, E) :-
	W is Z + E * 7,
	YZ is mod(Z, 8),
	YW is mod(W, 8),
	YW =< YZ,
	tablero(M),
	get(M, W, F),
	F = '  '.
% Diagonal SW
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

% Si no es una jugada valida, la imprimimos
jugada_valida(_, _, _, _) :- !,
	write('No es una jugada valida.'),
	nl,
	fail.
% Verificamos si la jugada es valida para el peon
jugada_valida_peon(Z, W):-
	des_peon(E),
	diagonal(Z, W, E),
	!.
% Verificamos si la jugada es valida para la reina
jugada_valida_reina(Z, W) :-
	diagonal(Z, W).

% Come para reina
come(Z, W) :-
	tablero(M),
	get(M, Z, E),
	es_reina(E),
	!,
	come_reina(Z, W).
% Come para peon
come(Z, W) :-
	tablero(M),
	get(M, Z, E),
	not(es_reina(E)),
	!,
	come_peon(Z, W).
% Funciones auxiliares para la IA
come_buscar(Z, W) :-
	tablero(M),
	get(M, Z, E),
	es_reina(E),
	!,
	come_reina_buscar(Z, W).
% Funciones auxiliares para la IA
come_buscar(Z, W) :-
	tablero(M),
	get(M, Z, E),
	not(es_reina(E)),
	!,
	come_peon_buscar(Z, W).
% Verifica si se puede comer en todas las direcciones
come_reina(Z, W) :-
	tablero(M),
	X is div(Z, 8),
	Y is mod(Z, 8),
	uno(N),
	XF is X + N,
	XF < 7,
	XFF is XF + N,
	uno(E),
	YF is Y + E,
	YFF is YF + E,
	YF < 7,
	YF > 0,
	get(M, XF, YF, E1),
	not_ficha(E1),
	get(M, XFF, YFF, E2),
	E2 = '  ',
	W is XFF *8 + YFF,
	Z1 is Z + 1,
	W1 is W + 1,
	XF1 is XF+1,
	YF1 is YF+1,
	procesar_tablero_come(Z1, W1, XF1, YF1).
% Verifica si se puede comer en las direcciones del sentido de la ficha
come_peon(Z, W) :- 
	tablero(M),
	X is div(Z, 8),
	Y is mod(Z, 8),
	des_peon(N),
	XF is X + N,
	XF < 7,
	XFF is XF + N,
	uno(E),
	YF is Y + E,
	YFF is YF + E,
	YF < 7,
	YF > 0,
	get(M, XF, YF, E1),
	not_ficha(E1),
	get(M, XFF, YFF, E2),
	E2 = '  ',
	W is XFF *8 + YFF,
	Z1 is Z + 1,
	W1 is W + 1,
	XF1 is XF+1,
	YF1 is YF+1,
	procesar_tablero_come(Z1, W1, XF1, YF1).
% Funciones auxiliares para la IA
come_reina_buscar(Z, W) :-
	tablero(M),
	X is div(Z, 8),
	Y is mod(Z, 8),
	uno(N),
	XF is X + N,
	XF < 7,
	XFF is XF + N,
	uno(E),
	YF is Y + E,
	YFF is YF + E,
	YF < 7,
	YF > 0,
	get(M, XF, YF, E1),
	not_ficha(E1),
	get(M, XFF, YFF, E2),
	E2 = '  ',
	W is XFF *8 + YFF.
% Funciones auxiliares para la IA
come_peon_buscar(Z, W) :- 
	tablero(M),
	X is div(Z, 8),
	Y is mod(Z, 8),
	des_peon(N),
	XF is X + N,
	XF < 7,
	XFF is XF + N,
	uno(E),
	YF is Y + E,
	YFF is YF + E,
	YF < 7,
	YF > 0,
	get(M, XF, YF, E1),
	not_ficha(E1),
	get(M, XFF, YFF, E2),
	E2 = '  ',
	W is XFF *8 + YFF.