:- [damas].

suffix(S,L)
	:-  append(_,S,L).
prefix(P,L)
	:-  append(P,_,L).
sublist(SubL,L)
	:-  suffix(S,L),  prefix(SubL,S).