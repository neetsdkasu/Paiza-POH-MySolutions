-module(main).
-export([main/1]).

main(_) ->
    [N|W] = lists:sort(string:tokens(io:get_chars("",20000),"\n")),
    io:format("~s",[solve(W)]),
    init:stop().

solve(S) -> solve(S,"","").
solve([],L,C) ->
    L ++ C ++ lists:reverse(L);
solve([H|T],L,C) ->
    R = lists:reverse(H),
    case lists:member(R,T) of
        false ->
            if
                (H == R) and ((C == "") or (H < C)) ->
                    solve(T,L,H);
                true ->
                    solve(T,L,C)
            end;
        _ ->
            solve(lists:delete(R,T),L++H,C)
    end.
