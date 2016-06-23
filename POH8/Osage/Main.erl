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
    M = gi(),
    T = ngi(M),
    {R,I} = lists:foldl(fun (X,{Y,Z}) -> 
        {Y - X, if X > Y -> Z; true -> Z + 1 end}
        end, {N * 60, 0}, T),
    if R < 0 -> format("~w~n", [I]); true -> format("OK", []) end,
    halt().

