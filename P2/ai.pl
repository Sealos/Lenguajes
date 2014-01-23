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

jugar_maquina :-
	fichas_jugador_actual(L),
	saltos_jugador_actual(L, S),
	obtener_jugadas_disponibles(L, J),
	jugar_maquina_aux(L, S, J).

jugar_maquina_aux(L, S, _) :-
	existe_saltos(S),
	!,
	primera_jugada(L, S, Z, W),
	write('Encontre salto, jugando : '),
	write(Z),write(' '),write(W),nl.
	%jugada(Z, W). %hacer predicado

jugar_maquina_aux(L, _, J) :-
	write('No encontre salto : '),nl,
	write(L),nl,write(J),nl,
	primera_jugada(L, J, Z, W),
	write('Encontre movida, jugando : '),
	write(Z),write(' '),write(W),nl.
	%jugada(Z, W). % hacer predicado

primera_jugada([H|_], [X|T], Z, W) :-
	write(H),nl,
	write(X),nl,
	X \= [],
	!,
	Z is H,
	head(X, W).

head([X|_], X).

primera_jugada([_|T], [_|Y], Z, W) :-
	primera_jugada(T, Y, Z, W).