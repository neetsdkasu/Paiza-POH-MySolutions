%% 
%% 結果 https://paiza.jp/poh/joshibato/tsubame/result/d309040b
%% 
-module(main).
-export([main/1]).
-import(string,[to_integer/1, substr/3]).

main(_) ->
    case io:get_line("") of
        eof -> eof;
        {error, E} -> {error, E};
        N_str -> case to_integer(N_str) of
        {error, E} -> {error, E};
        {N, _} -> case to_integer(substr(N_str,1,1)) of
        {error, E} -> {error, E};
        {N1, _} -> case to_integer(substr(N_str,2,1)) of
        {error, E} -> {error, E};
        {N10, _} -> R = N + N1 + N10,
                    io:format("~w",[R])
                end
            end
        end
    end,
    init:stop().
