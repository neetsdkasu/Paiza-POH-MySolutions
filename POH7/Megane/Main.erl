% Try POH
% author: Leonardone @ NEETSDKASU
-module(main).
-export([main/1,ngs/1,ngi/1,ngss/1,ngis/1]).
-import(io,[format/2]).
-import(lists,[sort/1,seq/2,foldl/3,sublist/3,append/2,flatten/1,split/2,nthtail/2,takewhile/2]).

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
    Q = flatten(ngis(M)),
    T = length(takewhile(fun(E) -> E /= Q end, ggg(N,M,P))),
    NM = N - M + 1,
    Y = T div NM,
    X = T rem NM,
    format("~w ~w\n",[Y, X]),
    halt().

hhh(_,_,[]) -> [];
hhh(M,P,[X|XS]) -> [fff(X,M,P)|hhh(M,P,XS)].

ggg(N,M,P) when length(P) < M -> [];
ggg(N,M,P) -> append(hhh(M,P,seq(1,N-M+1)),ggg(N,M,nthtail(1,P))).

fff(I,M,P) ->
    {F,_} = split(M,P),
    foldl(fun(Pt,R)->append(R,sublist(Pt,I,M)) end,[],F).


