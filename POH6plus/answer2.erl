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
    palindrome(map_data(M)).

palindrome(W) -> palindrome(W,"","","").
palindrome([{W,{N,symmetry}}|T], L, C, R) ->
    NC = if (N rem 2 == 1) and ((C == "") or (W < C)) -> W; true -> C end,
    P = copies(W, N div 2),
    palindrome(T, concat(L, P), NC, concat(P, R));
palindrome([{W,{N,WR}}|T], L, C, R) ->
    P = copies(W, N div 2),
    PR = copies(WR, N div 2),
    palindrome(T, concat(L, P), C, concat(PR, R));
palindrome([], L, C, R) -> concat(L, concat(C, R)).
    

mapping(W) -> mapping(W, map_new()).
mapping([], M) -> M;
mapping([H|T], M) ->
    R = reverse(H),
    {K, KR} = case comp(H, R) of
            eq -> {H, symmetry};
            lt -> {H, R};
            gt -> {R, H}
        end,
    X = case map_get(K,M) of
            {ok, {V, _}} -> V + 1;
            nothing -> 1
        end,
    mapping(T, map_put(K,{X, KR},M)).

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
            map_rotate({map, KVL, LL, map_rotate({map, KV, RL, R, 0}), 0}); % map_rotateでDepthは使われないので0
        Y when Y < -1 ->
            {_, KVR, LR, RR, _} = R,
            map_rotate({map, KVR, map_rotate({map, KV, L, LR, 0}), RR, 0});
        _Else ->
            D = if LD > RD -> LD; true -> RD end,
            {map, KV, L, R, D + 1}
    end.

map_depth({map, _, _, _, D}) -> D;
map_depth(emptymap) -> 0.

map_data(emptymap) -> [];
map_data({map, KV, L, R, _}) -> map_data(L) ++ [KV] ++ map_data(R).

