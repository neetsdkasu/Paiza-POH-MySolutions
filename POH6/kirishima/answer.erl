%
% 結果 https://paiza.jp/poh/joshibato/kirishima/result/936a46c4
%
-module(main).
-export([main/1]).
-import(string,[to_integer/1,tokens/2,join/2]). % インポートしてるけど1箇所でしか使ってないからあまり意味ない件
-import(io,[get_line/1,fwrite/2]).
-import(lists,[map/2]).
-import(init,[stop/0]).

cint(X) -> {Y,_} = to_integer(X), Y. % POHだし関数失敗のエラートラップはしません
gets() -> get_line("").

main(_) ->
    N = cint(gets()),
    T = map(fun cint/1,tokens(gets()," \n")),
    M = cint(gets()),
    fwrite("~s",[join(solve(M, T), "\n")]),
    stop(). % halt()のほうが早く終わる

solve(0, _) -> [];
solve(M, T) -> [simulate(cint(gets()),[],T)] ++ solve(M - 1, T).

simulate(D, [], _) when D < 1 -> "No";
simulate(D, _, [0]) when D > 0 -> "No";
simulate(0, _, [0]) -> "Yes";
simulate(0, _, [0|_]) -> "No";
simulate(0, F, [B|BS]) -> simulate(B, F, [0|BS]);
simulate(D, [F|FS], B) when D < 0 -> simulate(D + 1, FS, [F|B]);
simulate(D, F, [B|BS]) when D > 0 -> simulate(D - 1, [B|F], BS).
