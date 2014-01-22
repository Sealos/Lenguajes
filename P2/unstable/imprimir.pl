print_line([], _).
print_line([H|T], X) :- !,
	write(X),
	write(H),
	write(X),
	print_line(T, X).

print_matrix(_, 8, 9) :- !.
print_matrix(X, N, 9) :- !,
	N1 is N + 1,
	nl,
	write(N1),
	write(' '),
	print_matrix(X, N1, 1).
print_matrix([H|T], N, X) :- !,
	write('|'),
	write(H),
	write('|'),
	write(' '),
	X1 is X + 1,
	print_matrix(T, N, X1).

imprimir_tablero() :- !,
	write('  '),
	print_line([1,2,3,4,5,6,7,8], '  '),
	tablero(X),
	nl,
	write(1),
	write(' '),
	print_matrix(X, 1, 1).