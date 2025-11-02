sort_list([],[]) :- !.
sort_list([A],[A]) :- !.
sort_list([A,B|R],S) :-
  split([A,B|R],L1,L2),
  sort_list(L1,S1),
  sort_list(L2,S2),
  merge(S1,S2,S),
  !.
split([],[],[]).
split([A],[A],[]).
split([A,B|R],[A|Ra],[B|Rb]) :- split(R,Ra,Rb).
merge(A,[],A).
merge([],B,B).
merge([A|Ra],[B|Rb],[A|M]) :- A =< B, merge(Ra,[B|Rb],M).
merge([A|Ra],[B|Rb],[B|M]) :- A > B, merge([A|Ra],Rb,M).
