% Try POH
% author: Leonardone @ NEETSDKASU
-module(main).
-export([main/1,ngs/1,ngi/1,ngss/1,ngis/1,repeat/2]).
-import(io,[format/2]).
-import(lists,[seq/2,sublist/3,nthtail/2,takewhile/2,map/2,foldl/3,foldr/3]).

ti(S) -> {V,_} = string:to_integer(S), V.
gs() -> string:strip(io:get_line(""), right, $\n).
gi() -> ti(gs()).
gss() -> string:tokens(gs(), " ").
gis() -> map(fun ti/1, gss()).
ngt(_,0) -> []; ngt(F,N) -> [F()|ngt(F,N-1)].
ngs(N) -> ngt(fun gs/0,N).
ngi(N) -> ngt(fun gi/0,N).
ngss(N) -> ngt(fun gss/0,N).
ngis(N) -> ngt(fun gis/0,N).
repeat(0, _) -> ok;
repeat(N, F) -> F(N), repeat(N-1,F).
% --------------------------------------------------------


main(_) ->
    N = gi(),
    TS = ngss(N),
    {P,X,C} = foldl(fun ([T,S],{P,X,C}) ->
        H = ti(T),
        A = if S == "out" -> 3; true -> 5 end,
        if
            X == 0 -> {H, A, C};
            true ->
                Df = H - P,
                Z = max(X - Df, 0),
                {H, Z + A, C + X - Z}
            end
        end, {0, 0, 0}, TS),
    Answer = 24 + if X == 0 -> C; true ->
            Df = 24 - P,
            Z = max(X -Df, 0),
            C + X - Z
        end,
    format("~w~n", [Answer]),
    halt().

