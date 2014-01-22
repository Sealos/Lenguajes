print_line([], _).
print_line([H|T], '|', N) :- !,
	write('|'),
	write(H),
	write('|'),
	write(' '),
	print_line(T, '|').
print_line([H|T], X, N) :- !,
	write(X),
	write(H),
	write(X),
	print_line(T, X).

print_matrix([], _).
print_matrix([H|T], N) :- !,
	write(N),
	write(' '),
	print_line(H, '|', 7),
	nl,
	N1 is N + 1,
	print_matrix(T, N1).

imprimir_tablero() :- !,
	write('  '),
	print_line([1,2,3,4,5,6,7,8], '  '),
	tablero(X),
	nl,
	print_matrix(X, 1).