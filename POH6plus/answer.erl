-module(main).
-export([main/1]).

main([_]) ->
    N = io:get_line(""),
    [{W}|T] = getlines(),
    io:format("~s",[W]),
    init:stop().


getlines() -> getlines([]).
    
getlines(Result) ->
    case io:get_line("") of
        eof -> Result;
        {error, X} -> [{X}];
        W -> getlines([{W}|Result])
    end.
        
