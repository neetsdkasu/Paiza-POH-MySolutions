-module(main).
-export([main/1]).
-import(string,[copies/2,concat/2,tokens/2]).
-import(io,[get_chars/2,format/2]).
-import(lists,[reverse/1,delete/2]).
-import(init,[stop/0]).

main(_) ->
    [N|W] = tokens(get_chars("",20000)," \n"),
    format("~s",[solve(W)]),
    stop().

solve(W) ->
    M = mapping(W),
    palindrome(M, map_data(M)).

palindrome(M, W) -> palindrome(M, W, "", "", "").

palindrome(_, [], L, C, R) -> concat(L, concat(C, R));
palindrome(M, [{H, V}|T], L, C, R) ->
    HR = reverse(H),
    case comp(H, HR) of
        gt -> palindrome(M, T, L, C, R);
        eq -> NC = if (V rem 2 == 1) andalso (C == "") -> H; true -> C end,
              P = copies(H, V div 2),
              palindrome(M, T, concat(L, P), NC, concat(P, R));
        lt -> case map_get(HR, M) of
                  nothing -> palindrome(M, T, L, C, R);
                  {ok, U} -> X = if V < U -> V; true -> U end,
                             P = copies(H, X),
                             PR = copies(HR, X),
                             palindrome(M, T, concat(L, P), C, concat(PR, R))
              end
    end.
                    

mapping(W) -> mapping(W, map_new()).
mapping([], M) -> M;
mapping([H|T], M) ->
    X = case map_get(H,M) of
            {ok, V} -> V + 1;
            nothing -> 1
        end,
    mapping(T, map_put(H, X, M)).

%===========================================
% 以下はマップ実装部(AVL木による実装)
%===========================================
% キーはリスト(文字列)限定
% 値は何でもOK
% 機能は空マップ生成、キーによる値の配置と参照、
% および全データの取得のみ
%  空マップ生成 map_new()
%  配置         map_put( key, value, map )
%  参照         map_get( key, map )
%  全データ取得 map_data( map )

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
            NR = map_rotate({map, KV, RL, R, 0}),  % map_rotateでDepthは使われないので0
            NRD = map_depth(NR),
            LLD = map_depth(LL),
            D = if LLD > NRD -> LLD; true -> NRD end,
            {map, KVL, LL, NR, D + 1};
        Y when Y < -1 ->
            {_, KVR, LR, RR, _} = R,
            NL = map_rotate({map, KV, L, LR, 0}),
            NLD = map_depth(NL),
            RRD = map_depth(RR),
            D = if RRD > NLD -> RRD; true -> NLD end,
            {map, KVR, NL, RR, D + 1};
        _Else ->
            D = if LD > RD -> LD; true -> RD end,
            {map, KV, L, R, D + 1}
    end.

map_depth({map, _, _, _, D}) -> D;
map_depth(emptymap) -> 0.

map_data(emptymap) -> [];
map_data({map, KV, L, R, _}) -> map_data(L) ++ [KV] ++ map_data(R).

