% Try POH
% author: Leonardone @ NEETSDKASU
-module(main).
-export([main/1,ngs/1,ngi/1,ngss/1,ngis/1,repeat/2]).
-import(io,[format/2]).
-import(lists,[seq/2,sublist/3,nthtail/2,takewhile/2,map/2]).

ti(S) -> {V,_} = string:to_integer(S), V.
gs() -> string:strip(io:get_line(""), right, $\n).
gi() -> ti(gs()).
gss() -> string:tokens(gs(), " ").
gis() -> lists:map(fun ti/1, gss()).
ngt(_,0) -> []; ngt(F,N) -> [F()|ngt(F,N-1)].
ngs(N) -> ngt(fun gs/0,N).
ngi(N) -> ngt(fun gi/0,N).
ngss(N) -> ngt(fun gss/0,N).
ngis(N) -> ngt(fun gis/0,N).
repeat(0, _) -> ok;
repeat(N, F) -> F(N), repeat(N-1,F).

order(C) ->
    case C of
        "J" -> 11;
        "Q" -> 12;
        "K" -> 13;
        "A" -> 14;
        "2" -> 15;
        _ -> ti(C)
    end.

solve(_,_,_,_,53,O) -> element(2,lists:unzip(lists:sort(fun ({A,_},{B,_}) -> A =< B end, O)));
solve([],B,I,C,R,O) -> solve(lists:reverse(B),[],I,C,R,O);
solve([{J,A}|AS],B,I,C,R,O) ->
    if
        J == I -> solve(AS,[{J,A}|B],0,0,R,O);
        A =< C -> solve(AS,[{J,A}|B],I,C,R,O);
        true -> solve(AS,[{J,0}|B],J,A,R+1,[{J,R}|O])
    end.
    

main(_) ->
    Cards = gss(),
    Orders = map(fun order/1, Cards),
    Orders_with_Index = lists:zip(seq(1, 52), Orders),
    Answer = solve(Orders_with_Index, [], 0, 0, 1, []),
    map(fun (X) -> format("~w~n", [X]) end, Answer),
    halt().

