:- dynamic juego_init/0, turno/0, maquina/0, tablero/1, tablero/0.
:- [imprimir, verificaciones, ai].

% Tablero Inicial
tablero([
	'  ','< ','  ','< ','  ','< ','  ','< ',
	'< ','  ','< ','  ','< ','  ','< ','  ',
	'  ','< ','  ','< ','  ','< ','  ','< ',
	'  ','  ','  ','  ','  ','  ','  ','  ',
	'  ','  ','  ','  ','  ','  ','  ','  ',
	'> ','  ','> ','  ','> ','  ','> ','  ',
	'  ','> ','  ','> ','  ','> ','  ','> ',
	'> ','  ','> ','  ','> ','  ','> ','  '
]).

casillas_corona_negra([2,4,6,8]).
casillas_corona_blanca([57,59,61,63]).

lvacia([]).
turno.

% Devuelve el elemento que se encuentra en el indice X
get(M, X, E) :-
	nth0(X, M, E).

get(M, X, Y, E) :-
	Z is (X * 8) + Y,
	get(M, Z, E).

% Cambia el turno y ficha del jugador de fichas negras
cambiar_jugador :-
	turno,
	!,
	retract(turno),
	existe_salto,
	write('Juegan las fichas negras (>> | >): '),
	nl.

% Cambia el turno y ficha del jugador de fichas blancas
cambiar_jugador :-
	not(turno),
	!,
	assert(turno),
	write('Juegan las fichas blancas (<< | <): '),
	nl,
	(
		(
			maquina,
			jugar_maquina(Z, W),
			jugada(Z, W)
		)
	;
		(
			not(maquina)
		)
	).
	
% Inicia el juego
jugar :-
	not(juego_init),
	write('Desea jugar contra la maquina (s/n)? '),
	read(M),
	write(M),
	nl,
	revisar_maquina(M),
	!,
	imprimir_tablero,
	assert(juego_init),
	cambiar_jugador,
	nl.

% El juego ya esta iniciado
jugar:-
	write('Ya inicio un juego.'),
	!.

% Verifica si existe salto y provee las fichas disponibles para realizarlo.
existe_salto:-
	fichas_jugador_actual(L), 
	saltos_jugador_actual(L,S), 
	not(maplist(lvacia,S)), 
	write(' Hay saltos disponibles, elija la ficha: '),
	nl, 
	fichas_salto(L,S).

% Recibe la coordenada inicial y final de ficha en terminos del desplazamiento lineal (Tablero como una lista).
jugada(Z, W) :-
	Z1 is Z + 1,
	W1 is W + 1,
	(
		(
			come(Z,W)
		)
	;
		(
			not(come(Z,W)),
			jugada_valida(Z, W),
			procesar_tablero(Z1, W1)
		)
	).
% Recibe la coordenada inicial y final de la ficha para jugar.
jugada(X1, Y1, X2, Y2) :-
	
	juego_init,
	X1 > 0,
	X1 < 9,
	Y1 > 0,
	Y1 < 9,
	X2 > 0,
	X2 < 9,
	Y2 > 0,
	Y2 < 9,
	Z is X1*8 + Y1 - 9,
	W is X2*8 + Y2 - 9,
	Z1 is Z + 1,
	W1 is W + 1,
	(
		(
			come(Z,W)
		)
	;
		(
			not(come(Z,W)),
			jugada_valida(Z, W),
			procesar_tablero(Z1, W1)
		)
	).

% Indica jugada invalida
jugada(_, _, _, _) :-
	juego_init,
	write('Jugada invalida, intente nuevamente.'),
	nl.

% Caso de usar el predicado jugada antes del predicado jugar.
jugada(_,_,_,_) :- !,
	not(juego_init),
	write('No ha iniciado el juego, inicie con jugar'),
	nl.
	
% Preparacion para actualizar el tablero antes y despues de una jugada.
procesar_tablero(Z, W):-
	tablero(M),
	%Procesar
	write('Movimiento: '),
	nl,
	actualizar_tablero(Z, W, M2),
	retract(tablero(M)), 
	assert(tablero(M2)),

	imprimir_tablero,
	cambiar_jugador.

% Preparacion para actualizar el tablero antes y despues de un salto.
procesar_tablero_come(Z,W,XS,YS):-
	tablero(M),
	%Procesar
	nl,
	write('Movimiento: '),
	nl,
	actualizar_tablero_come(Z, W, XS, YS, M3),
	retract(tablero(M)), 
	assert(tablero(M3)),
	imprimir_tablero,
	fichas_otro_jugador(L);
	(
		(
			L = [], % No hay mas fichas
			imprimir_jugador,
			retract(juego_init)
		)
		;
		(
			L \= [],
			cambiar_jugador
		)
	).

% Dada una lista, un indice, y un elemento, reemplaza dicho elemento de la lista en el indice dado.	
reemplazar([_|T], 1, X, [X|T]).
reemplazar([H|T], I, X, [H|R]) :-
	I > 1,
	I1 is I-1, 
	reemplazar(T, I1, X, R).

% Refleja en el tablero la jugada hecha actualmente.
actualizar_tablero(Z, W, M2) :-
	tablero(M),
	Z1 is Z-1,
	get(M, Z1, F),
	reemplazar(M, Z, '  ', M1),
 
	(
	(
		(

			casillas_corona_negra(R),
			member(W,R),
			reemplazar(M1, W, '>>', M2)
		)
	;
		(

			casillas_corona_blanca(R),
			member(W,R),
			reemplazar(M1, W, '<<', M2)

		)
	);
	reemplazar(M1 , W , F , M2)).

% Refleja en el tablero el salto hecho actualmente.
actualizar_tablero_come(Z, W, XS, YS, M3) :-
	tablero(M),
	Z1 is Z-1,
	get(M, Z1, F),
	C is XS*8 + YS - 9,
	C1 is C + 1,
	reemplazar(M, Z, '  ', M1), 
	reemplazar(M1, W, F, M2),
	reemplazar(M2, C1,'  ',M3).

% Dada una lista de fichas, y otra con las casillas despues de hacer un salto
% imprime en pantalla la lista de fichas que pueden comer actualmente.
fichas_salto([],[]).
fichas_salto([X|Y],[H|T]):- 
	(lvacia(H), fichas_salto(Y,T));
	((not(lvacia(H))),
	XF is div(X, 8) + 1,
	YF is mod(X, 8) + 1,
	write('('),write(XF),tab(1),
	write(YF),write(')'),tab(1),
	fichas_salto(Y,T)).