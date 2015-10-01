-module(main).
-export([main/1]).

main([_]) ->
    N = io:get_line(""),
    [{W}|T] = getlines(),
    io:format("~s",[reverse(W)]),
    init:stop().

reverse(S) -> reverse(S,[]).
reverse([],R) -> R;
reverse([H|T],R) -> reverse(T,[H|R]).
    

chomp([X|[]]) -> [];
chomp([H|T]) -> [H|chomp(T)].

getlines() -> getlines([]).
getlines(Result) ->
    case io:get_line("") of
        eof -> Result;
        {error, X} -> {error, X};
        W -> getlines([{chomp(W)}|Result])
    end.
        
