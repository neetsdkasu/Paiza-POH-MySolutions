% Try POH
% author: Leonardone @ NEETSDKASU
-module(main).
-export([main/1,ngs/1,ngi/1,ngss/1,ngis/1]).
-import(io,[format/2]).
-import(lists,[seq/2,sublist/3,nthtail/2,takewhile/2,map/2]).

ti(S) -> {V,_} = string:to_integer(S), V.
gs() -> io:get_line("").
gi() -> ti(gs()).
gss() -> string:tokens(gs(), " ").
gis() -> lists:map(fun ti/1, gss()).
ngt(_,0) -> []; ngt(F,N) -> [F()|ngt(F,N-1)].
ngs(N) -> ngt(fun gs/0,N).
ngi(N) -> ngt(fun gi/0,N).
ngss(N) -> ngt(fun gss/0,N).
ngis(N) -> ngt(fun gis/0,N).

main(_) ->
    N = gi(),
    P = ngis(N),
    M = gi(),
    Q = ngis(M),
    T = length(takewhile(fun(E) -> E /= Q end, subpics(N,M,P))),
    NM = N - M + 1,
    Y = T div NM,
    X = T rem NM,
    format("~w ~w\n",[Y,X]),
    halt().

xparts(_,_,[]) -> [];
xparts(M,P,[X|XS]) -> [cutpic(X,M,P)|xparts(M,P,XS)].

subpics(_,M,P) when length(P) < M -> [];
subpics(N,M,P) -> xparts(M,P,seq(1,N-M+1)) ++ subpics(N,M,nthtail(1,P)).

cutpic(I,M,P) -> map(fun(E) -> sublist(E,I,M) end, sublist(P,1,M)).
