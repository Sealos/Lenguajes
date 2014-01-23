% Dado una posicion Z, obtiene todos los posibles movimientos
% sin saltos desde Z, y devuelve una lista con las jugadas
obtener_jugadas(Z, LW) :-
	findall(X, jugada_valida(Z, X), LW).

% Mappea obtener_jugadas a todas las posiciones de fichas L
% y unifica S con la lista de movimientos
obtener_jugadas_disponibles(L, S) :-
	maplist(obtener_jugadas, L, S).

% Convierte de posicion de tablero a (X, Y)
convertir_X_Y(N, pos(X, Y)) :-
	X is div(N, 8) + 1,
	Y is mod(N, 8) + 1.

% Predicado que verifica si para una lista de saltos
% existe algun salto, usado para IA y heuristica
existe_saltos([H|Y]) :-
	H = [],
	!,
	existe_saltos(Y).
existe_saltos([_|_]) :- !.

% Predicado que unifica un Z y W como las posiciones a saltar
% o moverse de una ficha, prefiere saltar a mover
jugar_maquina(Z, W) :-
	fichas_jugador_actual(L),
	saltos_jugador_actual(L, S),
	obtener_jugadas_disponibles(L, J),
	jugar_maquina_aux(L, S, J, Z, W),
	convertir_X_Y(Z, A),
	convertir_X_Y(W, B),
	write('Jugada maquina: '),write(A),write(' ->'),write(B),nl.

% Verifica si existe un salto disponible, y si es asi,
% devuelve el primer salto
jugar_maquina_aux(L, S, _, Z, W) :-
	existe_saltos(S),
	!,
	primera_jugada(L, S, Z, W).

% Si no hay saltos, busca el primer movimento
jugar_maquina_aux(L, _, J, Z, W) :-
	primera_jugada(L, J, Z, W).

% Busca el primer elemento que no es []
primera_jugada([H|_], [X|_], Z, W) :-
	X \= [],
	!,
	Z is H,
	head(X, W).

% Busca el primer elemento que no es []
primera_jugada([_|T], [_|Y], Z, W) :-
	primera_jugada(T, Y, Z, W).

% Cabeza de una lista
head([X|_], X).