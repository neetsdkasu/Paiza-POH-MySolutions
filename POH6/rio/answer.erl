%
% 結果 https://paiza.jp/poh/joshibato/rio/result/ee921024
%
-module(main).
-export([main/1]).
-import(io, [fwrite/2, get_line/1]).
-import(string, [to_integer/1, tokens/2]).
-import(lists, [map/2]).

% erlang:list_to_integer でも数値変換できるけど末尾に数字以外の文字が入ってるとエラーになる
% cint(X) -> list_to_integer(X).
cint(X) -> {Y, _} = to_integer(X), Y.
gets() -> get_line("").
floor(X) -> cint(float_to_list(X * 10.0, [{decimals, 0}])) div 10.
            

main(_) ->
    N = cint(gets()),
    fwrite("~w", [floor(solve(N, 0.0, 0.0))]), % floorやinteger変換とか分からん
    halt().

solve(0, W, C) -> 100.0 * C / (W + C);
solve(N, W, C) ->
    case map(fun cint/1, tokens(gets(), " \n")) of
        [1|[S]] -> solve(N - 1, W + float(S), C);
        [2|[S]] -> solve(N - 1, W, C + float(S));
        [3|[S]] -> FS = float(S),
                   WC = W + C,
                   solve(N - 1, (W * WC - FS * W) / WC, (C * WC - FS * C) / WC)
    end.
