// Try POH
// author: Leonardone @ NEETSDKASU
(* --------------------------------------------------- *)
let (/%) v d = let dv = v / d in (dv, v - dv * d)
let flip f x y = f y x
let strsplit (str : string) = str.Split
let gs = stdin.ReadLine
let gi = int << gs
let gl = int64 << gs
let gss = gs >> flip strsplit [|' '|]
let gis = gss >> Array.map int
let ngt n f = [| for _ in 1 .. n -> f() |]
let ngs n = ngt n gs
let ngi n = ngt n gi
let ngss n = ngt n gss
let ngis n = ngt n gis
(* --------------------------------------------------- *)

let solve() =
    let modval v = v % 1000000000L
    let rec reject d v c =
        match v /% d with
        | (dv, 0L) ->  reject d dv (c + 1)
        | _ -> (v, c)
    let acc (r, c) v =
        let (x, c1) = reject 5L v 0
        let (y, c2) = reject 2L x -c1
        (modval <| r * y, c + c2)
    let n = gl()
    let (r, c) = seq{ 1L .. n } |> flip Seq.fold (1L, 0) acc
    let ans = Seq.fold (fun r _ -> modval <| r * 2L) r <| seq { 1 .. c }
    printfn "%d" ans


(* --------------------------------------------------- *)
[<EntryPoint>]
let main _ = solve(); 0

;;
