obtener_jugadas(Z, LW) :-
	findall(X, jugada_valida(Z, X), LW).

obtener_jugadas_disponibles(L, S) :-
	maplist(obtener_jugadas, L, S),
	maplist(convertir_X_Y, L, P),
	maplist(convertir_X_Y_L, S, K),
	write(P),nl,
	write(K),nl,
	write(L),nl,
	write(S),nl.

convertir_X_Y_L([], pos(0, 0)).

convertir_X_Y_L([N|_], pos(X, Y)) :-
	X is div(N, 8) + 1,
	Y is mod(N, 8) + 1.

convertir_X_Y(N, pos(X, Y)) :-
	X is div(N, 8) + 1,
	Y is mod(N, 8) + 1.



jugar_maquina :-
	maquina,
	% hacer aqui las jugadas validas
	!.

jugar_maquina.
