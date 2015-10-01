-module(main).
-export([main/1]).

main([_]) ->
    N = io:get_line(""),
    W = lists:sort(getlines()),
    io:format("~s",[W]),
    init:stop().

%% 複数行取得、文字列連結にならんようにタプルで囲む
getlines() -> getlines([]).
getlines(Result) ->
    case io:get_line("") of
        eof -> Result;
        {error, X} -> {error, X};
        W -> getlines([{lists:delete($\n,W)}|Result])
    end.
        
