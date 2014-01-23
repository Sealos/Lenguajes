obtener_jugadas(Z, LW) :-
	findall(X, jugada_valida(Z, X), LW).

obtener_jugadas_disponibles(L, S) :-
	maplist(obtener_jugadas, L, S).

convertir_X_Y_L([], pos(0, 0)).

convertir_X_Y_L([N|_], pos(X, Y)) :-
	X is div(N, 8) + 1,
	Y is mod(N, 8) + 1.

convertir_X_Y(N, pos(X, Y)) :-
	X is div(N, 8) + 1,
	Y is mod(N, 8) + 1.

existe_saltos([H|Y]) :-
	H = [],
	!,
	existe_saltos(Y).
existe_saltos([_|_]) :- !.

jugar_maquina(Z, W) :-
	fichas_jugador_actual(L),
	saltos_jugador_actual(L, S),
	obtener_jugadas_disponibles(L, J),
	jugar_maquina_aux(L, S, J, Z, W),
	convertir_X_Y(Z, A),
	convertir_X_Y(W, B),
	write('Jugada maquina: '),write(A),write(' ->'),write(B),nl.

jugar_maquina_aux(L, S, _, Z, W) :-
	existe_saltos(S),
	!,
	primera_jugada(L, S, Z, W).

jugar_maquina_aux(L, _, J, Z, W) :-
	primera_jugada(L, J, Z, W).

primera_jugada([H|_], [X|_], Z, W) :-
	X \= [],
	!,
	Z is H,
	head(X, W).

primera_jugada([_|T], [_|Y], Z, W) :-
	primera_jugada(T, Y, Z, W).

head([X|_], X).