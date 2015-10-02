-module(main).
-export([main/1]).

main(_) ->
    [N|W] = getlines(),
    M = mapping(W),
    io:format("~w",[M]),
    init:stop().
    
mapping(W) -> mapping(W, map_new()).
mapping([], M) -> M;
mapping([H|T], M) ->
    R = lists:reverse(H),
    {K, KR} = if H < R -> {H, R}; true -> {R, H} end,
    X = case map_get(K,M) of
            {ok, {V, _}} -> V + 1;
            nothing -> 1
        end,
    mapping(T, map_put(K,{X, KR},M)).

comp([],[]) -> eq;
comp(_,[]) -> gt;
comp([],_) -> lt;
comp([A|B],[C|D]) -> if A < C -> lt; A > C -> gt; true -> comp(B,D) end.

map_new() -> emptymap.

map_get(FK, {map, {K,V}, L, R, D}) ->
    case comp(FK, K) of
        eq -> {ok, V};
        lt -> map_get(FK, L);
        gt -> map_get(FK, R)
    end;
map_get(_, emptymap) -> nothing.

map_put(NK,NV, {map, {K,V}, L, R, D}) ->
    case comp(NK, K) of
        eq -> {map, {K, NV}, L, R, D};
        lt -> map_rotate({map, {K, V}, map_put(NK,NV,L), R, D});
        gt -> map_rotate({map, {K, V}, L, map_put(NK,NV,R), D})
    end;
map_put(NK,NV, emptymap) -> {map, {NK, NV}, emptymap, emptymap, 1}.


map_rotate({map, KV, L, R, _}) ->
    LD = map_depth(L),
    RD = map_depth(R),
    case LD - RD of
        X when X > 1 ->
            {_, KVL, LL, RL, _} = L,
            {map, KVL, LL, {map, KV, RL, R, RD + 1}, LD};
        Y when Y < -1 ->
            {_, KVR, LR, RR, _} = R,
            {map, KVR, {map, KV, L, LR, LD + 1}, RR, RD};
        _Else ->
            D = if LD > RD -> LD; true -> RD end,
            {map, KV, L, R, D + 1}
    end.

map_depth({map, _, _, _, D}) -> D;
map_depth(emptymap) -> 0.

map_keys(emptymap) -> [];
map_keys({map, {K, _}, L, R, _}) -> map_keys(L) ++ [K] ++ map_keys(R).

%% 複数行取得、文字列連結にならんようにタプルで囲む
getlines() -> getlines([]).
getlines(Result) ->
    case io:get_line("") of
        eof -> Result;
        {error, X} -> {error, X};
        W -> getlines(Result ++ [lists:delete($\n,W)])
    end.
