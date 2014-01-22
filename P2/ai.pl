obtener_jugadas(Z, LW) :-
	findall(X, jugada_valida(Z, X), LW).

obtener_jugadas_disponibles(L, S) :-
	maplist(obtener_jugadas, L, S).

jugar_maquina :-
	maquina,
	% hacer aqui las jugadas validas
	!.

jugar_maquina.