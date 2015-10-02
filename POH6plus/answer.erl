-module(main).
-export([main/1]).

main(_) ->
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

split(S) -> split(S,"",[]).
split([],"",L) -> L;
split([],W,L) -> [{W}|L];
split([$\n|T],"",L) -> split(T,"",L);
split([$\n|T],W,L) -> split(T,"",[{W}|L]);
split([H|T],W,L) -> split(T,[H|W],L).
    

%% 複数行取得、文字列連結にならんようにタプルで囲む
getlines() ->
    case io:get_chars("",20000) of
        eof -> eof;
        {error, E} -> {error, E};
        S -> split(S)
    end.

        
