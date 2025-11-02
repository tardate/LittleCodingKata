minimum_list([X], X) :- !.
minimum_list([Head|Tail], Min) :-
    minimum_list(Tail, TailMin),
    ( Head < TailMin -> Min = Head ; Min = TailMin ),
    !.
