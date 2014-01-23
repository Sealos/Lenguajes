:- dynamic juego_init/0, turno/0, maquina/0, tablero/1, tablero/0.
:- [imprimir, verificaciones, ai].

tablero([
	'  ','< ','  ','< ','  ','  ','  ','  ',
	'< ','  ','< ','  ','> ','  ','< ','  ',
	'  ','< ','  ','< ','  ','> ','  ','< ',
	'  ','  ','  ','  ','  ','  ','> ','  ',
	'  ','< ','  ','< ','  ','  ','  ','  ',
	'> ','  ','> ','  ','< ','  ','> ','  ',
	'  ','> ','  ','> ','  ','< ','  ','> ',
	'> ','  ','  ','  ','> ','  ','  ','  '
]).

casillas_corona_negra([2,4,6,8]).
casillas_corona_blanca([57,59,61,63]).

lvacia([]).
turno.

get(M, X, E) :-
	nth0(X, M, E).

get(M, X, Y, E) :-
	Z is (X * 8) + Y,
	get(M, Z, E).

cambiar_jugador :-
	not(turno),
	!,
	assert(turno),
	write('Juegan las fichas blancas (<< | <): ').
	% Si es una maquina jugar la maquina
	%jugar_maquina.
cambiar_jugador :-
	turno,
	!,
	retract(turno),
	write('Juegan las fichas negras (>> | >): ').
	%existe_salto.

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

jugar:-
	write('Ya inicio un juego.'),
	!.

existe_salto:-
	fichas_jugador_actual(L), 
	saltos_jugador_actual(L,S), 
	not(maplist(lvacia,S)), 
	write(' Hay saltos disponibles, elija la ficha: '),
	nl, 
	fichas_salto(L,S).

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

jugada(_, _, _, _) :-
	juego_init,
	write('Jugada invalida, intente nuevamente.'),
	nl.

jugada(_,_,_,_) :- !,
	not(juego_init),
	write('No ha iniciado el juego, inicie con jugar'),
	nl.

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

procesar_tablero_come(Z,W,XS,YS):-
	tablero(M),
	%Procesar
	write('Movimiento: '),
	nl,
	actualizar_tablero_come(Z, W, XS, YS, M3),
	retract(tablero(M)), 
	assert(tablero(M3)),
	imprimir_tablero,
	cambiar_jugador.

	
reemplazar([_|T], 1, X, [X|T]).
reemplazar([H|T], I, X, [H|R]) :-
	I > 1,
	I1 is I-1, 
	reemplazar(T, I1, X, R).

actualizar_tablero(Z, W, M2) :-
	tablero(M),
	get(M, W, F),
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

actualizar_tablero_come(Z, W, XS, YS, M3) :-
	tablero(M),
	get(M, W, F),
	C is XS*8 + YS - 9,
	C1 is C + 1,
	reemplazar(M, Z, '  ', M1), 
	reemplazar(M1, W, F, M2),
	reemplazar(M2, C1,'  ',M3).


fichas_salto([],[]).
fichas_salto([X|Y],[H|T]):- 
	(lvacia(H), fichas_salto(Y,T));
	((not(lvacia(H))),
	XF is div(X, 8) + 1,
	YF is mod(X, 8) + 1,
	write('('),write(XF),tab(1),
	write(YF),write(')'),tab(1),
	fichas_salto(Y,T)).