-module(main).
-export([main/1]).

main([_]) ->
    [{N}|W] = lists:sort(getlines()),
    io:format("~s",[solve(W)]),
    init:stop().

solve(S) -> solve(S,"","").
solve([],L,C) ->
    L ++ C ++ lists:reverse(L);
solve([{H}|T],L,C) ->
    R = lists:reverse(H),
    case lists:keyfind(R,1,T) of
        {X} ->
            solve(lists:keydelete(X,1,T),L++H,C);
        false ->
            if
                (H == R) and ((C == "") or (H < C)) ->
                    solve(T,L,H);
                true ->
                    solve(T,L,C)
            end
    end.

%% 複数行取得、文字列連結にならんようにタプルで囲む
getlines() -> getlines([]).
getlines(Result) ->
    case io:get_line("") of
        eof -> Result;
        {error, X} -> {error, X};
        W -> getlines([{lists:delete($\n,W)}|Result])
    end.
        
