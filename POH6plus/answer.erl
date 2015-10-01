-module(main).
-export([main/1]).

main([_]) ->
    N = io:get_line(""),
    W = getlines(),
    io:format("~s",[W]),
    init:stop().

chomp([X|[]]) -> [];
chomp([H|T]) -> [H|chomp(T)].

getlines() -> getlines([]).
getlines(Result) ->
    case io:get_line("") of
        eof -> Result;
        {error, X} -> {error, X};
        W -> getlines([{chomp(W)}|Result])
    end.
        
