% Try POH
% author: Leonardone @ NEETSDKASU
-module(main).
-export([main/1,ti/1,gs/0,gi/0,gss/0,gis/0]).
-import(io,[format/2]).
-import(lists,[sort/1]).

ti(S) -> {V,_} = string:to_integer(S), V.
gs() -> io:get_line("").
gi() -> ti(gs()).
gss() -> string:tokens(gs(), " ").
gis() -> lists:map(fun ti/1, gss()).

main(_) ->
    [X,Y,Z,N] = gis(),
    {XS,YS} = getdata(N,[0,X],[0,Y]),
    Xmin = minval(XS,X),
    Ymin = minval(YS,Y),
    Ans = Xmin * Ymin * Z,
    format("~w\n",[Ans]),
    halt().
    
minval([A|[B|T]],M) -> minval([B|T], min(B-A,M));
minval(_,M) -> M.

getdata(0,XS,YS) -> {sort(XS),sort(YS)};
getdata(N,XS,YS) ->
    [D,A] = gis(),
    if D == 0 -> getdata(N-1,[A|XS],YS); true -> getdata(N-1,XS,[A|YS]) end.
