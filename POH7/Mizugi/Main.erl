% Try POH
% author: Leonardone @ NEETSDKASU
-module(main).
-export([main/1,ti/1,gs/0,gi/0,gss/0,gis/0]).
-import(io,[format/2]).

ti(S) -> {V,_} = string:to_integer(S), V.
gs() -> io:get_line("").
gi() -> ti(gs()).
gss() -> string:tokens(gs(), " ").
gis() -> lists:map(fun gi/0, gss()).

main(_) ->
    N = gi(),
    Ans = solve(N,1,0),
    format("~w",[Ans]),
    halt().

reject(V,D,C) when V rem D == 0 -> reject(V div D, D, C + 1);
reject(V,_,C) -> {V, C}.

multiple(R,0) -> R;
multiple(R,C) ->
    V = (R * 2) rem 1000000000,
    multiple(V,C-1).

solve(1,R,C) -> multiple(R,C);
solve(N,R,C) ->
    {X,C1} = reject(N,5,0),
    {Y,C2} = reject(X,2,0),
    Z = (R * Y) rem 1000000000,
    solve(N-1,Z,C+C2-C1).
    
    
    
