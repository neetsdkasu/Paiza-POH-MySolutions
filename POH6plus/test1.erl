-module(main).
-export([main/1]).
-import(string,[copies/2,concat/2,tokens/2]).
-import(io,[get_chars/2,format/2]).
-import(lists,[reverse/1,max/1]).

main(_) ->
    [N|W] = tokens(get_chars("",20000)," \n"),
    format("~s",[solve(W)]),
    halt().

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
        X when X > 1 -> % 左の木が深過ぎ
            {_, KVL, LL, LR, _} = L,
            LLD = map_depth(LL),
            LRD = map_depth(LR),
            if
                LLD > LRD -> % 左の木の左が深いなら左の木を上げる
                    NR = map_rotate({map, KV, LR, R, 0}),
                    {map, KVL, LL, NR, max([LLD|[map_depth(NR)]]) + 1};
                true -> % 左の木の右が深いなら左の木の右を上げる
                    {_, KVLR, LRL, LRR, _} = LR,
                    NR = map_rotate({map, KV, LRR, R, 0}),
                    NL = map_rotate({map, KVL, LL, LRL, 0}),
                    {map, KVLR, NL, NR, max([map_depth(NL)|[map_depth(NR)]]) + 1}
            end;
        X when X < -1 -> % 右の木が深過ぎ
            {_, KVR, RL, RR, _} = R,
            RLD = map_depth(RL),
            RRD = map_depth(RR),
            if
                RLD > RRD -> % 右の木の左が深いなら右の木の左を上げる
                    {_, KVRL, RLL, RLR, _} = RL,
                    NR = map_rotate({map, KVR, RLR, RR, 0}),
                    NL = map_rotate({map, KV, L, RLL, 0}),
                    {map, KVRL, NL, NR, max([map_depth(NL)|[map_depth(NR)]]) + 1};
                true -> % 右の木の右が深いなら右の木を上げる
                    NL = map_rotate({map, KV, L, RL, 0}),
                    {map, KVR, NL, RR, max([RRD|[map_depth(NL)]]) + 1}
            end;
        _Else ->
            D = if LD > RD -> LD; true -> RD end,
            {map, KV, L, R, D + 1}
    end.

map_depth({map, _, _, _, D}) -> D;
map_depth(emptymap) -> 0.

map_data(emptymap) -> [];
map_data({map, KV, L, R, _}) -> map_data(L) ++ [KV] ++ map_data(R).

