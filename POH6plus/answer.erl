-module(main).
-export([main/1]).

main([_]) ->
    N = io:get_line(""),
    [{W}|T] = lists:sort(getlines()),
    io:format("~s",[lists:reverse(W)]),
    init:stop().


%% chompっていうか右端1文字削り
chomp([X|[]]) -> [];
chomp([H|T]) -> [H|chomp(T)].

%% 複数行取得、文字列連結にならんようにタプルで囲む
getlines() -> getlines([]).
getlines(Result) ->
    case io:get_line("") of
        eof -> Result;
        {error, X} -> {error, X};
        W -> getlines([{chomp(W)}|Result])
    end.
        
